<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto heading ids (auto_heading_ids) — agent index

Text-format **filter that auto-adds `id` attributes to headings** (h2–h6), derived from heading
text, so headings become anchor targets (jump-to-section, TOC, deep links). Version
**2.0.0-beta3**. Core `^8 || ^9 || ^10 || ^11`. Package: Custom.

- **Dependencies:** core `filter` only. No composer requires, no other module deps.
- **Provides:** one filter plugin `heading_id_filter`
  (`Drupal\auto_heading_ids\Plugin\Filter\HeadingIdFilter`, weight 10,
  `TYPE_TRANSFORM_IRREVERSIBLE`). No routes, no permissions, no services, no config schema, no
  submodules, no drush.
- **Configure:** no dedicated settings route — enable the filter per text format at
  `/admin/config/content/formats`. The filter has no per-filter settings form.
- **Nature:** display-only. Changes rendered output, not stored values; no access-control role.

Solution docs:
- [Filter plugin](agent/filters/heading_id_filter.md) — how the filter works, id generation, enabling.
