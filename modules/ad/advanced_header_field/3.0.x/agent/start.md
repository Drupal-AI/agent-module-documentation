<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Header Field (advanced_header_field) — agent index

A single **field type** for a heading: heading text, optional subtitle, optional text-as-link, a
semantic tag (h2-h6) chosen independently of a visual **size** class, extra **style** classes, and a
per-heading anchor id. Built on top of the core **Link** field (its type/widget/formatter all extend
the `link` module classes), so `link` must be enabled even though `*.info.yml` does not declare it.
Package `Field types`. Core `^11 || ^12`. License GPL-2.0-or-later. Version 3.0.x.
Ships submodule **`advanced_header_field_navigation`** (jump menu).

- **Field type, widget, formatters, settings, and how to add the field** →
  [fields/header-field.md](fields/header-field.md)

## What it provides (from source)

- **Field type** `advanced_header_field` — `src/Plugin/Field/FieldType/AdvancedHeaderFieldItem.php`,
  extends `link`'s `LinkItem`. Adds a `subtitle` varchar(255) column and `uri`/`subtitle`
  properties on top of the link columns (`uri`, `title`, `options`). Cardinality 1.
  Storage setting `custom_styles`; field settings `title`, `link_type`, `allowed_tags`.
- **Widget** `advanced_header_field` — `.../FieldWidget/AdvancedHeaderFieldWidget.php`, extends
  `LinkWidget`. A `details` element with Heading Text (title), Subtitle, Semantic Tag, Custom Anchor
  Id, Display Options (visually hidden / size / styles) and Link Options (uri / new window).
- **Formatters**: `advanced_header_field_html` (default, extends `LinkFormatter`,
  `.../FieldFormatter/AdvancedHeaderFieldHtmlFormatter.php`) renders `#theme => advanced_header_field`;
  `advanced_header_field_summary` (admin-only, `FormatterBase`) renders
  `#theme => advanced_header_field_summary` with a copy-anchor-id button.
- **Service** `advanced_header_field.helper` → `AdvancedHeaderFieldHelper`: `getAvailableTags()`,
  `getDefaultSizes()`, `getDefaultStyles()`, `getHeaderParentId()`, `createAnchorIdFromText()`.
- **Hooks** (`src/Hook/AdvancedHeaderFieldHooks.php`, attribute-based): `help`, `theme` (two theme
  hooks + their preprocess), which set the BEM `base_class` and attributes.
- **Templates**: `templates/advanced-header-field.html.twig`,
  `templates/advanced-header-field-summary.html.twig`.
- **Update**: `advanced_header_field_update_10000()` renames the retired
  `advanced_header_field_string` formatter to `advanced_header_field_summary` in view displays.
- **No routes, no permissions, no config schema, no Drush.** Libraries: `admin` (CSS),
  `summary` (JS for the copy button).

## Submodule

- **`advanced_header_field_navigation`** — jump-menu block + widget additions.
  Docs: [../../modules/advanced_header_field_navigation/3.0.x/agent/start.md](../../modules/advanced_header_field_navigation/3.0.x/agent/start.md)
