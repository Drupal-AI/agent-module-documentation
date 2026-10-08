<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Profile Updates (profile_updates) — agent index
**Review and selectively apply optional install-profile config updates, with per-site state, audit log and restore.**

- **Version:** 1.0.x  **Core:** ^10.3 || ^11  **Depends:** user, config_update
- **Config route:** `profile_updates.list` (`/admin/config/development/profile-updates`).
- **Routes (all perm `administer profile updates`):** list, `/{plugin_id}/diff`, `/log/{log}/diff`, `/log/{log}/restore`.
- **Plugins:** `ProfileUpdate` (tasks auto-discovered from `EXTENSION/update_tasks/*.yml`); entity `profile_update_log`; action `RestoreProfileUpdateAction`; Drush commands.
- **Submodule:** `profile_updates_export` (+ update_hooks / update_tasks generators).
- **Security:** every route gated by restricted `administer profile updates`; applies are deliberate admin/Drush actions (nothing runs on `drush updb`). No anonymous access. Sound.

See [drush/commands.md](drush/commands.md)
