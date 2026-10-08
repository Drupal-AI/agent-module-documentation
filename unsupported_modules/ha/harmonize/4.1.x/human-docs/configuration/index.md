# Configuration

All of Harmonize's administration lives under **Configuration → Harmonize**
(`/admin/config/harmonize`) and on your entity bundle edit forms. Every admin
screen requires the core **Administer site configuration** permission, so log in
as an administrator first.

## Turn on preprocessing for a bundle

Harmonize does nothing until you enable it for a specific entity bundle (a
content type, paragraph type, taxonomy vocabulary, and so on):

1. Edit the bundle — for example **Structure → Content types → *(your type)* →
   Edit**.
2. Find the **Harmonize settings** section that the module adds to the bundle
   edit form and enable preprocessing there.
3. Save the bundle, then open the **Manage preprocessing** tab that Harmonize
   adds. This is where you choose exactly which fields on the bundle are
   harmonized into the `harmony` array. Access to this tab is governed by
   Harmonize's own access check in addition to the site-configuration
   permission.

Once preprocessing is on, templates for that bundle receive a `{{ harmony }}`
variable holding a clean, normalised array of the fields you selected — including
values from nested entities such as referenced media, files, paragraphs and
taxonomy terms.

## Styles — reusable field render settings

A **Style** is a saved, reusable definition of how a particular field should be
rendered within the harmonized output. Create and manage Styles from the
Harmonize admin area. When you configure a Style you get an **autocomplete of
entity fields**, so you can point the Style at the right field without memorising
machine names, then reuse that Style across bundles for consistent output.

## Entity Processing Rules

The **Entity Processing Rules** screens (add / edit / delete, under
`/admin/config/harmonize`) let you define how harmonization behaves per entity
type or per bundle — a central place to manage the processing behaviour rather
than configuring each bundle in isolation.

## Cache configuration

Harmonize keeps its harmonized data in a dedicated cache bin (`cache.harmonize`)
and provides a **cache configuration form** in the same admin area so you can
tune that caching. Because harmonization runs before template rendering, caching
its output is what keeps the performance overhead in check — leave caching
enabled in production.

## Visualizer

The **Visualizer** renders the structure of the `harmony` array for a given
entity, so developers can see exactly what keys and values are available in the
template before writing Twig. It is a read-only inspection tool.

## For developers: events and the service

- **Events** — Harmonize dispatches events (entity, field, form, menu and region
  harmonization events) that let custom modules reshape the harmonized output.
  See the module's `harmonize.api.php` for the documented hooks and events.
- **The `harmonize` service** — you can call the `harmonize` service directly
  from custom code to harmonize an entity yourself, and use the Twig extension's
  functions and filters to reach harmonized data in templates.

These developer extension points are described in more detail in the sibling
[`agent/api/service.md`](../../agent/api/service.md) reference.
