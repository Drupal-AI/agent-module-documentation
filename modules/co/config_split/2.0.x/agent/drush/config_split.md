# Drush commands

Provided by `ConfigSplitCommands` (`drush.services.yml`). `<split>` is a split machine name.
These operate directly on a single split's storage, independent of a full config sync.

| Command | Does |
|---|---|
| `drush config-split:export <split>` | Export the active config selected by the split into the split's storage/folder. |
| `drush config-split:import <split>` | Import the split's stored config into the active configuration. |
| `drush config-split:activate <split>` | Write the split's config into active storage (activate the split). |
| `drush config-split:deactivate <split> [--override]` | Remove the split's config from active storage. `--override` also sets a state status override. |
| `drush config-split:status-override <name> [active\|inactive\|none]` | Set/clear a runtime status override (alias `csso`); no value shows current. |

```
drush config-split:export development
drush config-split:import development
drush config-split:status-override development active
```

- The module also hooks `config:export`/`config:import` (post-command + event subscriber), so a
  normal `drush config:export` / `config:import` already respects active splits — the commands
  above are for operating on one split explicitly.
- Requires Drush 10+ (`extra.drush.services`).
