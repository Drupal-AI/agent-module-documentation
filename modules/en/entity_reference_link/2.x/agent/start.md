<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Link (entity_reference_link) — agent index

Single **field formatter** for core `entity_reference` fields that builds a **custom link** per
referenced item — target from a named Drupal route or a custom `href` template, using the referenced
ID, the referencing (host) entity ID, and the referenced label. Version dir **2.x** (installed
2.0.1). Info name: *"Entity Reference Custom Link Formatter"*, package `Fields`.

- **Dependency:** core `field` only. No composer requirements, no sub-modules.
- **Provides:** one plugin — field formatter `entity_reference_link` (label *"Entity Reference
  Custom Link"*), `field_types = { entity_reference }`, class
  `Drupal\entity_reference_link\Plugin\Field\FieldFormatter\EntityReferenceLinkFormatter`.
- **Provides nothing else:** no routes, services, hooks, permissions, Drush, config schema, or
  install file. All config is per view-display formatter settings.
- **Tokens** (inline Twig, in URL / attributes / link-text / templates): `{{ id }}` referenced
  entity ID, `{{ referencing_id }}` host entity ID, `{{ label }}` referenced entity label.

## Solution docs

- [The custom-link formatter](fields/formatter.md) — enable it, every setting key, the two URL
  modes (route vs custom href), token/Twig rendering, and multi-value list options.
