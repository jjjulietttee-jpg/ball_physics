import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/leaderboard_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../domain/models/score_record.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.whiteColor, AppColors.menuBackgroundLight],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: screenSize.height * 0.1,
                right: -screenSize.width * 0.15,
                child: Opacity(
                  opacity: 0.08,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => context.pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Leaderboard',
                            style: AppFonts.displayLarge.copyWith(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<ScoreRecord>>(
                      future: LeaderboardService.getLeaderboard(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: AppColors.greyColor.withOpacity(
                                    AppColors.opacity05,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Error loading leaderboard',
                                  style: AppFonts.headlineMedium.copyWith(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final records = snapshot.data ?? [];

                        if (records.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor.withOpacity(
                                      0.1,
                                    ),
                                    border: Border.all(
                                      color: AppColors.primaryColor.withOpacity(
                                        0.3,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.emoji_events_outlined,
                                    size: 56,
                                    color: AppColors.primaryColor.withOpacity(
                                      0.7,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'No scores yet',
                                  style: AppFonts.headlineMedium.copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Play the game to see your scores here',
                                  style: AppFonts.bodyMedium.copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            final record = records[index];
                            final isTopThree = index < 3;
                            final isFirst = index == 0;
                            final isSecond = index == 1;
                            final isThird = index == 2;

                            Color rankColor;
                            if (isFirst) {
                              rankColor = const Color(0xFFFFD700);
                            } else if (isSecond) {
                              rankColor = const Color(0xFFC0C0C0);
                            } else if (isThird) {
                              rankColor = const Color(0xFFCD7F32);
                            } else {
                              rankColor = AppColors.primaryColor;
                            }

                            return Container(
                              margin: EdgeInsets.only(
                                bottom: isTopThree ? 16 : 12,
                                top: isFirst ? 8 : 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.whiteColor,
                                border: Border.all(
                                  color: isTopThree
                                      ? rankColor.withOpacity(0.5)
                                      : AppColors.greyColor.withOpacity(
                                          AppColors.opacity03,
                                        ),
                                  width: isTopThree ? 2.5 : 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isTopThree
                                        ? rankColor.withOpacity(0.3)
                                        : AppColors.shadowBlack12,
                                    blurRadius: isTopThree ? 12 : 6,
                                    offset: Offset(0, isTopThree ? 4 : 2),
                                    spreadRadius: isTopThree ? 1 : 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: isTopThree
                                            ? LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  rankColor,
                                                  rankColor.withOpacity(0.7),
                                                ],
                                              )
                                            : null,
                                        color: isTopThree
                                            ? null
                                            : AppColors.primaryColor
                                                  .withOpacity(0.1),
                                        boxShadow: isTopThree
                                            ? [
                                                BoxShadow(
                                                  color: rankColor.withOpacity(
                                                    0.4,
                                                  ),
                                                  blurRadius: 8,
                                                  spreadRadius: 2,
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child: Center(
                                        child: isTopThree
                                            ? Icon(
                                                isFirst
                                                    ? Icons.emoji_events
                                                    : isSecond
                                                    ? Icons.workspace_premium
                                                    : Icons.military_tech,
                                                color: AppColors.whiteColor,
                                                size: 32,
                                              )
                                            : Text(
                                                '${index + 1}',
                                                style: AppFonts.headlineLarge
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                    ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${record.score}',
                                                style: AppFonts.displayMedium
                                                    .copyWith(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isTopThree
                                                          ? rankColor
                                                          : AppColors
                                                                .primaryColor,
                                                    ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'points',
                                                style: AppFonts.bodyMedium
                                                    .copyWith(
                                                      color:
                                                          AppColors.greyColor,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 14,
                                                color: AppColors.greyColor
                                                    .withOpacity(
                                                      AppColors.opacity06,
                                                    ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                _formatDate(record.timestamp),
                                                style: AppFonts.bodySmall
                                                    .copyWith(
                                                      color: AppColors.greyColor
                                                          .withOpacity(
                                                            AppColors.opacity07,
                                                          ),
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isTopThree)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              rankColor,
                                              rankColor.withOpacity(0.8),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: rankColor.withOpacity(0.3),
                                              blurRadius: 6,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          isFirst
                                              ? '🥇'
                                              : isSecond
                                              ? '🥈'
                                              : '🥉',
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
