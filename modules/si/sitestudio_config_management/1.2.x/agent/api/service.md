<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service & install-time config

## Service `site_studio.config_management`
Class `Drupal\sitestudio_config_management\SiteStudioConfigManagement`
(args: `extension.list.module`, `state`, `config.factory`, logger channel). Methods:

| Method | Purpose |
|---|---|
| `initialize()` | Stores the current Cohesion version in state (`setVersionInState`). Called on install and after a successful post-upgrade import. |
| `isSiteStudioConfigured(): bool` | TRUE when `cohesion.settings` has both `api_key` and `organization_key`. The gate for every Site Studio drush step. |
| `isSiteStudioUpgraded(): bool` | TRUE when `getCurrentVersion() > getPreviousVersion()` (`version_compare`). Drives the extra `cohesion:rebuild`. |
| `getCurrentVersion()` | Cohesion module version from `extension.list.module`->get('cohesion')->info['version']. |
| `getPreviousVersion()` | Reads state `sitestudio_config_management.site_studio_version` (defaults to current). |
| `clear()` | Deletes the recorded version from state (called on uninstall). |

State key: `sitestudio_config_management.site_studio_version`.

## Config written/managed on install (`hook_install`, non-syncing only)
- **config_ignore**: appends `'cohesion_*'` to `config_ignore.settings`
  `ignored_config_entities` (de-duplicated).
- **cohesion.sync.settings**: loaded from `config/optional/cohesion.sync.settings.yml` and set
  programmatically (the optional config is not auto-imported when new). It enables all
  `cohesion_*` entity types with `package_export_limit`/`full_export_limit` = 10. If the config
  already exists, only merges in the module's `enabled_entity_types`.
- **config_split `site_studio`** (`config/install/config_split.config_split.site_studio.yml`):
  `complete_list: ['cohesion_*']`, folder `sitestudio`, `storage: database`, `stackable: false`
  — an enforced-dependency split isolating Site Studio config.
- Finally calls `initialize()` to record the Cohesion version.

`hook_uninstall` calls the service's `clear()`.

## Helper
`_sitestudio_config_management_get_configuration($config, $module)` reads a YAML file from the
given module's `config/optional/<config>.yml` and returns the parsed array (used to load the
shipped `cohesion.sync.settings`).
