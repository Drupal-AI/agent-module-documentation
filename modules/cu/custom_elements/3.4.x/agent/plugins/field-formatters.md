<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CustomElementsFieldFormatter plugin type

Plugin type `custom_elements_field_formatter`. Manager
`custom_elements.plugin.manager.field.custom_element_formatter`
(`CustomElementsFieldFormatterPluginManager`, discovery dir `Plugin/CustomElementsFieldFormatter`,
annotation `@CustomElementsFieldFormatter`, alter hook `custom_elements_field_formatter_info`).
Base class `CustomElementsFieldFormatterBase` implements `CustomElementsFieldFormatterInterface`.

A formatter maps one CE-display component (a field) into attributes/slots of the parent
`CustomElement`. Annotation keys: `id`, `label`, `field_types` (array), `weight`. Instances are
created by `EntityCeDisplay::getRenderer()` with runtime configuration merged in:
`field_definition`, `view_mode`, `name` (slot/attribute name), `is_slot`, plus the plugin's own
settings. `isApplicable($plugin_id, $field_definition)` gates which fields may use a formatter.
Core method: `build(FieldItemListInterface $items, CustomElement $custom_element, $langcode = NULL)`;
`prepareBuild(array $entities_items)` runs once before per-entity builds.

The base maps the config-schema-friendly plugin *configuration* to the `PluginSettingsInterface`
settings API (they are synonymous here); third-party settings are no-ops by default (core
formatters need the methods).

## Shipped formatters (`src/Plugin/CustomElementsFieldFormatter/*`)

- **`auto`** (`AutoCeFieldFormatter`) — default; delegates to `custom_elements.generator`'s
  processor pipeline, then coerces the result into an attribute or slot per `is_slot`.
- **`plain_text`** (`PlainTextCeFieldFormatter`) — for `string` / `string_long`; trims, optional
  `strip_newlines`, `max_length` (with `wordsafe`, `ellipsis` via `Unicode::truncate`). Emits the
  raw value (no HTML-escaping of its own — see the rendering doc's slot note).
- **`raw`** (`RawCeFieldFormatter`) — the field's raw `getValue()`; single-cardinality flattened;
  arrays JSON-encoded when a slot.
- **`link`** (`LinkCeFieldFormatter`, extends `raw`) — resolves a link field to `href` (plus
  `external` flag), dropping `uri`/`options`.
- **`image`** / **`file`** (`ImageCeFieldFormatter`, `FileCeFieldFormatter`) — file/image
  references with optional `image_style`, `flatten`, `flatten_skip_prefix`.
- **`entity_ce_render`** (`EntityReferenceCeFieldFormatter`) — for `entity_reference` /
  `entity_reference_revisions`; renders each referenced entity (via `generator->generate()`) with a
  chosen view `mode`, as nested slot elements or normalized prop values (`flatten`, `hide_element`).
- **`entity_bundle_type`** (`BundleTypeCeFieldFormatter`) — outputs the target bundle-config id of
  a reference (e.g. `node_type`); optional `skip_access_check` to emit the id without checking the
  referenced config entity's `view` access (for anon front ends lacking admin perms).
- **`timestamp`** (`TimestampCeFieldFormatter`) — formatted date (`date_format` /
  `custom_date_format` / `timezone`).
- **`path`** (`PathFieldFormatter`) — path/alias, optional `absolute`.
- **`flattened`** (`FlattenedCeFieldFormatter`) — flattens field properties into the parent.
- **`canvas`** (`CanvasFormatter`) — Canvas render integration.
- **`field:<core-formatter-id>`** (`CoreFieldCeFieldFormatter` + `…Deriver`) — wraps **any core
  field formatter**; persists `type` (the bare core id) so config schema resolves
  `field.formatter.settings.<id>` (backfilled by `custom_elements_update_9402`).

## Adding one

Create `Plugin/CustomElementsFieldFormatter/MyFormatter.php` with `@CustomElementsFieldFormatter`,
extend `CustomElementsFieldFormatterBase`, implement `build()` (and `isApplicable()` /
`field_types` to scope it). Use `isSlot()` / `getName()` to decide attribute vs slot, and helper
traits `CustomElementsFieldFormatterUtilsTrait` (`setValue`, `setMultipleValue`,
`getFieldItemProperties`) / `CustomElementsImageStyleConfigTrait`. Add config schema under
`custom_elements.field_formatter.configuration.<id>` (a permissive `type: ignore` fallback exists).

The `custom_elements_extra_formatters` submodule adds `ce_tablefield` (tablefield → JSON structure).
