<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/CMSContentSyncCommands.php`, backed by the
`cms_content_sync.cli` service (`src/Cli/CliService.php`). All namespaced
`cms_content_sync:*`. Most talk to the external Sync Core backend, so they only do useful
work once the site is registered.

| Command | Aliases | Purpose |
|---|---|---|
| `cms_content_sync:configuration-export` | `cse`, `csce` | Push Flow/Pool (and entity-type) config to the Sync Core. Options: `--force`, `--mode=all\|cs\|entity-types\|old`. |
| `cms_content_sync:pull <flow_id>` | `cs-pull` | Ask the Sync Core to pull entities for a Flow. Options: `--force`, `--type=` (e.g. `pull-changed`), `--entity_type=`, `--bundle=`, `--entity_uuid=`. |
| `cms_content_sync:push <flow_id>` | `cs-push` | Push entities for a Flow. Options: `--push_mode=automatic_manual\|automatic_manual_force`, `--type=` (e.g. `push-failed`), `--entity_type=`, `--bundle=`. |
| `cms_content_sync:reset-status-entities` | `csrse` | Reset all sync-status (EntityStatus) records; use after a backend/pool change. Option `--pool_id=`. |
| `cms_content_sync:check-entity-flags <entity_uuid>` | `cscef` | Print the EntityStatus flags for one entity. Option `--flag=FLAG_IS_SOURCE_ENTITY\|FLAG_PUSH_ENABLED\|FLAG_PUSHED_AS_DEPENDENCY\|FLAG_EDIT_OVERRIDE\|FLAG_USER_ENABLED_PUSH\|FLAG_DELETED`. |
| `cms_content_sync:register <environment_type> <contract> <space> <token>` | `csr` | Register this site with the Sync Core backend. Option `--require_fixed_ip` (proxy through a fixed IP). |

Examples:

```bash
drush cms_content_sync:pull example_flow --type=pull-changed
drush cms_content_sync:pull example_flow --entity_type=node --bundle=basic_page
drush cms_content_sync:push example_flow --push_mode=automatic_manual
drush cms_content_sync:reset-status-entities --pool_id='example_pool'
drush cms_content_sync:check-entity-flags 16cc0d54-... --flag="FLAG_EDIT_OVERRIDE"
drush cse   # export config to the backend after editing Flows/Pools
```

Submodules add more commands: `cms_content_sync_developer:update-flows` (`csuf`),
`cms_content_sync_developer:force-entity-deletion` (`csfed`),
`cms_content_sync_private_environment:poll` (`cspep`), and the migrate submodule's legacy
`content-sync-migrate-acquia-content-hub`.
