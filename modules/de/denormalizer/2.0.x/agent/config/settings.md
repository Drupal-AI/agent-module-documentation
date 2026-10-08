<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Denormalizer global settings

`Drupal\denormalizer\Form\DenormalizerSettingsForm` (route `denormalizer.settings`, path `/admin/config/development/denormalizer`, permission `administer denormalizer`). Edits config object `denormalizer.settings` (schema `config/schema/denormalizer.schema.yml`, defaults `config/install/denormalizer.settings.yml`).

## Install / enable
`drush en denormalizer -y`. Core-only; enable `webform` and/or `duration_field` first if you want their extra behavior. Menu link "Denormalizer" appears under Configuration → Development.

## Config keys (`denormalizer.settings`)
- `sql_mode` (string, radios `views` | `tables`, default `tables`) — "Create views" vs "Create tables". Note: the entity-source code path in `DenormalizerTable` always creates real tables; the view path is not implemented in this class.
- `db` (string, radios `local` | `external`, default `external`) — target database for denormalized output.
- `view_prefix` (string, default `''`) — required and must differ from the site prefix when `db=local`, so denormalized tables never overwrite Drupal's own.
- `db_prefix` (string, default `dw_`) — required when `db=external`. (Present in defaults + form but not declared in the schema mapping.)
- `cron_enabled` (bool, default `false`) — enable incremental/reload processing on cron.
- `run_every` (integer seconds, default `900`) — minimum interval between incremental runs.
- `reload_every` (integer seconds, default `86400`) — interval between full reloads.

## Validation (`validateForm`)
- `db=local` with empty `view_prefix`, or a `view_prefix` equal to the connection's own prefix → error ("otherwise your tables will be overwritten").
- `db=external` with empty `db_prefix` → error.
- If `duration_field` is enabled, `run_every`/`reload_every` render as `duration` widgets; `secondsToInterval()` converts stored seconds to a `DateInterval` for display and `getSecondsFromDateInterval()` converts back on validate.

`submitForm` saves the full `$form_state->getValues()` into `denormalizer.settings`.

## Cron behavior (`denormalizer_cron` in denormalizer.module)
Runs only when `cron_enabled`. Compares `\Drupal::state()->get('denormalizer_cron_last_run')` against `reload_every` (→ `$reset = TRUE`, full rebuild) then `run_every` (→ `$reset = FALSE`, incremental). When due, loads every `denormalizer_table`, and for each queues one `denormalizer_queue` item per entity id returned by `denormalizer_get_entity_ids_to_populate()` (an entity query with `accessCheck(FALSE)`, optionally filtered by bundle). Updates the last-run state and logs to the `denormalizer` channel.
