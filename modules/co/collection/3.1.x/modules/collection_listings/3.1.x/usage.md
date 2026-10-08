<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Experimental Collection submodule that renders a filtered, ordered listing of a collection's items as a Paragraphs behavior.

---

Collection Listings lets a site place a listing of the items in a given Collection onto another content entity using Paragraphs. You add a `collection` entity-reference field to a paragraph type and enable the "Collection listing" behavior on that type; the behavior is only applicable to paragraph types that have exactly one such collection-reference field. When editing a paragraph of that type, a "Behaviors" tab lets the editor pick which collected entity types and bundles to include, the view mode to render each in, and how many items to show. At render time the behavior queries the referenced collection's items (access-checked, published-only for entity types that have a published flag), orders them by weight, and renders each collected entity with its chosen view mode inside an item list. Requires the Paragraphs module and belongs to the experimental "Collection (Experimental)" package.

---

- Render a curated list of a collection's items on any content entity via Paragraphs.
- Filter the listing by collected entity type and bundle.
- Choose a view mode per entity type for how each collected item is displayed.
- Limit the number of items shown (or show all).
- Order items by their collection weight.
- Only publish items whose collected entity is published (for entity types with a status flag).
- Attach to a paragraph type that has a single collection entity-reference field.
- Reuse the same collection in multiple listings with different filters/view modes.
