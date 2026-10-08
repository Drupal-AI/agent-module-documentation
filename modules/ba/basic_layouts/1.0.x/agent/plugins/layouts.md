<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Layouts — layout plugins & intro text

## The five layouts

Declared in `basic_layouts.layouts.yml` (no annotation/attribute class — pure YAML plugins for the core
Layout API, discovered because the module depends on `layout_discovery`). All share:
`class: \Drupal\basic_layouts\Plugin\Layout\BasicLayout`, `library: basic_layouts/layout`,
`category: Basic Layouts`.

| Plugin id | Template | Regions | default_region |
|-----------|----------|---------|----------------|
| `one_column` | `layouts/one-column` | content | content |
| `one_column_grid` | `layouts/one-column` | content | content |
| `two_column` | `layouts/two-column` | first, second | first |
| `three_column` | `layouts/three-column` | first, second, third | first |
| `four_column` | `layouts/four-column` | first, second, third, fourth | first |

Note `one_column` and `one_column_grid` reuse the SAME template (`one-column.html.twig`); the "grid"
variant is a distinct plugin id/label only — any grid behavior would come from CSS in `css/styling.css`
or from Layout Builder Styles, not from a separate template.

## Plugin class — `BasicLayout` (`src/Plugin/Layout/BasicLayout.php`)

Extends `Drupal\Core\Layout\LayoutDefault` and implements `PluginFormInterface`.

- `defaultConfiguration()` adds `use_intro_text => FALSE` and `intro => ''` to the parent defaults.
- `buildConfigurationForm()` adds two per-section fields to the section-settings form:
  - `use_intro_text` — checkbox, "Display text at the top of the section".
  - `intro` — a core `text_format` element (title "Intro"), default format `full_html`, shown only when
    the checkbox is ticked (`#states` visible on `layout_settings[use_intro_text]`).
- `submitConfigurationForm()` stores `$form_state->getValue('intro')` (an array `{value, format}`) and
  `use_intro_text` into `$this->configuration`.
- `build($regions)` calls `parent::build()`, then — only if `use_intro_text` is truthy and
  `intro.value` is non-empty — adds `$build['intro']` as `#type => processed_text` with the saved
  `#text` and `#format`. `processed_text` runs the text through the named text format's filter pipeline,
  so the stored format governs what markup survives.

The intro render array appears in the layout build under the key `intro`; templates output it as
`{{ content.intro }}` inside a `.layout__content--intro_text.layout-builder__region` wrapper.

## Templates (`layouts/*.html.twig`)

Standard region-render overrides. Each builds a `classes` array
(`layout`, `layout--{{ layout.id|clean_class }}`, `layout--onecol|twocol|threecol|fourcol`, `clearfix`),
optionally prints an editor-controlled `content.title` (from Layout Builder Sections Config; wrapped in a
configurable element, classes filtered/merged with `section-title`), then the intro, then each present
region wrapped with `region_attributes.<region>.addClass('layout__column', 'layout__column--<name>')`.
All dynamic values are auto-escaped render arrays / Attribute objects; `layout.id` passes through
`clean_class`.

## Operating

- Enable: `drush en basic_layouts`. The layouts then appear under the "Basic Layouts" category in the
  Layout Builder "Choose a layout / Add section" UI, and in the per-content-type Manage Display layout list.
- Per section, tick "Display text at the top of the section" and fill "Intro" to render lead copy above
  the columns.
- Styling: shipped `css/styling.css` (library `basic_layouts/layout`, attached automatically), or override
  the Twig templates in a theme, or layer Layout Builder Styles / Layout Builder Sections Config.
