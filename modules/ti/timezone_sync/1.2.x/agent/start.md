<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Timezone Sync (timezone_sync) — agent index

**Writes the site default timezone to all user accounts when per-user timezone selection is disabled.**

- **Version:** 1.2.x
- **Core:** ^10.1 || ^11 || ^12 · **Package:** Custom
- **No routes, no permissions, no config UI.** Triggered by Regional settings saves.
- **Services:** `Drupal\timezone_sync\TimezoneSyncService` (alias `timezone_sync.sync`), `TimezoneConfigSubscriber` (event_subscriber), `TimezoneSyncHooks`
- **Hooks:** `hook_form_system_regional_settings_alter` + submit handler flag; config subscriber performs the sync.
- **Security:** Purely administrative. No user-facing endpoints; acts only on config-change events triggered from the (permission-protected) Regional settings form. Uses a parameterized DB update. No security findings.