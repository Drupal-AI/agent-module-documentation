<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configurable Anonymizer (configurable_anonymizer) — agent index

info.yml name: **Configurable Anonymizer**. Version **1.0.1**. Core `^11`. Package `Custom`.
License GPL-2.0+. No module or library dependencies (Drush required to run it).

Configure which content-entity **fields hold PII**, then **scrub those fields in place** via a Drush
command — the classic prod→staging/dev database-sync sanitization need. Field-level anonymization is
handled by an **attribute-based plugin type** (`Plugin/FieldAnonymizer`), so behaviour per field type
is pluggable. Config is stored in `configurable_anonymizer.settings` (key `fields`). Nothing runs over
the web — the admin form only edits config; the actual overwrite is CLI-only.

Single-file corpus — no subdocs warranted. Everything is below.

## Provided (from source)

- **Config form** `AnonymizerConfigForm` (`configurable_anonymizer_config_form`) at
  `/admin/config/development/anonymizer` — route `configurable_anonymizer.settings`, permission
  `administer site configuration` (routing.yml). Menu link under **Config → Development → Anonymizer**
  (`configurable_anonymizer.links.menu.yml`), weight 100. Iterates every **content** entity type
  (config entities skipped) × bundle × field, offering a `<select>` per field of the anonymizer
  plugins that support that field; saves the chosen map to `configurable_anonymizer.settings:fields`
  (`{entity_type}.{bundle}.{field_name}: plugin_id`), empty selections filtered out. Skips the id,
  uuid, and bundle key fields.
- **Service** `configurable_anonymizer.service` → `AnonymizerService` (`src/Service/AnonymizerService.php`).
  `anonymize()` builds a core `BatchBuilder`, one operation per configured entity_type+bundle.
  `anonymizeEntitiesOfBundle()` runs an entity query (`accessCheck(FALSE)`, tag
  `configurable_anonymizer`), 25 entities at a time, and for each configured field calls the chosen
  plugin's `anonymize($field)` then `$entity->save()`.
- **Drush command** `ConfigurableAnonymizerDrushCommands` — `anonymizer:run` (alias `anon-run`):
  calls the service then `drush_backend_batch_process()`. This is the ONLY trigger of the destructive
  run; there is no web route for it.
- **Plugin type** `field_anonymizer` (`FieldAnonymizerPluginManager`, base
  `FieldAnonymizerPluginBase`, interface `FieldAnonymizerInterface`, attribute
  `Attribute\FieldAnonymizer`). Interface: `label()`, `supportsField(FieldDefinitionInterface): bool`,
  `anonymize(FieldItemListInterface): void`. Alter hook `field_anonymizer_info`. Note (from the
  attribute docblock): plugin **id must equal the group or be `group:derivative`** or the plugin won't
  register.
- **Bundled plugins** (`src/Plugin/FieldAnonymizer/`):
  - `default` — `DefaultFieldAnonymizer`: `supportsField` = TRUE for all; on non-empty field calls
    `$field->generateSampleItems($field->count())` (core sample-value generation).
  - `uuid` — `UuidFieldAnonymizer`: supports `string`-type fields only; replaces each delta with
    `uuid.generate()` truncated to the field's `max_length`.
- **Hook** `Hook\EntityQueryAlter` — OO `#[Hook('entity_query_tag__user__configurable_anonymizer_alter')]`
  adds `condition(id, 1, '>')`, so anonymizing users skips uid 0/1 (anonymous + admin user 1).

## Configuration model

`configurable_anonymizer.settings` has one key, `fields`, a nested map
`fields.<entity_type_id>.<bundle>.<field_name> = <plugin_id>`. Built and saved only through the admin
form. Empty (unmapped) fields keep their real values on a run.

## Operational rules (from README / project)

- Anonymization **overwrites real data in place** and stores no reversal mapping.
- Intended for a **copied** database (post-sync sanitization) — **never run against production**, and
  run it **before anyone uses the non-prod copy**. A field you don't map is not scrubbed.

## Extending — a custom anonymizer

Add a class in `your_module/src/Plugin/FieldAnonymizer/` extending `FieldAnonymizerPluginBase` (or
implementing `FieldAnonymizerInterface` + `ContainerFactoryPluginInterface` for DI, as `uuid` does),
annotated with `#[FieldAnonymizer(id: 'yourmodule', label: new TranslatableMarkup('…'))]`. Implement
`supportsField()` (which field types you handle → controls whether you appear in the form's select)
and `anonymize(FieldItemListInterface $field)` (mutate the field in place). Remember the id-naming
constraint above.
