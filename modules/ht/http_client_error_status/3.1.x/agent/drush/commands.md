# HTTP Client Error Status Drush commands

`src/Drush/Commands/BlockCommands.php` (autowired, uses `Main`, service
`http_client_error_status.main`). Requires Drush `^12.5.2 || ^13`. All operate on `block` config
entities that carry the `http_client_error_status` visibility condition.

| Command | Aliases | Action |
|---|---|---|
| `http_client_error_status:list` | `hces:list`, `hces-list` | Print a table of every block using the condition (id, label, negate, 401/403/404, potential conflict). Read-only. Supports `--format`. |
| `http_client_error_status:remove` | `hces:remove`, `hces-remove` | Remove the condition instance from ALL blocks (blocks are kept, only the visibility condition is dropped). Prompts for confirmation. |
| `http_client_error_status:update` | `hces:update`, `hces-update` | Convert each block's 403/404 settings to core's `response_status` condition; then print the resulting list. |

## Behavior details (from `Main`)

- **list** → `Main::listPluginInstances()` scans `block` storage
  (`getVisibilityConditions()->has('http_client_error_status')`), reporting each block's flags and
  `checkBlockVisibilityConflict()` (TRUE when the block ALSO has a `response_status` condition).
- **remove** → `Main::removePluginInstances()` calls `$conditions->removeInstanceId(
  'http_client_error_status')` and saves each affected block. Same code runs on `hook_uninstall()`.
- **update** → `Main::updateBlockVisibility()` skips any block flagged as a conflict, else sets a new
  `response_status` visibility from `convertCondition()` (403 / 404 / 200 / 200+403 / 200+404 / 403+404
  combinations only) and rewrites the `http_client_error_status` condition via `remainingCondition()`
  (preserving `request_401`, since core `response_status` has no 401). Combinations outside that set are
  not converted.

## Typical migration flow

```bash
drush hces:list                 # audit which blocks use the plugin + conflicts
drush hces:update               # move 403/404 to core response_status (401 stays on this plugin)
# export & review config, deploy; then optionally:
drush hces:remove               # drop the plugin entirely once nothing needs 401
```

README caution: test the conversion and deploy the exported config rather than running `hces:update`
directly against production.
