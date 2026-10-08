<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories builds searchable, facet-filtered directories for LocalGov Drupal sites: a *channel* node type defines which entry types and facets it accepts, entries are ordinary nodes indexed in Search API, and visitors filter them with facet blocks or a proximity search.

---

Three pieces work together. A **channel** is a `localgov_directory` node with fields for which entry bundles it accepts (`localgov_directory_channel_types`) and which facet types are enabled on it (`localgov_directory_facets_enable`); a shipped view, `localgov_directory_channel`, renders the channel page from the Search API index with embedded displays for the plain list, the proximity-search variant and a Leaflet map. **Entries** are nodes of any bundle carrying the `localgov_directory_channels` reference field — the submodules provide ready-made bundles (page, promo page, venue, organisation) but any content type can be turned into one. **Facets** are the module's own content entity, `localgov_directories_facets`, bundled by the `localgov_directories_facets_type` config entity: site editors create a type ("Size") and values ("Large", "Medium") in the admin UI at `/admin/content/directories/facets` without touching site building, which is why the facet values are deliberately excluded from config export. Entries pick facet values through `localgov_directory_facets_select`, and a computed `localgov_directory_facets_filter` field is what the Search API index actually stores. The module then wires Facets module integration for you: dedicated facets processors (`LocalGovDirectoriesProcessor`, `WeightOrderProcessor`), a query type, checkbox widgets and templates, a Better Exposed Filters plugin, `hook_facets_facet_insert()` / `hook_search_api_index_update()` glue so new facet types appear automatically, and a `ChannelSearchBlock` for keyword search within a channel. Everything is keyed off constants in `src/Constants.php` (default index `localgov_directories_index_default`, channel view `localgov_directory_channel`, bundle `localgov_directory`). Six permissions cover facet CRUD plus `administer directory facets types`, and `hook_localgov_roles_default()` grants sensible defaults to the LocalGov editor/author roles.

---

- Publish a council's A–Z of services as a filterable directory.
- Build a directory of local venues with an interactive map.
- List community organisations with contact details and categories.
- Let editors add new filter categories without a developer.
- Filter directory entries by multiple facets at once.
- Offer a "find services near me" proximity search.
- Search within a single directory channel via a dedicated search block.
- Run several independent directories on one site, each with its own facets.
- Restrict which entry types can be posted into a given channel.
- Reuse an existing content type as a directory entry type.
- Show directory entries on a Leaflet map with clustering.
- Sort directory listings by a normalised title-sort field.
- Provide autocomplete on the channel search box.
- Use taxonomy terms as facets instead of the module's facet entity.
- Swap the search backend from the bundled database index to Solr.
- Publish venue data in Open Referral format for aggregation.
- Give each channel a pathauto URL pattern.
- Group facet items visually by facet type in the sidebar.
- Hide empty facets automatically with the shipped processor.
- Control facet display order with the weight-order processor.
- Grant editors facet management rights without full admin access.
- Expose directory entries as an embedded view elsewhere on the site.
- Add structured address, phone, email and website data to entries.
- Keep directory content editable in production while site config stays exported.
