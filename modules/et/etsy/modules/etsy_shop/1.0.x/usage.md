<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Etsy Shop is the reference implementation that turns Etsy shop data into Drupal content: an "Etsy listing" node type populated from the Etsy API on cron, with matching taxonomies, image styles, a view and templates.

---

Etsy Shop is a submodule of the Etsy API project and the intended starting point for displaying an Etsy shop on a Drupal site. Installing it creates an `etsy_listing` content type carrying about forty Etsy-specific fields (price, images, dimensions, materials, personalization flags, timestamps, ids, tags, URL, favorers, views, and more), an `etsy_section` taxonomy (shop sections) and an `etsy_materials` taxonomy, three Etsy image styles, an "Etsy Shop" view, a custom "Etsy store listing" view mode, and node/price templates. On every cron run its hooks call the base module's `etsy.api` service to synchronise the shop: sections become taxonomy terms, and listings become `etsy_listing` nodes — new listings are created, changed listings updated, and listings no longer returned by the API are deleted, so the Drupal content mirrors the live shop. Listing images are Etsy-hosted and rendered through Imagecache External. Because content is import-managed, the listing nodes are not meant to be edited by hand. It depends on `etsy`, `views`, `node` and `taxonomy`; Pathauto and Metatag are optional.

---

- Display an Etsy shop's listings as Drupal nodes.
- Create the `etsy_listing` content type with ~40 Etsy fields on install.
- Import Etsy shop listings into Drupal on cron.
- Import Etsy shop sections into the `etsy_section` taxonomy.
- Auto-create `etsy_materials` and tag terms from listing data.
- Keep listing nodes in sync (create/update/delete) with the live shop.
- Publish active listings and unpublish non-active ones automatically.
- Render Etsy-hosted listing images via Imagecache External.
- Provide Etsy image styles (75x75, 170x135, 570w).
- Provide an "Etsy Shop" view to list products.
- Provide a custom "Etsy store listing" view mode and node templates.
- Show listing price with the Etsy price field type/formatter.
- Store listing descriptions safely as plain-text body.
- Map Etsy "when made" values to friendly labels.
- Offer optional Pathauto URL aliases for listing nodes.
- Offer optional Metatag defaults for listing nodes.
- Serve as a base to build a custom Etsy storefront display.
- Mirror shop sections and materials as browsable taxonomy.
- Present a single configured Etsy shop on the front end.
- Avoid manual listing edits (imports overwrite local changes).
