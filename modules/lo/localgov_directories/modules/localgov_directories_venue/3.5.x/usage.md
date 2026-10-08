<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories Venue provides a venue **entry** type for directory channels: a place, with a geocoded location, opening times and contact details, ready to appear on a channel's map and in proximity search.

---

Venues are the location-aware counterpart to the plain page entry. The submodule installs the `localgov_directories_venue` node type with the shared directory fields (name, phone, email, website, job title, files, notes, body, channels, facet selection, title sort) plus two that make it a venue: `localgov_directory_opening_times` and `localgov_location`, the LocalGov Geo location field. Because it depends on `localgov_directories_location`, enabling it also brings in the proximity-search machinery — the geo field is indexed as a location datatype, the channel view gains its map and "near me" displays, and entries can be filtered by distance. Five view displays ship (default, teaser, `directory_index`, `search_index`, `search_result`) so venues render correctly everywhere the parent module expects. `hook_install()` registers the bundle with Simple XML Sitemap when present, `hook_localgov_roles_default()` grants the LocalGov editor and author roles the usual node permissions, and `hook_update_8001()` handles the LocalGov Geo upgrade path where the embed view mode replaced the default one for location display.

---

- List community centres, libraries or leisure facilities with their locations.
- Show venues on a Leaflet map on the directory channel page.
- Let visitors find the nearest venue with proximity search.
- Publish opening times alongside contact details.
- Record a geocoded address once and reuse it across displays.
- Filter venues by facets such as accessibility or facilities.
- Combine venue entries with other entry types in one channel.
- Give each venue a clean URL and sitemap entry.
- Attach documents such as floor plans or price lists.
- Provide directions data for a council's public buildings.
- Keep alphabetical venue listings correct with the title-sort field.
- Publish venue data that other systems can consume via Open Referral.
- Show a venue's location in search results as well as on the map.
- Support multi-channel venues (e.g. both "Sports" and "Community").
- Let editors manage venues without bespoke permission setup.
- Migrate an existing venues spreadsheet into structured content.
- Display notes or access information distinct from the main body.
- Use venues as the anchor for organisation records via Open Referral.
- Keep venue geodata in LocalGov Geo rather than a bespoke field.
- Upgrade cleanly from older LocalGov Geo display configuration.
