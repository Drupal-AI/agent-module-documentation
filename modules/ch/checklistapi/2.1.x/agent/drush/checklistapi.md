# Drush commands

Registered via `drush.services.yml` (`ChecklistapiCommands`). Run `drush --filter=checklistapi`
to list them.

## `checklistapi:list`

Aliases: `capi-list`, `capil`, `checklistapi-list`.

Prints a table of every installed checklist with: title (and ID), progress
(`completed of total (percent%)`), last-updated date, and last-updated user. Reports
"No checklists available." when none are defined.

```
drush checklistapi:list
```

## `checklistapi:info <checklist_id>`

Aliases: `capi-info`, `capii`, `checklistapi-info`.

Shows detailed info for one checklist: its `#help` text, last-updated/progress summary, then
each group and item as a `[x]`/`[ ]` checkbox line. Completed items append
`Completed <time> by <user>`. Errors with "No such checklist" for an unknown ID.

```
drush checklistapi:info my_checklist
```
