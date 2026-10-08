# Drush commands

Defined in `src/Commands/SmartDateDrushCommands.php` (`drush.services.yml`).

- `smart_date:migrate` (alias `sdm`) — migrate an existing core datetime / daterange field's
  data into a Smart Date field. Arguments: `bundle`, `dest` (destination field), `source_start`,
  and optional `source_end`, `source_all_day`. Options include `--clear` (empty the destination
  first), `--entity` (destination entity type), `--default_duration` (assumed duration when no
  end date), and `--langcode` (language code to store). Use when converting legacy date fields
  to `smartdate`.

Run: `drush smart_date:migrate <bundle> <dest_field> <source_start_field> [source_end] [source_all_day]`.

The **smart_date_recur** submodule adds its own commands
(`modules/smart_date_recur/src/Drush/Commands/SmartDateRecurCommands.php`) for generating rule
instances and pruning — see that submodule's docs.
