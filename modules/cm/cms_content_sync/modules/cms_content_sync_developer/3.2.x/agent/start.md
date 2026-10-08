<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Developer — agent index

Developer helpers for Content Sync (`cms_content_sync`). Watches configuration changes and
flags Flows whose entity-type definition has drifted out of date (a "version mismatch"), warns
admins on every request until they re-export, and adds two Drush maintenance commands. Submodule
of Content Sync — see the parent index [`../../../../3.2.x/agent/start.md`](../../../../3.2.x/agent/start.md).

Dependencies: `cms_content_sync`, `config_ignore`. No settings page (`configure` = null), no
permissions of its own, no plugins.

- **The `version_mismatch` state config + config_ignore integration** → [configure/version-mismatch.md](configure/version-mismatch.md)
- **The event subscribers that detect drift and warn admins** → [events/version-warnings.md](events/version-warnings.md)
- **Drush commands (update flows, force entity deletion)** → [drush/commands.md](drush/commands.md)

Key facts:
- Config object `cms_content_sync.developer`, single key `version_mismatch` (map: flow id → flow label);
  default install value is an empty map (`config/install/cms_content_sync.developer.yml`).
- Services: `cms_content_sync_developer.config_subscriber` (`EventSubscriber\VersionComparison`),
  `cms_content_sync_developer.event_subscriber` (`EventSubscriber\VersionWarning`),
  `cms_content_sync_developer.cli` (`Cli\CliService`).
- Drush command ids `cms_content_sync_developer:update-flows` (alias `csuf`) and
  `cms_content_sync_developer:force-entity-deletion` (alias `csfed`).
- Warnings are shown only to users holding the parent permission `administer cms content sync`.
- `hook_config_ignore_settings_alter()` adds `cms_content_sync.developer:version_mismatch` to the
  `config_ignore` list so the transient state is never exported.
- `hook_install()` sets module weight to 100 (runs after the parent); `hook_uninstall()` deletes the config.
