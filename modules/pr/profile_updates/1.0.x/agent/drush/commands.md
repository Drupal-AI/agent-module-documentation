<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush and workflow

## Admin UI
- `/admin/config/development/profile-updates` (`ProfileUpdateListForm`) lists tasks by live state.
- Per-item diff: `/admin/config/development/profile-updates/{plugin_id}/diff`.
- Log diff / restore: `/admin/config/development/profile-updates/log/{profile_update_log}/diff|restore`.
- Apply/Skip run through Batch API; each recorded in a `profile_update_log` entity. Restore removes a skip → task recomputes to Pending.

## Drush
- `ProfileUpdatesCommands` (see `profile_updates.drush.services.yml`) applies/lists updates for CI or deploy — applies are explicit; nothing runs automatically on `drush updb` / `deploy:hook`.

## Shipping tasks (distribution authors)
- Drop `update_tasks/*.yml` in the profile or any enabled module; each YAML is one `ProfileUpdate` plugin, re-scanned on cache clear.
- Optional `profile_updates_export` submodule generates task YAML or update-hook scaffolding from config changes.
