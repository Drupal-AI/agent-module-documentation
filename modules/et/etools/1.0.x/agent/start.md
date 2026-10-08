<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Etools (etools) — agent index

A small grab-bag of developer/site-builder utilities: one entity helper **service**, two **Twig
functions** wrapping it, and four **field formatters**. Package `Etools`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.0. **No hard dependencies** in `etools.info.yml`; no routes,
no permissions, no config objects/schema, no `.install`, no hooks.

## Solution docs

- **Entity helper service + Twig functions** (`etools.entity`, `etools_field_value`,
  `etools_field_display`) → [api/entity-service.md](api/entity-service.md)
- **Field formatters** (the four plugins, their settings, how to enable) →
  [fields/formatters.md](fields/formatters.md)

## What it actually provides (from source)

- Service `etools.entity` = `Drupal\etools\EtoolsEntity` (`etools.services.yml`,
  `src/EtoolsEntity.php`): `getFieldValue()` and `getFieldDisplay()`.
- Service `etools.twig_extension` = `Drupal\etools\EtoolsTwigExtension` (twig.extension tag),
  exposing Twig functions `etools_field_value` and `etools_field_display` that call the service.
- Field formatters under `src/Plugin/Field/FieldFormatter/`:
  - `etools_er_subset` — `EntityReferenceSubsetFormatter` (entity_reference), subset by bundle/count.
  - `etools_err_subset` — `ERRSubsetFormatter` (entity_reference_revisions), subset by bundle/count.
    Extends an `entity_reference_revisions` class — that module is an **undeclared soft requirement**
    for this formatter only.
  - `etools_entity_reference_link` — `EtoolsEntityReferenceLinkFormatter` (entity_reference):
    label linked to `DESTINATION?QUERY_KEY=ENTITY_ID`.
  - `etools_text_linked` — `TextLinkedFormatter` (string): text linked to a companion link field's URL.
  - Shared logic in `Traits/EntityReferenceSubsetTrait.php`.

No block, form (beyond formatter settings), controller, or route is provided.
