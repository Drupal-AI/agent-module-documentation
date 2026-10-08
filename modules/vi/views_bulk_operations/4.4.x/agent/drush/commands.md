# Drush commands

Defined in `src/Drush/Commands/ViewsBulkOperationsCommands.php`. Requires drush `^12 || ^13`.

## `views:bulk-operations:execute`
Aliases: `vbo-execute`, `vbo-exec`, `views-bulk-operations:execute`.

Run a view's action on all (or filtered) results from the CLI — ideal for cron/scripted mass
operations without loading the page.

```
drush vbo-execute <view_id> <action_id> [options]
```

Arguments: `view_id`, `action_id` (the Action plugin id).

| Option | Default | Meaning |
|---|---|---|
| `--display-id` | `default` | View display to use. |
| `--args` | – | View contextual arguments, `/`-delimited (e.g. `--args=arg1/arg2`). |
| `--exposed` | – | Exposed filter/sort input, query-string format. |
| `--batch-size` | `10` | Entities processed per batch chunk. |
| `--configuration` | – | Action configuration, query-string format (`key1=value1&key2=value2`). |
| `--user-id` | `1` | Account the operation runs as (drush 9+ has no `--user`). |
| `--verbose` | – | Show per-batch progress messages. |

Examples:
```
drush vbo-execute some_view some_action
drush vbo-exec some_view some_action --args=arg1/arg2 --batch-size=50
drush vbo-exec some_view some_action --configuration="key1=value1&key2=value2"
```
Empty selection means "all results of the view" (exposed filters are honored).
