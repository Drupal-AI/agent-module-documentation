<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Section Classes — agent index

Lets a **layout definition** declare selectable CSS classes so that, in Layout Builder, each
section gets class dropdowns whose values are applied to the section wrapper. Developer-facing:
no UI, no configure route, no permission, no service, no Drush, no config schema. Depends on
`layout_discovery`.

- **Declare selectable classes on a layout (`classes:` YAML format, region_classes, attributes)** →
  [configure/classes-definition.md](configure/classes-definition.md)
- **How it works: the layout-class swap, where selections are stored, how they render** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- `hook_layout_alter()` swaps any `LayoutDefault` layout that declares a `classes:` key to
  `Drupal\layout_section_classes\ClassyLayout`. No `classes:` key → not affected.
- Selected values are stored in the section's layout config at
  `additional.classes.<group>` and appended to the section's `#attributes['class']` at build.
- A group can also declare `region_classes` (classes onto named regions) and `attributes`
  (HTML attributes like `data-*` on the section) keyed by the chosen class string.
