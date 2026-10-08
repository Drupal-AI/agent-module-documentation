<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (aia:*)

Defined in `src/Commands/AiaCommands.php` (registered via `drush.services.yml`, service `aia.commands`). All operate on the same dry-run→apply pipeline as the web UI. A second service `aia.debug_commands` (`AiaDebugCommands`) adds debug helpers.

| command | alias | purpose |
|---------|-------|---------|
| `aia:dry-run <actionId>` | `aia-dry` | Run an action in dry-run only; prints the proposed diff, writes nothing. |
| `aia:execute <actionId>` | `aia-exec` | Dry-run, show diff, confirm, then apply; prints the resulting Task ID. |
| `aia:list` | `aia-ls` | Table of available action plugin IDs, labels, classes. |
| `aia:info` | `aia-i` | Shows the active AI service class and whether it is the Mock. |
| `aia:tasks` | `aia-tasks` | Lists logged `aia_task`s (id, action, user, created, status). |
| `aia:rollback <taskId>` | `aia-rb` | Confirms, then undoes the changes of a successful task via `AiaRollbackService`. |

## Options (dry-run / execute)
- `--prompt="..."` — the natural-language intent passed to `setUserIntent()` (shapes the AI prompt). Omit to let the action generate from site context.
- `--auto-approve` — (execute only) skip the interactive confirm. Use with care: it writes real config.

`<actionId>` is one of the seven plugin IDs (see `plugins/actions.md`), e.g. `generate_content_type`, `add_field`, `generate_taxonomy`, `generate_view`, `generate_block`, `generate_menu`, `generate_paragraph_type`.

## Examples
```
drush aia:dry-run generate_content_type --prompt="A product type with title, SKU, price, and images"
drush aia:execute generate_taxonomy --prompt="Categories: News, Reviews, Tutorials"
drush aia:execute add_field --prompt="a reading-time field" --auto-approve
drush aia:tasks
drush aia:rollback 12
```

## Naming-conflict handling
`execute`/`dry-run` route through `runDryRunWithConflictResolution()`. When a validator reports an "already exists" conflict, the CLI offers **stop** or **use an incremented name** (`footer-links-2`, `blog_categories_2` — hyphen separator for menus, underscore otherwise). Auto-increment retry only works with `MockAIRequestService` (it injects the name via `setMachineNameOverride()`); with a real AI service the command explains that you should adjust the prompt or roll back the existing item first.

Errors are classified and formatted by `AiaErrorFormatter` (`formatForDrush()`); `-v` adds a stack trace.
