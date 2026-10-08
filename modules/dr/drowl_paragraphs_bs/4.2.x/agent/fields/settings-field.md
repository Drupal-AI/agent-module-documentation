<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `drowl_paragraphs_bs_settings` field + shared paragraph field storages

## Field type `drowl_paragraphs_bs_settings`

Plugin `\Drupal\drowl_paragraphs_bs\Plugin\Field\FieldType\DrowlParagraphsBsSettingsItem`
(id `drowl_paragraphs_bs_settings`, category `drowl_paragraphs_bs`, default widget/formatter
`drowl_paragraphs_bs_settings_default`). Bundle sub-modules attach this field as `field_settings`
(storage `config/install/field.storage.paragraph.field_settings.yml`) to every Paragraph type; the
field is hidden on display and drives preprocessing (see [../api/behaviors.md](../api/behaviors.md)).

Stored columns/properties (`schema()` / `propertyDefinitions()`), for animation slots `1..4`:
- `style_animation_{i}_events` (varchar 64) — `enter-viewport` / `leave-viewport` / `hover`.
- `style_animation_{i}_animation` (varchar 64) — an animate.css name (bounce, fadeIn, zoomOut, …).
- `style_animation_{i}_offset` (tinyint) — viewport visibility % trigger (0–100).
- `style_animation_{i}_delay` (small uint) — start delay in ms.
- `style_animation_{i}_transition_duration` (small uint) — duration in ms.

Plus: `equal_height_group` (varchar 255), `classes_additional` (varchar 2048), `id_attr` (varchar 128).

`isEmpty()` treats the item empty unless a non-`_attributes` value is set. **`preSave()` sanitizes**
author input: `classes_additional` is split on spaces and each token run through
`Html::getClass()`; `equal_height_group` and `id_attr` are run through `Html::cleanCssIdentifier()`.
So stored classes/id/group are always CSS-safe identifiers.

## Widget `drowl_paragraphs_bs_settings_default`

`\Drupal\drowl_paragraphs_bs\Plugin\Field\FieldWidget\DrowlParagraphsBsSettingsDefaultWidget`.
Renders a "Animations" details group with 4 animation sub-details (event trigger select, viewport
offset select, animate.css animation select grouped by family, delay `number`, duration `number`),
plus expert textfields for equal-height group, additional classes and custom id. Single widget setting
`open` (bool, default FALSE) controls whether the outer details opens by default. `massageFormValues()`
flattens the nested form array into a flat `key => value` per delta via `RecursiveIteratorIterator`.

## Formatter `drowl_paragraphs_bs_settings_default`

`\Drupal\drowl_paragraphs_bs\Plugin\Field\FieldFormatter\DrowlParagraphsBsSettingsDefaultFormatter`.
`viewElements()` renders each property inside a container using **`#plain_text`** (Twig/Drupal
auto-escaped) with a `Html::cleanCssIdentifier(name)` class. The field is hidden on all shipped
displays, so this formatter is effectively a debug/fallback renderer; its output is escaped.

## Shared field storages (`config/install/field.storage.paragraph.*`)

The base module installs paragraph field storages reused across bundle sub-modules so the same field
name is shared:

- `field_settings` — the settings field above.
- `field_paragraphs` — nested paragraphs (entity reference revisions).
- `field_title`, `field_subtitle`, `field_text` — common text fields.
- `field_image`, `field_background_media`, `field_image_zoomable`, `field_resp_imagestyle` — image/media
  + responsive-image-style selection + zoom toggle.
- `field_icon`, `field_link`, `field_anchor_id`, `field_nodeentityrefvm` — icon, link, anchor id, and the
  entity-reference view-mode selector.

Each bundle sub-module ships its own `field.field.paragraph.<bundle>.<field>` instances binding these
storages to its Paragraph type (documented per sub-module). The `field--field-paragraphs-paragraphs`
template (`templates/fields/`) themes nested paragraph lists.
