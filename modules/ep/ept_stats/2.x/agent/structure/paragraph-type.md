<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ept_stats — paragraph types, fields, styles, templates

Everything ept_stats installs is default config in `config/install/` plus one widget, one hook, two
templates and three CSS libraries. There is no config object, no schema, no route, no permission.

## Install / enable

Requires `ept_core` and `paragraphs` (Composer: `drupal/ept_core:^2.0`, `drupal/paragraphs:^1.0`).
EPT relies on a **Media "Image"** type existing before install (used by the item image field);
create it first if missing (`Structure » Media types » Add media type`). Enable:
`drush en ept_stats -y`. Installing imports the two paragraph types, their fields, and default
form/view displays.

## Paragraph types (`paragraphs.paragraphs_type.*`)

- **`ept_stats`** — the container/component. Label "EPT Stats".
- **`ept_stats_item`** — one statistic. Label "EPT Stats Item". Referenced only from
  `ept_stats.field_ept_stats`.

Neither declares any `behavior_plugins`.

## Fields

On **`ept_stats`** (`field.field.paragraph.ept_stats.*`):

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_title` | `text_long` | Optional heading, rendered in `<h2>`. |
| `field_ept_text`  | `text_long` | Optional intro/description. |
| `field_ept_stats` | `entity_reference_revisions` | **required**, unlimited; target bundle `ept_stats_item`. |
| `field_ept_settings` | `ept_settings` (from ept_core) | Design settings + style radios. |

On **`ept_stats_item`** (`field.field.paragraph.ept_stats_item.*`):

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_stats_item_number` | `text_long` | The big number (e.g. "500+"); free text. |
| `field_ept_stats_item_text`   | `text_long` | Caption/label under the number. |
| `field_ept_stats_item_image`  | `entity_reference` → Media `image` | Optional icon. |
| `field_ept_stats_item_link`   | `link` | Optional link (title optional, `link_type: 17`). |

All text fields use `allowed_formats: {}` (no format restriction) and the `text_default`
formatter in the default view display — so output is filtered by the chosen text format on render.

## View display (`core.entity_view_display.paragraph.ept_stats.default`)

Order: title (weight 0), text (1), `field_ept_stats` via
`entity_reference_revisions_entity_view` (2, default view mode), settings (3, `ept_settings_default`
formatter, hidden label). The item display shows image, number, link, text; all labels hidden.

## Style selection — `EptSettingsStatsWidget`

`src/Plugin/Field/FieldWidget/EptSettingsStatsWidget.php` (id **`ept_settings_stats`**,
`field_types = { ept_settings }`) extends ept_core's `EptSettingsDefaultWidget`. Its
`formElement()` adds a `styles` **radios** element with three options:

- `stats_with_vertical_dividers` (default)
- `stats_in_squares`
- `stats_in_column`

The description embeds `<a>` links to the example PNGs under
`/modules/.../ept_stats/images/help/` (path resolved via `extension.path.resolver`).
`massageFormValues()` just ensures each value has an `ept_settings` key. The chosen value is stored
inside the `field_ept_settings` (`ept_settings`) item, alongside ept_core's shared design options.

## Templates & libraries

`templates/paragraph--ept-stats--default.html.twig`:
- Builds wrapper classes including `ept-stats-<styles>` read from
  `content.field_ept_settings['#object'].field_ept_settings.ept_settings.styles`.
- `attach_library()` for the matching `ept_stats/<style>` CSS bundle (falls back to
  `stats_with_vertical_dividers`).
- Renders `field_ept_title` in `<h2>`, then `field_ept_text`, then `field_ept_stats`.
- Ends with `{{ styles|raw }}` — this is the **per-instance design CSS string produced by ept_core's
  ept_settings** (colors/spacing/background), a family-wide EPT pattern, not user-entered markup.

`templates/field--paragraph--field-ept-stats--ept-stats.html.twig` is a field template (adds
`ept-stats-wrapper` class) registered at runtime by
`EptStatsHooks::themeRegistryAlter()` — it clones core's `field` theme entry and points it at this
template for `field__paragraph__field_ept_stats__ept_stats`.

Libraries (`ept_stats.libraries.yml`): `stats_with_vertical_dividers`, `stats_in_squares`,
`stats_in_column`, each a single component CSS file in `css/`.

## Operate

1. Enable the module; the paragraph types appear wherever a Paragraphs (entity_reference_revisions)
   field allows them — add `ept_stats` to a node's paragraph field.
2. Edit content: set Title/Text, add one or more Stats items (number + text, optionally image/link),
   pick a Style, adjust ept_core design options.
3. Sitewide colors/breakpoints come from ept_core at `/admin/config/content/ept-core`; there is no
   ept_stats-specific admin form.
