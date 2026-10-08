<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox — decoupled formatters, the Decoupled view mode, location solver

## The Decoupled view mode

`EntityViewDisplayManager` (service `decoupled.entity_view_display.manager`, an
`EventSubscriber` on `EntityTypeEvents::CREATE`, plus `hook_entity_bundle_create` and
`hook_install`) creates a view mode with machine id **`decoupled`**
(`ENTITY_DECOUPLED_VIEW_MODE_ID`) and a display for every content entity type/bundle that has a
`field_ui_base_route` and a view builder. Configure output at *Manage display → Decoupled*.
If the view mode is missing you can recreate it manually with the `decoupled` machine name.

Only fields whose renderer implements `DecoupledFormatterInterface` are serialized
(`DecoupledRenderer::renderEntity()` skips any other renderer). **Standard core formatters
produce no output.** A field is skipped when `decoupled_field_hide_empty` is on and the field is
empty. Fields are ordered by their view-display weight.

## Common formatter settings (`DecoupledFormatterBase::defaultSettings()`)

Every decoupled formatter exposes:

- `decoupled_field_key` (**required** on render; empty ⇒ field silently dropped via
  `InvalidFormatterSettingsException`) — the JSON key that replaces the Drupal field machine
  name.
- `decoupled_field_location` (default `''`) — where to place the value in the output tree; see
  location solver below. Token-aware (a `token_tree_link` is shown when the Token module is on).
- `decoupled_field_hide_empty` (default TRUE) — omit the field when empty.
- `decoupled_forced_multiple_output` (default FALSE) — always emit as an array even for a single
  value.
- `decoupled_field_output` — informational output-type hint from `getOutputDefinitions()`.

`GenericDecoupledFormatter::viewFieldItem()` escapes scalar text with
`nl2br(Html::escape(...))` (`DecoupledFormatterBase::escapeOutput()`). The `_generic_raw` and
`_json` formatters intentionally bypass that escaping (raw/JSON-decoded output) — use them only
for trusted field data.

## Shipped formatters (base module, `src/Plugin/Field/FieldFormatter/`)

| Plugin id | Class (extends) | Notes |
|-----------|-----------------|-------|
| `decoupled_generic` | `GenericDecoupledFormatter` (base) | HTML-escaped scalar string; parent of most others. |
| `decoupled_text` | `TextDecoupledFormatter` | Text fields. |
| `decoupled_integer` | `IntegerDecoupledFormatter` | Integer output. |
| `decoupled_float` | `FloatDecoupledFormatter` | Float output. |
| `decoupled_boolean` | `BooleanDecoupledFormatter` | Casts 1/0 to JSON `true`/`false` via `filter_var(... FILTER_VALIDATE_BOOLEAN)`. |
| `decoupled_timestamp` | `TimestampDecoupledFormatter` | Timestamp/date output. |
| `decoupled_link` | `LinkDecoupledFormatter` | Link field. |
| `decoupled_link_url` | `LinkUrlDecoupledFormatter` | Link field, URL only. |
| `decoupled_path` | `PathDecoupledFormatter` | Emits the path field `alias` value. |
| `decoupled_list_key` | `OptionsKeyDecoupledFormatter` | List field key (not label). |
| `decoupled_json` | `JsonDecoupledFormatter` | JSON-decoded field value (unescaped). |
| `decoupled_generic_raw` | `RawGenericDecoupledFormatter` | Raw unescaped value. |
| `decoupled_file` | `FileDecoupledFormatter` (`EntityReferenceDecoupledFormatterBase`) | Absolute file URL (`createFileUrl(FALSE)`); optional `include_mime_type` and `include_file_content` (the latter inlines `file_get_contents()` — enable only intentionally). |
| `decoupled_image` / `decoupled_generic_image` | `ImageDecoupledFormatter` / `ImageGenericDecoupledFormatter` (`FileDecoupledFormatter`) | Image field variants. |
| `decoupled_entity_reference` | `EntityReferenceDecoupledFormatter` | Embeds the referenced entity, rendered through its own decoupled display. |
| `decoupled_entity_reference_id` | `EntityReferenceIdDecoupledFormatter` | Emits target ids only. |
| `decoupled_entity_reference_field` | `EntityReferenceFieldDecoupledFormatter` | Referenced entity, selected fields. |

Entity-reference embedding recurses through `DecoupledRenderer`, which keeps a
`currentEntityRenderStack` and emits `{id, infiniteInclusionPrevention: true}` when it detects a
reference cycle. Missing/deleted references throw `InvalidContentException`; enable
*Ignore missing entity references* in settings (or the `ignore_missing_entity_reference`
formatter path) to skip them silently.

## Location solver (`decoupled.location_solver`, `LocationSolver`)

Subscribes to `EVENT__CONTROLLER__ON_RENDERED_OUTPUT_BUILT` and re-places each field's
`FieldValueAndOptions` according to its `decoupled_field_location`:

- empty location → value stays at `{decoupled_field_key: value}`.
- `parent/subparent` → nested `{parent: {subparent: {key: value}}}`.
- leading-slash `/absolute/path` → placed from the output root; a trailing empty segment appends
  into a numerically-indexed array.

Location strings are run through `token->replace()` with the current entity as token data, so
token cache tags are collected.

## Add support for a new field type

Create a formatter plugin extending `GenericDecoupledFormatter` (or
`EntityReferenceDecoupledFormatterBase` for reference-like fields), set `field_types` in the
`@FieldFormatter` annotation, and override `viewFieldItem()` (and `getOutputDefinitions()`).
The sub-modules (`decoupled_toolbox_color_field`, `_duration_field`, `_weight`,
`_comment`) are minimal examples of exactly this pattern.
