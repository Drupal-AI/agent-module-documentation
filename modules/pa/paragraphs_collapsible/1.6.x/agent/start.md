<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Collapsible — agent index

Zero-config front-end enhancement: adds Expand all / Collapse all + per-row `[+]`/`[-]` toggles
to the **classic** Paragraphs edit widget. No settings form, no configure route
(`configure: null`), no permissions, no Drush, no config, no plugins. Requires `paragraphs`.
Enabling the module is the whole setup.

- **How it hooks in (library alter), the widget it targets, the JS behavior/markup** →
  [theming/mechanism.md](theming/mechanism.md)

Key facts:
- One PHP hook: `paragraphs_collapsible_library_info_alter()` makes
  `paragraphs_collapsible/paragraphs_collapsible.widget` a dependency of Paragraphs'
  `drupal.paragraphs.admin` library.
- The JS only enhances the classic table widget **`entity_reference_paragraphs`**
  (`.field--widget-entity-reference-paragraphs`), and only rows with a `.paragraph-type-title`.
- No effect on the modern `paragraphs` (stable) widget or on rendered output — editing UI only.
