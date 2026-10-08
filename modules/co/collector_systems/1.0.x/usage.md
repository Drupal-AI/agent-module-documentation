<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Publishes a Collector Systems art/collection database on a Drupal site by mirroring it into local tables and rendering browsable public pages, blocks and search.

---

Collector Systems integrates Drupal with the Collector Systems collections-management platform (an OData "public API" used by museums, galleries and private collectors). Rather than creating Drupal nodes, the module imports Objects, Artists, Collections, Groups and Exhibitions — and their images — into its own set of custom database tables, then serves that local copy as public browse/detail pages, list blocks, an A-Z artist index, an advanced per-field search and optional Azure Maps location pins. An administrator enters the API subscription key, account GUID and subscription ID once, chooses which fields appear on list and detail pages, and runs an initial import; after that the data can be refreshed manually from a sync dashboard or automatically on a schedule via cron and a queue. It is a Drupal port of the vendor's WordPress plugin and supports Drupal 9, 10 and 11.

---

- Connect a Drupal site to a Collector Systems account with a subscription key, account GUID and subscription ID.
- Import a museum/gallery collection (Objects, Artists, Collections, Groups, Exhibitions) into Drupal-managed tables.
- Publish an art collection publicly without hand-building content types or nodes.
- Give each entity type a browsable list page/block and a detail page.
- Offer an A-Z alphabetical artist index for large artist lists.
- Let visitors search the collection with a simple keyword box or an advanced per-field panel.
- Filter and sort object lists (by title, inventory number, object date, collection name).
- Choose exactly which Collector Systems fields show on object-list, object-detail and artist-detail pages.
- Store attachment images either in a public files directory or as BLOBs in the database.
- Show object locations on an Azure Maps map with clickable pins.
- Refresh the local data on demand from the sync dashboard (reset-and-recreate or incremental update).
- Schedule automatic re-sync (nightly, weekly, monthly, quarterly, annually) driven by cron and a queue worker.
- Drain the sync queue in parallel during the cron window for faster imports.
- Track when the last data/image sync started, finished, who ran it and how long it took.
- Customize front-end presentation (font sizes, image background colour, image alignment, transitions, hyperlink underlines, image zoom).
- Restrict displayed images by attachment keyword.
- Set the number of items shown per page across the collection browse pages.
- Target cultural-heritage sites that already run their catalogue in Collector Systems.
- Keep the public site in step with the authoritative collections database over time.
- Reuse the vendor's Collector Systems data model in Drupal without a bespoke integration.
