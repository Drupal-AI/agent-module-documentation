<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Timezone Sync updates every user account's stored timezone to the site's default whenever per-user timezone selection is turned off, keeping user records consistent with the configured regional settings.
---
When a Drupal site disables the "Users may set their own time zone" option, existing user accounts keep whatever timezone they previously chose, which can cause date/time to render inconsistently. This module reacts to changes on the Regional settings form (`system_regional_settings`) and to the underlying config, and — via `TimezoneSyncService` — writes the system default timezone to all affected user accounts using a direct database update, invalidating the relevant cache tags.

The logic is exposed through a `hook_form_system_regional_settings_alter` (marked as a `LegacyHook`, delegating to `TimezoneSyncHooks`), a submit handler that flags the request as a Regional-settings save, and a `TimezoneConfigSubscriber` event subscriber that performs the sync when the timezone configurability actually changes. The service is autowired; there are no routes, permissions, or public endpoints — it operates entirely on administrative config-change events.

Setup: install and enable the module; no configuration is required. The sync runs automatically the next time an administrator saves Regional settings with per-user timezone selection disabled.
---
- Force all users onto the site default timezone.
- Sync user timezones automatically when per-user selection is disabled.
- React to saves of the Regional settings form.
- Keep user date/time rendering consistent site-wide.
- Update user timezone records via a direct DB write.
- Invalidate user cache tags after syncing.
- Avoid manual per-user timezone edits by admins.
- Run only when the timezone configurability setting changes.
- Report how many users were updated via the messenger.
- Support Drupal 10.1, 11, and 12.
- Operate without any admin configuration.
- Integrate through a config event subscriber.
- Log sync activity for auditing.
- Normalize legacy user timezones after a policy change.
- Fire only via the config event subscriber on real changes.
- Skip syncing when per-user timezone selection stays enabled.
- Use the autowired `timezone_sync.sync` service from custom code.
- Ensure new content shows times in the site timezone for all users.
- Correct mismatched timezones inherited from an imported user base.