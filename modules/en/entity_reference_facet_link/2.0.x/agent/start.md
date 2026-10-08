<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Facet Link — agent index

Two **field formatters** for `entity_reference` fields that render references as links to a
faceted search page (filtered by the referenced value), instead of the entity's own page.
No admin page, no permissions, no Drush. Requires the **Facets** module and an existing
faceted search page.

- **The two formatters, their settings, and how to configure/render them** →
  [plugins/formatters.md](plugins/formatters.md)

Key facts:
- Formatter ids: **`entity_reference_facet_link`** ("Facet link", renders a link) and
  **`entity_reference_facet_url`** ("Facet URL", renders the URL as markup).
- Single formatter setting **`facet`** = the target `facets_facet` config-entity id
  (schema `field.formatter.settings.entity_reference_facet_link`).
- Links are built by the facet's own URL processor (`plugin.manager.facets.url_processor`),
  so they match Facets Pretty Paths etc. automatically.
- Configured on a bundle's *Manage display* / a view; stored in the `entity_view_display`
  config as `content.<field>.type` + `settings.facet`.
