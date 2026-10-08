# Drush commands

Defined in `src/Commands/SmartDateDrushCommands.php` (`drush.services.yml`).

- `smart_date:migrate` (alias `sdm`) — migrate an existing core datetime / daterange field's
  data into a Smart Date field. Options include `--langcode` to set the stored language code.
  Use when converting legacy date fields to `smartdate`.

Run: `drush smart_date:migrate` (add the field/type arguments the command prompts for).

The **smart_date_recur** submodule adds its own commands (`src/Drush/Commands/SmartDateRecurCommands.php`):
`create` (generate rule instances) and rule pruning — see that submodule's docs.
