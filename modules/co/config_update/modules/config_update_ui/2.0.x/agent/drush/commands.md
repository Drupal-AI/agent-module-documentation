# config_update_ui Drush commands

Defined via `drush.services.yml` (`ConfigUpdateUiCommands`). Same operations as the UI,
split into pieces.

| Command | Alias | Purpose |
|---|---|---|
| `config-list-types` | `clt` | List all config types (plus `system.simple`, `system.all`). |
| `config-added-report <type>` | `cra` | Config you added that no extension provides (by type). |
| `config-missing-report <kind> <name>` | `crm` | Defaults missing from active storage. |
| `config-different-report <kind> <name>` | `crd` | Active config differing from shipped default. |
| `config-inactive-report <kind> <name>` | `cri` | Provided-but-not-installed config. |
| `config-diff <config_name>` | `cfd` | Normalized diff of one item (active vs default). |
| `config-revert <config_name>` | `cfr` | Revert one changed item to the shipped default. |
| `config-revert-multiple <kind> <name>` | `cfrm` | Revert all items of a type / from one extension. |
| `config-import-missing <config_name>` | `cfi` | Import a missing/inactive item from its default. |

`<kind>` is one of `type` | `module` | `theme` | `profile`; `<name>` is that
type/module/theme/profile machine name.

```
drush clt
drush crm module node
drush crd theme olivero
drush crd type system.all
drush cfd block.block.olivero_search
drush cfr block.block.olivero_search
drush cfrm module node
```
