<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Leaderboards, per-user tab & Views integration

The leaderboards and the per-user achievements listings are **Views**, shipped as config in
`config/install/` — not PHP controllers. Only the personal summary tab has a custom controller.

## Shipped views & their page paths

- `views.view.achievement_totals.yml` — base table `achievement_totals`. Page display at
  **`achievements/leaderboard`** (the site-wide leaderboard, ranked by points/unlocks). Other displays
  target `user/{{ uid }}/achievements`.
- `views.view.achievement_unlocks.yml` — base table `achievement_unlocks`. Page displays at
  **`achievements/unlocks/%`** (per-achievement unlockers — "first" / "most recent"),
  **`user/%user/achievements`** and **`user/%user/unlocks`** (a user's unlock list).

Views data is declared in `achievements.views.inc` (`hook_views_data`) for all three tables
(`achievement_totals`, `achievement_unlocks`, `achievement_storage`), each `INNER JOIN`ing
`users_field_data` on `uid`. It exposes fields/filters/sorts for `points`, `unlocks`, `rank`, `timestamp`,
`seen`, `uid`, `achievement_id`, plus two custom handlers below.

## Custom Views handlers (`src/Plugin/views/`)

- **`field/LatestAchievement.php`** (`@ViewsField("latest_achievement")`, `latest_achievement` on
  `achievement_totals`, real field `uid`) — `render()` runs a `SELECT achievement_id, timestamp FROM
  achievement_unlocks WHERE uid = :uid ORDER BY timestamp DESC LIMIT 1` (uid taken via
  `sanitizeValue($this->getValue($values))`), then renders the `achievement_latest_unlock` theme.
- **`field/AchievementConfig.php`** (`@ViewsField("achievement_config")`, extends core `Serialized`) —
  `render()` loads `\Drupal::config("achievements.achievement_entity.{$values->aid}")` and serializes its
  raw data for display. A config read keyed by the row's achievement id, not a SQL query.
- **`argument/AchievementId.php`** (`@ViewsArgument("achievement_id")`, extends `Standard`) —
  `title()` looks up `\Drupal::config('achievements.achievement_entity.' . $this->argument)->get('label')`
  to title the page from the achievement id in the URL.

## Custom per-user summary — `AchievementsController`

`src/Controller/AchievementsController.php`, route
`achievements.achievements_controller_userAchievements` → **`/user/{user}/achievements`**
(`_permission: 'access content'`, `{user}` constrained to `\d+`). Injects `database` + `config.factory`.

- `userAchievements(UserInterface $user)` — builds a `#theme => 'achievement_user_stats'` summary
  (name, rank, points, unlocks_count, total_count) from `achievements_unlocked_already()`,
  `achievements_totals_user()` and `achievements_load_all()`, then one `#theme => 'achievement'` element
  per achievement. **Invisible** achievements are skipped unless the viewed user has unlocked them;
  unlocked ones sort to the top (negative-timestamp weight). Attaches the `achievements/achievements`
  library.
- `userAchievementsTitle(UserInterface $user)` — "Achievements for {display name}", output as `#markup`
  with `#allowed_tags => Xss::getHtmlTagList()`.

Note the same `user/{user}/achievements` path is also declared by an `achievement_unlocks` view display;
which serves depends on route/view priority in the installed site.

## Leaderboard hook

`hook_achievements_leaderboard_alter(&$leaderboard)` (documented in `achievements.api.php`) lets a module
tweak or replace a leaderboard render array; `type` is one of `top`, `relative`, `first`, `recent`.
Query tags for altering the underlying selects: `achievement_totals`, `achievement_totals_user`,
`achievement_totals_user_nearby`.
