<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collection Listings (collection_listings) — agent index

Experimental submodule of **[collection](../../../../agent/start.md)**. Provides **one Paragraphs
behavior plugin** that renders a filtered, weight-ordered listing of a collection's items.
Version **3.1.0**. Core `^9.4 || ^10 || ^11`. Package `Collection (Experimental)`.
Depends on `collection` and `paragraphs`.

## The single moving part

`src/Plugin/paragraphs/Behavior/ParagraphsCollectionListing.php` —
`@ParagraphsBehavior(id = "collection_listing")`, extends `ParagraphsBehaviorBase`.

- **`isApplicable()`** — offered only to paragraph types that have **exactly one** `entity_reference`
  field (a `FieldConfig`) whose target type is `collection`
  (`getCollectionReferenceFieldNames()`).
- **`buildBehaviorForm()`** — behavior settings: item `count` (blank = all), and per content-entity-
  type a details group with `bundles` (checkboxes) + `view_mode` (select).
- **`preprocess(&$variables)`** — the render path. For each collection-reference field on the
  paragraph it queries `collection_item` with **`accessCheck(TRUE)`**, `condition('collection', <id>)`,
  and (when entity settings exist) an OR group filtering by the collected entity's published flag and
  bundle; applies the `count` range, sorts by `weight`, loads the items and renders each collected
  entity via its view builder in the chosen (or `teaser`) view mode. Emits
  `#theme => item_list__collection_listing` with computed cache tags (collection tags + per-bundle
  `{type}_list:{bundle}` list tags).
- `settingsSummary()`, `view()` (no-op), plus helpers `getContentEntityTypeNames`,
  `getBundlesForEntity`, `getViewModesForEntity`.

## Notes / caveats

- No routes, permissions, services, config schema, or install hooks — behavior plugin only.
- The README references two core/contrib patches for full functionality.
- Rendering scope: the query access-checks the **collection_item** (the viewer's access to the
  collection) and filters collected entities to *published* ones, then renders each with its view
  builder in the configured view mode. Like a curated/Views listing, the set of items is chosen by
  the editor configuring the paragraph, and only published content is shown.
