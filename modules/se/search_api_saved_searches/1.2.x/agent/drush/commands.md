# Drush commands

Registered in `drush.services.yml` → `SavedSearchCommands` (arg:
`search_api_saved_searches.new_results_check`).

| Command | Aliases | Argument | Behavior |
|---|---|---|---|
| `search-api-saved-searches:check-all` | `sapi-ss-ca`, `saved-searches-check-all` | `type_id` (optional) | Runs `NewResultsCheck::checkAll($type_id)`: checks all saved searches whose notification interval is due for new results and sends notifications. With no argument, checks every enabled type that has at least one notification plugin; with a type id, restricts to that type. |

```bash
# Check all due saved searches (same work as hook_cron):
drush search-api-saved-searches:check-all
drush sapi-ss-ca

# Only the "jobs" type:
drush search-api-saved-searches:check-all jobs
```

Logs a success line with the number of searches checked, or a notice if none were due. This is the
manual equivalent of the cron run and honours `search_api_saved_searches.settings:cron_batch_size`.
