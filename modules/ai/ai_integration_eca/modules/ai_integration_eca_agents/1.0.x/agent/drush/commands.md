# Drush / console command

Registered via `drush.services.yml` as a Symfony console command
(`src/Command/DebugDataProviderCommand.php`).

## `ai-agents-eca:debug:data`

Dumps what the ECA agent's DataProvider sees — the available ECA **components** and existing
**models** — for debugging prompts/agent input.

```
ddev drush ai-agents-eca:debug:data
ddev drush ai-agents-eca:debug:data --vm=full
ddev drush ai-agents-eca:debug:data --filter=components
```

Options:

| Option | Values | Default | Effect |
|---|---|---|---|
| `--vm` | `teaser` \| `full` | `teaser` | View mode / verbosity (`DataViewModeEnum`). `full` includes more detail (larger output). |
| `--filter` | `components` \| `models` | — | Limit output to just components or just models. |

Output is `print_r` of `['components' => …, 'models' => …]` (re-encoded through JSON). Read-only;
it does not modify any ECA model.
