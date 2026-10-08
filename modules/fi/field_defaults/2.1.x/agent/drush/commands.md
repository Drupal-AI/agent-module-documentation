<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `field_defaults:bulk-update`

Bulk-applies a field's configured default value to existing content without touching the UI.
Defined in `FieldDefaultsBulkCommands` (service `field_defaults.commands`).

```
field_defaults:bulk-update <entity_type> <entity_bundle> <field_name> [<lang>] [<no_overwrite>]
```

Aliases: `fdbu`, `field_defaults-bulk-update`.

## Arguments

| Position | Arg | Default | Meaning |
|---|---|---|---|
| 1 | `entity_type` | — | e.g. `node`, `user`, `taxonomy_term`. |
| 2 | `entity_bundle` | — | e.g. `article`. (Bundle-less types like `user` still require a value; the processor ignores it when the type has no bundle key.) |
| 3 | `field_name` | — | Machine name, e.g. `field_region`. |
| 4 | `lang` | `''` | Comma-separated language codes to *also* update (translations), e.g. `de,fr`. Empty = current language only. |
| 5 | `no_overwrite` | `TRUE` | `TRUE`/`1` = only fill **empty** fields; `FALSE`/`0` = overwrite existing values too. Parsed with `FILTER_VALIDATE_BOOLEAN`. |

The value written is the field's own `default_value[0]` read from its `field_config`. If the
field does not exist, or has no default value set, the command prints a message and exits
without changes.

## Behaviour

- Interactive: prompts `Do you wish to continue?` (throws `UserAbortException` on no). Pass
  `-y`/`--yes` to run unattended in scripts/CI.
- Then delegates to `field_defaults.processor->processFieldForm()` and runs the batch via
  `drush_backend_batch_process()` — processes all matching entities in ranges of 10.

## Examples

```bash
# Fill field_region on existing Articles only where it is empty (default no_overwrite=TRUE):
drush field_defaults:bulk-update node article field_region -y

# Overwrite field_region on ALL existing Articles with the field's default:
drush fdbu node article field_region '' 0 -y

# Also update the German and French translations:
drush fdbu node article field_region de,fr 0 -y
```

Remember to set the field's **Default value** (in Manage fields) first — the command applies
that stored default, it does not take a value argument.
