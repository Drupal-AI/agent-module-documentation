<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Styled Google Map Demo is a hidden example submodule that defines a `real_estate` content entity type (with a Geofield "location") and a `real_estate` taxonomy vocabulary, so the parent Styled Google Map module's map features can be demonstrated on real content.

---

This submodule ships purely to showcase the parent `styled_google_map` module. It declares a full `real_estate` content entity type (base table `real_estate`, id `real_estate`) with fields `name`, `price`, `location` (a `geofield`), `category` (an entity reference to the `real_estate` vocabulary), plus `user_id`, `status`, `created` and `changed`. It creates the `real_estate` taxonomy vocabulary (with an image `field_icon` used as the map pin per property type) and provides entity CRUD routes (`/real_estate/add`, `/real_estate/{id}`, `/admin/content/real_estate`, settings at `/admin/structure/real_estate/settings`), a list builder, custom forms, an access control handler and its own permission set (`administer/add/edit/delete/view published/view unpublished real estate entities`). It is marked `hidden: true`, so it does not appear on the normal Extend list, and it holds no configuration of its own (no `configure` route). The companion `styled_google_map_data` submodule depends on this one and fills it with sample Sacramento property data and example map views. Enable it only to explore or learn the parent module — it is not intended for production sites.

---

- Provide a ready-made `real_estate` content entity to demo the Styled Google Map field formatter.
- Show a Geofield (`location`) rendered as a styled map on a demo entity's canonical page.
- Demonstrate per-category pins by attaching an icon image (`field_icon`) to `real_estate` taxonomy terms.
- Give developers a working reference implementation of a geofield-bearing content entity type.
- Explore the parent module's popup, clustering and directions options against sample content.
- Study a complete custom content entity (handlers, routes, forms, access handler, list builder) as example code.
- Seed a `real_estate` taxonomy vocabulary for property types (Condo, Multi-Family, Residential).
- Provide the entity type that `styled_google_map_data` imports demo CSV rows into.
- Learn how `field_ui_base_route` and an `AdminHtmlRouteProvider` wire up entity admin pages.
- Offer a sandbox entity for testing map Views without touching real site content.
- Exercise the `styled_google_map` Views style against a multi-field content entity.
- Demonstrate an image-field-driven pin per taxonomy term on a map.
- Serve as a copy-paste starting point for building your own location content type.
- Show how a geofield base field is declared on a content entity.
- Validate a Styled Google Map setup end-to-end before applying it to production content types.
- Provide fixtures for automated tests of the parent module.
- Illustrate the permission structure a custom entity type needs.
- Demonstrate rendering entity reference (category) data alongside a map marker.
- Give trainers a concrete example when teaching the Styled Google Map module.
- Prototype a store-locator / property-finder UI quickly.
