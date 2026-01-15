import 'package:ball_physics/core/shared/widgets/base_dialog_widget.dart';
import 'package:ball_physics/core/shared/widgets/dialog_button_builder.dart';
import 'package:ball_physics/core/shared/widgets/glass_card.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:ball_physics/core/theme/app_spacing.dart';
import 'package:ball_physics/features/settings/presentation/widgets/settings_item.dart';
import 'package:ball_physics/features/settings/presentation/widgets/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = packageInfo.version;
      });
    } catch (_) {
      // Ignore error
    }
  }

  Future<void> _resetLocalData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => WillPopScope(
        onWillPop: () async {
          Navigator.of(dialogContext).pop(false);
          return false;
        },
        child: BaseDialogWidget(
          title: 'Reset Local Data',
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Are you sure you want to reset all local data? This action cannot be undone.',
              style: TextStyle(
                color: AppColors.whiteColor.withOpacity(0.9),
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          primaryButton: DialogButtonBuilder.buildPrimaryButton(
            text: 'Reset',
            icon: Icons.delete_outline,
            onTap: () {
              Navigator.of(dialogContext).pop(true);
            },
          ),
          secondaryButton: DialogButtonBuilder.buildSecondaryButton(
            text: 'Cancel',
            icon: Icons.close,
            onTap: () {
              Navigator.of(dialogContext).pop(false);
            },
          ),
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Local data reset successfully')),
          );
        }
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to reset local data')),
          );
        }
      }
    }
  }

  Future<void> _openContact() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@ballphysics.app',
      query: 'subject=Ball Physics Support',
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cannot open email client')),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to open email')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                GlassCard(
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: Icons.info_outline,
                        title: 'App Version',
                        subtitle: _appVersion,
                        onTap: null,
                      ),
                      const Divider(),
                      SettingsItem(
                        icon: Icons.delete_outline,
                        title: 'Reset Local Data',
                        subtitle: 'Clear all saved data',
                        onTap: _resetLocalData,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                GlassCard(
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy & Terms',
                        subtitle: 'View privacy policy and terms of use',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WebViewScreen(
                                title: 'Privacy Policy & Terms',
                                url:
                                    'https://docs.google.com/document/d/1Lz_LQa4oGlXVnJsrJ7JtXM-3JtF-MXfON68VsJz_yYE/preview',
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      SettingsItem(
                        icon: Icons.email_outlined,
                        title: 'Contact',
                        subtitle: 'support@ballphysics.app',
                        onTap: _openContact,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
