# Drush commands

Class `Drupal\l10n_tools\Commands\L10nToolsCommands` (extends `Drush\Commands\DrushCommands`),
registered by `drush.services.yml` (service `l10n_tools.commands`, tag `drush.command`). Each command
instantiates `new QueryHelper()` directly (no DI needed — the helper has no constructor args) and
prints results with `$this->yell(...)`; a `FALSE` result prints a red "An error occured, see logs!"
(logger channel `l10n_tools`). These are CLI-only and run the exact same operations as the admin form
— destructive, no confirmation prompt, no undo.

## `l10n_tools:delete-equal-translations`  (alias `l10n_tools:deet`)
Deletes `locales_target` rows whose translation equals its source string. Options (all default
`FALSE`) map to `QueryHelper::deleteEqualTranslations(...)`:

| Option | Effect |
|---|---|
| `--custom-only` | `deleteEqualTranslations(TRUE)` — only `customized` (user) translations |
| `--imported-only` | `deleteEqualTranslations(FALSE)` — only imported / default translations |
| `--both` | `deleteEqualTranslations()` — both customized and imported |

Each flag is checked independently, so passing several runs several deletes. **With no option the
command does nothing** (none of the branches run — there is a `@todo` to convert this to a switch with
a default). Example: `drush l10n_tools:deet --both`.

## `l10n_tools:delete-orphan-translations`  (alias `l10n_tools:deot`)
No options. Calls `QueryHelper::deleteOrphanTranslations()` — removes `locales_source` rows that have
no `locales_target`. Example: `drush l10n_tools:deot`.

## `l10n_tools:reset-translation-status`  (alias `l10n_tools:rets`)
No options. Calls `QueryHelper::resetTranslationStatus()` — clears the `locale.translation_status`
key_value collection and zeroes the `locale_file` timestamps + `locale.translation_last_checked`
state. A `@todo` notes you should follow up with `drush locale-check && drush locale-update && drush cr`
to actually re-pull translations. Example: `drush l10n_tools:rets`.

See [../api/services.md](../api/services.md) for exactly what each underlying method deletes.
