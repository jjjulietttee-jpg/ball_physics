import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/base_dialog_widget.dart';
import '../../../../core/shared/widgets/dialog_button_builder.dart';

class PauseDialogWidget extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onMenu;

  const PauseDialogWidget({
    super.key,
    required this.onContinue,
    required this.onMenu,
  });

  void _handleMenu(BuildContext context) {
    onMenu();
  }

  void _handleContinue(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) => onContinue());
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      title: 'Paused',
      primaryButton: DialogButtonBuilder.buildPrimaryButton(
        text: 'Continue',
        icon: Icons.play_arrow_rounded,
        onTap: () => _handleContinue(context),
      ),
      secondaryButton: DialogButtonBuilder.buildSecondaryButton(
        text: 'Menu',
        icon: Icons.home_rounded,
        onTap: () => _handleMenu(context),
      ),
    );
  }
}

