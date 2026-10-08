<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expandable Formatter (expandable_formatter) — agent index

A single field formatter that displays a text field trimmed to a fixed **pixel height** with a
JavaScript **expand/collapse** ("read more") toggle. Package: none declared. Depends only on core
**`field`**. Core requirement `^8.7.7 || ^9 || ^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version dir 1.0.x (dev checkout; `.info.yml` has no `version:`).

- **The formatter, every setting, theming, JS behavior, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `ExpandableFormatter` (id **`expandable_formatter`**, label *"Expandable"*) in
  `src/Plugin/Field/FieldFormatter/ExpandableFormatter.php`, extending core `FormatterBase`.
- `field_types = { "text", "text_long", "text_with_summary", "string_long" }` — targets core
  text/long-string fields only. Selected per view-display on *Manage display*.
- **No** routes, permissions, services, entities, install file, submodules, Drush, or site-wide
  settings form. The only config is the per-display formatter settings.

## Provides

- **Formatter plugin** `expandable_formatter` (see above).
- **Theme hook** `expandable_formatter` (`expandable_formatter_theme()` in the `.module`),
  template `templates/expandable-formatter.html.twig`; variables `attributes`, `use_ellipsis`,
  `content`, `trigger_classes`.
- **Asset library** `expandable_formatter/expand` (`expandable_formatter.libraries.yml`):
  `js/expandable-formatter.js` (`Drupal.behaviors.expandableFormatter`) +
  `css/expandable-formatter.css`; depends on `core/jquery`, `core/drupal`, `core/drupalSettings`.
- **Config schema** `field.formatter.settings.expandable_formatter`
  (`config/schema/expandable_formatter.schema.yml`) — no `config/install`.

## Settings (`defaultSettings()`)

`collapsed_height` (20), `use_ellipsis` (TRUE), `effect` (`slide`; or `none`),
`trigger_expanded_label` (`Expand`), `trigger_collapsed_label` (`Collapse`),
`trigger_classes` (`button`), `js_duration` (500). Details, form, and rendering pipeline in
[fields/formatter.md](fields/formatter.md).
