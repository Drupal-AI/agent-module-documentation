# Drush command

Registered in `chosen_lib/drush.services.yml` (service `chosen_lib.commands`,
class `Drupal\chosen_lib\Commands\ChosenLibCommands`).

| Command | Purpose |
|---|---|
| `chosen:plugin [path]` | Download and extract the Chosen JS library (v3.1.3) into `libraries/chosen` (or the optional `path` argument). |

Run once during setup/deploy so the `chosen`/`chosen.css` asset libraries resolve to real
files. Helpers `drushLog()` and `drushDownloadFile()` handle logging and fetching.

```
drush chosen:plugin
```
