<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-section & per-region attributes (storage, rendering, tokens)

Editors set these in Layout Builder's **Configure section** form (the module alters it). The
values are stored in the **layout plugin configuration** of that section (inside the section
storage — `layout_builder__layout` field on an entity for overrides, or the
`entity_view_display` for defaults), not in a dedicated config object.

## Section-level keys (on the layout config)

| Form field | Config key | Notes |
|---|---|---|
| ID | `custom_id` | single HTML id |
| Custom Class(es) | `custom_classes` | space-separated classes (free text) |
| Choose classes | `custom_class_choose` | map of predefined class → on/off (from `class_list`) |
| Style | `custom_styles` | inline CSS |
| Data-* attributes | `custom_data_attributes` | one per line, `data-name|value` (value optional) |

## Region-level keys

Under `regions.<region_id>`: `region_id`, `region_classes`, `region_class_choose`,
`region_styles`, `region_data` (same meanings, per region).

Config schema for these lives under `layout_plugin.settings.*` in
`config/schema/layout_custom_section_classes.schema.yml`.

## How they render

`hook_preprocess_layout()` reads the global `allowed_*` toggles and, for each enabled attribute,
adds the value to the layout's render variables:
- `custom_class_choose` (checked) and `custom_classes` → `attributes.class[]`
- `custom_id` → `attributes.id`
- `custom_styles` → `attributes.style[]`
- `custom_data_attributes` → split on newlines, each `name|value` → `attributes[name]`
- region equivalents → `region_attributes.<region>` (via the `Attribute` object).

**The layout template must print these.** Core's `layout--onecol.html.twig` does
`{{ attributes.addClass(classes) }}` and `{{ region_attributes.content.addClass(...) }}`; a custom
layout that hard-codes its wrapper without `{{ attributes }}` / `{{ region_attributes.REGION }}`
will silently drop the classes.

## Tokens

If the contrib **Token** module is enabled, the free-text fields (`custom_id`, `custom_classes`,
`custom_styles`, `custom_data_attributes`, and the region equivalents) accept tokens and show a
"Browse available tokens" link. Tokens are resolved at render time in `hook_preprocess_layout()`
via `\Drupal::token()->replacePlain()` using the entity being rendered as context (e.g.
`[node:nid]`), so a section class/id can derive from the host entity.
