<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API common fields lets you add one Search API index field whose value is drawn from identically-named properties that live on **different datasources**, so items from any of those datasources populate the same field.

---

The module registers a single Search API processor plugin, `common_field` (`@SearchApiProcessor`, labelled "Common fields", `locked` and `hidden`), that works like Search API's built-in Aggregated Fields but across datasources. On an index with two or more datasources it exposes an index-level property `common_field` (datasource-independent, type `string`); each field you create from it is a `CommonFieldProperty` (a `ConfigurablePropertyBase`) whose one setting, `property_name`, chooses which shared property path to pull from. Its configuration form only offers property paths that exist on **more than one** datasource, listing the datasources each is used in. At index time `CommonField::addFieldValues()` runs in the `add_properties` stage (weight 20): for each configured common field it extracts the chosen source property from whichever datasource the current item belongs to and writes it into the common field. The result is a single field usable for indexing, filtering, sorting, faceting and display regardless of which datasource an item came from — simplifying facets and Views built over multi-datasource indexes. There is no settings page, permission, Drush command, or config schema of its own; all state lives in the Search API index config entity (`search_api.index.<id>`).

---

- Index a "created"/date property that exists on both node and comment datasources into one sortable field.
- Merge an identically-named "title" or "name" property across two entity datasources into a single fulltext field.
- Build one facet that works across multiple datasources instead of one facet per datasource.
- Sort a mixed-datasource result set by a shared "changed" timestamp using a single field.
- Filter an index of nodes and media by a common "status" property through one field.
- Combine a shared "author"/"uid" property from different datasources for a unified author facet.
- Display a single field in a Views search that renders correctly for items from any datasource.
- Replace several per-datasource fields with one common field to simplify an index's field list.
- Provide a common "category" field when two content datasources both expose a same-named taxonomy property.
- Aggregate a shared "price" or numeric property across commerce datasources into one field.
- Give a search index a single "url"/"path" field sourced from whichever datasource an item is on.
- Support cross-datasource relevance by indexing a shared fulltext property once.
- Normalise a "summary"/"description" property from multiple datasources into one display field.
- Feed a common field into an autocomplete or spellcheck feature over a multi-datasource index.
- Create a unified "language" or "langcode" field across datasources for language facets.
- Reduce Views configuration by exposing one common field filter instead of several.
- Index a shared "type"/"bundle" label property across datasources for a single type facet.
- Simplify a decoupled/JSON:API search response by returning one common field rather than many.
- Merge a shared geolocation property across datasources into a single field for map results.
- Keep facets consistent when new datasources are added, as long as they share the property name.
- Export the whole setup as index config (`search_api.index.*`) for deployment across environments.
- Consolidate duplicate fields left over from indexing several similar entity types.
