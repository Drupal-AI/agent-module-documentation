<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Achievements (achievements) — agent index

A **gamification framework**: define achievement/badge **config entities**, **award points from custom
code** on user milestones, and rank users on **leaderboards**. Ships NO achievements — you create the
entities in the UI and grant them by calling the PHP API from your own hooks. Version **3.0.3**, dir
`3.0.x`. Package `Achievements`. License GPL-2.0-or-later. Core `^9 || ^10 || ^11 || ^12`.

- **Depends on:** core `file`, plus contrib `jquery_ui_effects` and `jquery_ui_dialog` (`^2.0`) for the
  fade-in unlock notification + dialog. Frontend library `achievements/achievements`
  (`achievements.libraries.yml`): `achievements.css`, `achievements.js`, deps `core/jquery`, `core/once`,
  `jquery_ui_dialog/dialog`, `jquery_ui_effects/fade`.

## What it provides

- **Config entity `achievement_entity`** (`src/Entity/AchievementEntity.php`, `@ConfigEntityType`,
  `admin_permission = "administer site configuration"`) — fields: label, description, storage, secret,
  invisible, manual_only, points, use_default_image, locked/unlocked_image_path. Admin CRUD at
  `/admin/structure/achievements` (collection), add/edit/delete forms. Config schema in
  `config/schema/achievement_entity.schema.yml`.
- **Award/query PHP API** in `achievements.module` (procedural, `\Drupal::` calls) — the real engine.
  → [api/achievements-api.md](api/achievements-api.md)
- **Entity, forms & admin config** → [entities/achievement-entity.md](entities/achievement-entity.md)
- **Leaderboards, per-user tab & Views plugins** → [views/leaderboards.md](views/leaderboards.md)
- **Storage tables** (`achievements.install` `hook_schema`): `achievement_unlocks`
  (achievement_id, uid, rank, timestamp, seen), `achievement_totals` (uid, points, unlocks, timestamp,
  achievement_id — the leaderboard), `achievement_storage` (achievement_id, uid, serialized `data` blob).

## Routes, permissions, config

- **Routes:** only one custom route in `achievements.routing.yml` —
  `achievements.achievements_controller_userAchievements` at `/user/{user}/achievements`
  (`AchievementsController::userAchievements`, `_permission: 'access content'`). The **leaderboard**
  (`achievements/leaderboard`), **per-achievement unlocks** (`achievements/unlocks/{id}`) and
  `user/{user}/unlocks` are **Views page displays** shipped in `config/install/views.view.achievement_totals.yml`
  and `views.view.achievement_unlocks.yml` — not PHP routes. Entity admin routes come from
  `AchievementEntityHtmlRouteProvider`.
- **Permissions** (`achievements.permissions.yml`): `access achievements`, `earn achievements`,
  `administer achievements`, `manually grant achievements`, `grant manual achievements`. Note: the
  `earn achievements` permission is what actually gates recording an unlock (see api doc); the entity
  admin UI is gated by core `administer site configuration`, not `administer achievements`.
- **Config object** `achievements.settings` (`config/install/achievements.settings.yml`): single key
  `image_hidden` (boolean, schema `achievements.schema.yml`). `AdminForm` (`src/Form/AdminForm.php`) is a
  near-empty `ConfigFormBase` stub. `info.yml` declares `configure: achievements.config` (a menu-link id;
  the practical admin landing is the entity collection `entity.achievement_entity.collection`).
- **Hooks provided** (`achievements.api.php`): `hook_achievements_unlocked`, `hook_achievements_locked`,
  `hook_achievements_access_earn`, `hook_achievements_info_alter`, `hook_achievements_leaderboard_alter`,
  plus query tags `achievement_totals`, `achievement_totals_user`, `achievement_totals_user_nearby`.
- **Theme hooks** (`achievements_theme`): `achievement`, `achievement_notification`,
  `achievement_latest_unlock`, `achievement_user_stats` (templates in `templates/`).
