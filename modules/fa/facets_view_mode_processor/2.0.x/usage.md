<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets View Mode Processor renders each facet item through an entity **view mode** rather than as a plain label, so an entity-reference facet can display the referenced entity's image, description or any other field instead of just its name.

---

Facets normally render as a list of labels with counts, which is right for most filters but limiting when the facet's values are entities with something worth showing — a brand with a logo, a category with an icon and blurb, an author with a photo. Doing that by hand means overriding the facet template and loading each entity yourself. This module adds a single Facets **processor** plugin, "Transform entity ID to view mode" (id `translate_view_mode_entity`), that you enable per facet: it takes each result's referenced entity id, loads the entity, renders it in a view mode you pick, and uses that markup as the facet item's display value. Because the rendering is just a normal entity view mode, it is configured in Manage Display like everything else and the facet reuses whatever displays the site already has. It only applies to facets built on an entity-reference field (it derives the target entity type from the facet's data definition and refuses fields that aren't references). It requires the Facets module (`^2.0 || ^3.0`) and core `^9.3 || ^10 || ^11`. The trade-off is cost: rendering an entity per item is much heavier than printing a label — a facet with a hundred values renders a hundred entities on every search — so keep it to facets with few values, cap the result count, and lean on render caching. Because the output lands inside a facet widget (often a checkbox label), keep the view mode's markup simple or override its template.

---

- Show brand logos in a brand facet.
- Render category icons in a category filter.
- Show an author's photo in an author facet.
- Use a view mode to render facet items.
- Improve a product filter's usability with imagery.
- Show term descriptions alongside facet labels.
- Avoid writing a bespoke facet twig template.
- Reuse an existing Manage Display view mode in a facet.
- Make a facet visual rather than plain text.
- Show images in a faceted search sidebar.
- Improve a catalogue's browsing experience.
- Render referenced taxonomy terms as rich items.
- Configure the rendering view mode per facet.
- Support a design-led faceted search page.
- Show colour swatches as facet options.
- Render facet items as cards.
- Display media thumbnails in an entity-reference facet.
- Show a short teaser for each referenced entity in a facet.
- Enable the `translate_view_mode_entity` processor on a facet.
- Work with either Facets 2.x or 3.x.
- Reference-field facets that show more than the entity label.
- Present a "featured" view mode for filter options.
