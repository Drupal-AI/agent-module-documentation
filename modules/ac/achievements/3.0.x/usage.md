Achievements is a gamification framework for Drupal that lets you define achievement/badge config entities, award points to users on milestones from custom code, and rank users on per-achievement and site-wide leaderboards.

---

Achievements provides the plumbing for a rewards system but ships no achievements of its own — you create `achievement_entity` config entities in the admin UI (label, description, points, secret/invisible flags, and unlocked/locked badge images) and then call the module's PHP API (`achievements_unlocked()`, `achievements_storage_get()/_set()`) from your own module's entity, node, comment, or event hooks to grant them. Unlocks are recorded in three custom tables (`achievement_unlocks`, `achievement_totals`, `achievement_storage`); a site-wide leaderboard ranks users by total points with ties broken by who reached the total first, and each achievement has its own "first to unlock" and "most recent" leaderboard. Leaderboards and the per-user achievements tab are Views (`achievement_totals`, `achievement_unlocks`) shipped in config, so they can be re-themed or extended like any view. Achievements can be marked secret (shown as placeholder text until unlocked) or invisible (hidden entirely until unlocked), and unlock notifications fade in at the corner of the window on the visitor's next page load. Permissions gate who can access, earn, and administer achievements. It depends on core `file` plus the `jquery_ui_effects` and `jquery_ui_dialog` contrib modules for the notification animation and dialog.

---

- Reward users with points and a badge for posting their first comment, 50 comments, and 100 comments (progressive milestones sharing one storage counter).
- Award an achievement for creating a certain number of nodes, forum topics, or other content.
- Give a "daily visitor" achievement to users who visit the site every day of a week.
- Build a site-wide leaderboard page ranking all users by their total achievement points.
- Show each user a personal achievements tab listing which badges they have unlocked and which remain locked.
- Display a per-achievement leaderboard of the first users ever to unlock a given badge.
- Display a "most recent unlockers" leaderboard for a given achievement.
- Create secret achievements that appear only as "Secret achievement" placeholder text until a user earns them.
- Create invisible achievements that do not appear on the achievements tab at all until unlocked.
- Attach custom unlocked/locked/secret badge images per achievement, or fall back to the module's default images.
- Show fade-in unlock notifications in the corner of the screen the next time an offline user returns.
- Retroactively award achievements to users who already met a milestone before it existed (your code decides).
- Restrict earning to specific roles with the "earn achievements" permission, or let other modules veto earning via `hook_achievements_access_earn()`.
- Let users opt out of earning achievements through a companion module implementing the access hook.
- React to unlocks with `hook_achievements_unlocked()` — e.g. post to social media, send an email, or chain a further reward.
- Remove or relock an achievement when a condition is no longer met, optionally preserving stored progress.
- Store arbitrary per-user statistics (counts, streaks) with the serialized storage API to drive time-based achievements.
- Expose achievement data to Views for custom reports, blocks, or dashboards using the shipped Views field/argument handlers.
- Rank users relative to their own position (nearby ranks) rather than only showing the global top.
- Clean up all achievement data automatically when a user account is cancelled or deleted.
- Add gamification to a community, forum, e-learning, or intranet site to drive engagement and repeat visits.
