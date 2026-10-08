<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Tags formatter

Renders saved values as the same colored tags on view pages, for both entity-reference and list
fields. Two plugins, both labelled *"Better Tags"*, sharing `Traits/TagsFormatterTrait.php`:

- **`better_entity_reference_tags`** — `TagsFormatter`
  (`src/Plugin/Field/FieldFormatter/TagsFormatter.php`), `field_types = { entity_reference }`,
  extends `EntityReferenceFormatterBase`.
- **`better_options_tags`** — `OptionsTagsFormatter` (`OptionsTagsFormatter.php`), list fields.

Select it on **Manage display**.

## Settings (schema `field.formatter.settings.better_entity_reference_tags` / `.better_options_tags`)

- `inherit_colors` (TRUE) — reuse the color settings from the field's Better widget on the default
  form display. When off, the formatter's own `colored`, `color_mode`, `shade_color`,
  `color_style` apply. Inheritance (`applyInheritedColors()`) reads the form display component and
  merges the widget's color keys, adding the display's cache tags so switching widgets invalidates
  the rendered output.
- Entity-reference only: `link` (TRUE) — link each tag to the referenced entity's canonical page.

`settingsSummary()` lists the active choices; only the small tag CSS
(`better_entity_reference/display`) loads on view pages, none of the form JS.

## Rendering (safe by construction)

`viewElements()` iterates `getEntitiesToView()` (honoring entity view access), builds each tag via
`tagBuild()`:

- Label is emitted as `['#plain_text' => $label]`, or a `#type => link` when linked — both
  auto-escaped by core.
- Color goes into a `style` attribute only after `ColorGenerator::resolveColor()` has validated it
  to a `#rgb`/`#rrggbb` hex (an entity-supplied `color`/`field_color` that is not valid hex is
  discarded in favor of a generated color), so the style value cannot break out.
- Descriptions used elsewhere come from `OptionMetadata::description()`, which `strip_tags()` its
  input.

Cache tags of every rendered entity (plus the inherited display's) are merged onto the wrapper.
