<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Sample Value (field_sample_value) — agent index

Makes Drupal's per-field **sample value generation pluggable**. Adds a "Set sample value" option
to the field settings form so a site builder picks a **sample value generator plugin** and its
config; the choice is stored as a third-party setting on the field config. A service then
creates/populates fieldable entities from those per-field generators. Version **1.x** (installed
1.0.9). Core `^9.5 || ^10 || ^11`. License GPL-2.0-or-later. **No dependencies** beyond core,
**no routes, no permissions, no Drush.** Config schema: yes.

## Solution docs

- **The generator plugin type, the 4 shipped plugins, and how to add your own** →
  [plugins/sample_value_generator.md](plugins/sample_value_generator.md)
- **The entity generator service + how field config, the constraint, and "prevent save" work** →
  [api/entity_generator.md](api/entity_generator.md)

## What it actually is (from source)

- A **plugin type** `SampleValueGenerator` — manager `SampleValueGeneratorManager`
  (service `plugin.manager.field_sample_value`), namespace `Plugin/Field/SampleValueGenerator`,
  interface `SampleValueGeneratorInterface`, annotation `@SampleValueGenerator`, alter hook
  `sample_value_generator_info`. Base class `SampleValueGeneratorBase`.
- **4 shipped generators**: `default` ("Field type default", weight -10, all field types),
  `random_string` ("Random words", `string`/`string_long`), `random_text` ("Random text",
  `text`/`text_long`/`text_with_summary`), `entity_reference` ("Entity Reference",
  `entity_reference`).
- A **service** `field_sample_value.generator` (`SampleValueEntityGenerator`) with
  `createWithSampleValues()`, `populateWithSampleValues()`, `populateWithSampleValue()`.
- A **validation constraint** `SampleValue` (`SampleValueConstraint` + validator) added to any
  field that has a generator configured with `prevent_save` on.
- Hooks in `field_sample_value.module`: `hook_form_field_config_edit_form_alter` (the UI),
  `hook_entity_bundle_field_info_alter` (attaches the constraint).
- **Config schema** `field.field.*.*.*.third_party.field_sample_value` (id + configuration:
  `prevent_save` bool, `count` string, `filter_format` string). No config/install, no settings form.

## Mechanism in one paragraph

The field-config edit form alter lists generators applicable to the field type
(`getApplicableGenerators()`), renders each plugin's config subform, and on submit saves
`third_party_settings.field_sample_value.{id, configuration}` on the field. Later,
`SampleValueEntityGenerator::populateWithSampleValue()` checks
`_field_sample_value_field_definition_has_generator_configured()`; if a generator is set it
instantiates it and calls `generateSampleValue($field_item_list)`. If the generator's
`prevent_save` is on, the original generated value is stashed on `$entity->_sampleValues[...]`
and the `SampleValue` constraint later flags the entity as invalid while that value is unchanged.

No security surface: admin-only field config, no route/callback, generation is explicit and never
triggered by anonymous input. See the solution docs for exact classes/methods.
