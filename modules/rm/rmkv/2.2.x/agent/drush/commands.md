# Drush commands

Defined in `src/Commands/RemoveKeyValueCommands.php`, registered via `drush.services.yml` as the
service `rmkv.commands` (a `DrushCommands` subclass). The constructor grabs the `system.schema`
key/value store (`\Drupal::service('keyvalue')->get('system.schema')`) and injects
`extension.list.profile`, `module_handler`, and `theme_handler` to verify an entry is genuinely
orphaned before removing it.

| Command | Argument | Action |
|---|---|---|
| `rmkv:check` | `<machine_name>` | Read-only check. Logs a **notice** "…is removable…" when the name is present in `system.schema` **and** is not an installed profile, module, or theme; otherwise logs a **warning** "…is not removable…". Deletes nothing. |
| `rmkv` | `<machine_name>` | Deletes `<machine_name>` from `system.schema`. Errors if the key is absent, or if the name belongs to an installed profile/module/theme (guard against removing a live extension's schema record); on success logs "Succeeded in removing …". |

No aliases or options are declared. Each takes exactly one positional `machine_name` argument.

Typical recovery flow for the "has an entry in the system.schema key/value storage, but is missing
from your site" warning:

    drush rmkv:check my_removed_module   # confirm it is orphaned & removable
    drush rmkv my_removed_module         # remove the stray schema record
    drush cr                             # rebuild caches / re-run status report

Back up the database first — deleting the wrong key tells Drupal a still-present extension has been
uninstalled. The `rmkv` command's own guard blocks deleting the record of any *installed* extension,
so target only names whose code is truly gone.
