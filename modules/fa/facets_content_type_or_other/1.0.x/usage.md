<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Indexes node content types into a Facets facet where chosen types keep their own value and all other types collapse into a single "Other" bucket.

---

Facets Content type or Other adds a Search API processor that computes a per-node "content type or other" string at index time: content types you mark as "first-order" keep their (optionally overridden) label, while every other bundle is indexed as "Other". Exposed through the Facets module, this produces a compact content-type facet — for example *Article*, *Basic page*, *Other* — instead of one option per bundle. A companion Facets sort processor keeps the first-order types in your configured order and always places "Other" last, and an admin settings form (`/admin/config/search/facets-content-type-or-other`, permission `administer facets`) provides a draggable table to select first-order types, override labels, and set weights (stored in `facets_content_type_or_other.settings`). A `SetIndexedValue` event lets other modules compute a custom label from the node entity before it is indexed. It depends on Search API and Facets, sits in the Search package, and re-indexing is required after any configuration change. It only shapes facet display; listed results still respect their own access.

---

- Show a content-type facet as specific types plus a single "Other" catch-all bucket.
- Keep content-type facets tidy on sites with many bundles.
- Mark certain content types as "first-order" so they appear as their own facet value.
- Fold every non-first-order content type into "Other" automatically.
- Override the label of each first-order content type shown in the facet.
- Index the human-readable bundle label rather than the machine name.
- Control the order of first-order types in the facet via a draggable weight table.
- Always sort the "Other" bucket to the end of the facet with the dedicated sort processor.
- Add a computed "Content type or other" field to a Search API index.
- Build a Facets facet on top of that indexed value.
- Configure first-order types and labels at `/admin/config/search/facets-content-type-or-other`.
- Restrict configuration access to users with `administer facets`.
- Show all content types by their own label when no first-order types are configured.
- Compute a custom facet label from the node entity by subscribing to the `SetIndexedValue` event.
- Relabel a bundle in the facet (for example index the `page` bundle as "Page") without changing the node type.
- Re-index content after changing the settings so new grouped values take effect.
- Combine a Search API index, a facet, and a sort processor into one content-type navigation widget.
- Provide a faceted-search UI that groups long-tail content types under "Other".
- Deselect all other Facets sorting options so the module's sort order takes effect.
- Use the facet on any Search API-backed search or view display.
