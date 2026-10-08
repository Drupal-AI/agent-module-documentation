# Drush commands

Registered in `drush.services.yml` → `\Drupal\formassembly\Commands\FormassemblyCommands` (injects the
`formassembly.batch` service).

| Command | Alias | Options | Behavior |
|---|---|---|---|
| `formassembly:sync` | `fas` | none | Runs the form-sync batch to completion: pages the FormAssembly form index, then creates/updates `fa_form` entities and archives ones no longer returned. |

Same logic as the settings-form "Sync now" batch; use it in cron to keep forms current, e.g.
`drush formassembly:sync`.

Notes:
- Requires a valid OAuth token (authorize first via `/admin/structure/fa_form/settings/authorize`).
- The settings form's help text references `drush fa-sync`; that string is stale — the actually
  registered command/alias are `formassembly:sync` / `fas`.
- `console.services.yml` also declares a legacy Drupal Console `formassembly:sync` command
  (`Command\SyncCommand`), but that class is not shipped in this release; use Drush.
