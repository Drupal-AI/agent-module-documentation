<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Facet Link provides field formatters that render an entity-reference (e.g. taxonomy term) field as links pointing at a faceted search page filtered by that value, instead of the referenced entity's own page.

---

The module adds two field formatters for `entity_reference` fields: **`entity_reference_facet_link`** ("Facet link"), which renders each referenced entity's label as a link, and **`entity_reference_facet_url`** ("Facet URL"), which outputs just the URL as markup. Both extend `EntityReferenceFacetFormatterBase`. You pick one on the field's *Manage display* page (or a view) and, in the formatter settings, choose the target **facet** — the settings form only lists facets that are actually faceting the field being configured. The single stored setting is `facet` (the facet config entity id), schema `field.formatter.settings.entity_reference_facet_link`. At render time the formatter loads the chosen `facets_facet` entity, asks the facet's own **URL processor** (via `plugin.manager.facets.url_processor`) to build the link — so links automatically match whatever processor the facet uses, including Facets Pretty Paths, and update if you switch processors. It does this by constructing a `Result` object per referenced entity and calling `buildUrls()`. Cache tags from the referenced entity and the facet source are merged onto each element. The module has no admin page, no permissions, and no Drush; it does nothing on its own — it requires the [Facets](https://www.drupal.org/project/facets) module and an existing faceted search page (typically Search API + Facets + a view) whose facet targets the same field.

---

- Link a node's taxonomy terms to a faceted search page pre-filtered by each term.
- Send visitors from a term shown on a node to search results for that term, not the term page.
- Improve usability on a Search API + Facets site by making reference fields act as facet links.
- Render an author or category reference as a link into the filtered listing for that value.
- Output only the facet URL (no link markup) with the "Facet URL" formatter for custom theming.
- Choose exactly which facet a field links to when the same field feeds multiple search pages.
- Keep field links consistent with Facets Pretty Paths without configuring any paths yourself.
- Automatically update field links when you change the facet's URL processor.
- Configure the formatter per view mode (e.g. teaser links to facets, full page does not).
- Use it on any `entity_reference` field, including taxonomy term reference fields.
- Add facet links to a view's field output as an alternative to the entity's canonical link.
- Provide "more like this" style navigation by linking shared terms to a faceted search.
- Replace the default entity-reference label formatter where the term page is a poor destination.
- Let editors control the destination search page by selecting the facet in the field display.
- Drive on-site discovery by turning content metadata into one-click filtered searches.
- Point brand/manufacturer reference fields to a filtered product search facet.
- Link a "topic" field to the topic facet on a news search page.
- Avoid writing custom Twig/preprocess code to build facet URLs from reference values.
- Support multiple facets of the same field by picking the right one in formatter settings.
- Reuse the facet's exact query-parameter/pretty-path format for perfectly matching links.
- Deploy the formatter choice and its `facet` setting as part of exported display config.
