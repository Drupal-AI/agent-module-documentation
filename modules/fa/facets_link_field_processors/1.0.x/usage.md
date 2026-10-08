<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a Facets build processor for core Link fields that displays the referenced entity's translated label instead of the raw link URI.

---

Facets link field (package Search) adds one Facets processor plugin, TranslateEntityInLinkProcessor
("Transform entity link to label"), for facets built on Drupal's core Link field. When a facet's raw value is an
internal entity link — a routed `entity.<type>.canonical` URI such as `entity:node/1` — the processor loads the
referenced entity, uses its current-language translation when one exists, and shows that entity's label as the
facet value in place of the URI. An optional "Remove non entities" setting hides results whose link does not
resolve to a content entity (for example plain external URLs). The processor only offers itself on link fields
configured to allow internal/generic URLs, and it runs at the build stage. The module depends on the Facets
module and ships nothing else — no settings form, routes, permissions, services or config of its own; you enable
the processor per facet in the Facets admin UI.

---

- Show human-readable entity labels in a facet built on a core Link field instead of raw URIs.
- Relabel a link-field facet value like `entity:node/1` with the linked node's title.
- Display the translated label of the referenced entity in the visitor's current language.
- Turn internal entity links stored in a link field into readable facet options.
- Keep taxonomy-term links in a link field showing their term names as facet values.
- Improve the readability of a "related content" link-field facet.
- Enable the "Transform entity link to label" processor on a facet in the Facets UI.
- Hide facet results whose link does not point to an entity by turning on "Remove non entities".
- Facet on a link field that mixes internal and external URLs and label only the internal ones.
- Support multilingual sites by displaying the entity translation matching the current language.
- Provide the processor only on link fields set to allow internal/generic link types.
- Avoid writing a custom Facets processor to resolve link-field entities to labels.
- Present editor-facing internal links as titles in a search facet.
- Build a faceted search over content that references other entities via a link field.
- Let site builders configure entity-label facets purely through the Facets admin UI.
- Reuse core Link field data as a labelled facet without adding an entity-reference field.
- Combine with other Facets processors (sorting, counts) at their respective stages.
- Drop non-entity link values from a facet list to keep options tidy.
- Show the canonical entity's label for `entity:taxonomy_term/…` or `entity:node/…` link values.
- Document a repeatable pattern for labelling link-field facets across multiple sites.
