Field Sample Value makes Drupal's per-field sample value generation pluggable, letting a site builder configure a sample value generator on any field and then populate entities with those values.

---

Drupal core can generate throwaway "sample" values for a field, but the algorithm is fixed and often unrealistic. Field Sample Value turns that into a plugin system: on each field's settings form it adds a "Set sample value" checkbox and a radio list of sample value generator plugins (field-type default, random words, random text with a chosen filter format, and a published-entity picker for entity reference fields), each with its own configuration. The selection is saved as a third-party setting on the field config entity. A `field_sample_value.generator` service (`SampleValueEntityGenerator`) then creates or populates a fieldable entity, running the configured generator only on fields that have one and leaving every other field to its normal default. An optional "Prevent save" flag, backed by a `SampleValue` validation constraint, blocks saving an entity while a generated placeholder is still unchanged — useful for demo/preview content that must be edited before it goes live. It is a site-building and development convenience; there is no route, no permission, and no end-user-facing surface of its own.

---

- Configure a per-field sample value generator from Manage fields > Edit field, under "Set sample value".
- Pick the "Field type default" generator to defer to core's own `generateSampleItems()` for a field.
- Generate realistic "Random words" for plain `string` and `string_long` fields with a configurable word count.
- Generate "Random text" (sentences or paragraphs) for `text`, `text_long`, and `text_with_summary` fields.
- Choose which text filter format the random text is stored with, per field.
- Populate an `entity_reference` field with a random existing published entity of the target type/bundle.
- Restrict entity-reference sample selection to the field's configured target bundles.
- Programmatically create a fully populated entity with `createWithSampleValues($entity_type, $bundle, $values)`.
- Populate an already-built entity in place with `populateWithSampleValues($entity)`.
- Populate a single field item list with `populateWithSampleValue($field)`.
- Seed demo or default content with plausible field data during a build or migration.
- Produce preview entities for Layout Builder, design review, or theming work.
- Use "Prevent save" to force editors to replace placeholder text before an entity can be saved.
- Surface a validation message when a field still contains an unchanged generated sample value.
- Set a site-wide fallback filter format for text generators via `drush cset filter.settings fallback_format <format_id>`.
- Add a custom generator by implementing a `SampleValueGenerator` annotated plugin in `Plugin/Field/SampleValueGenerator`.
- Limit a custom generator to specific field types via the plugin's `field_types` annotation.
- Order generators in the radio list with the plugin `weight` annotation.
- Alter or extend the discovered generator list through the `sample_value_generator_info` alter hook.
- Keep fields without a configured generator untouched so their real defaults are respected.
- Enable the module only in development/staging and leave it disabled in production if desired.
- Combine with Default Content or Devel Generate workflows to produce nicer demo data.
- Store generator choice and configuration as portable field config (exportable third-party settings).
