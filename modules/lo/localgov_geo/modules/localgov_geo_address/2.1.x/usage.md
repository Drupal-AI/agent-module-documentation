<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Geo Address provides the address bundle for LocalGov Geo: a location record holding a map point together with a structured postal address, which is what directory venues, organisations and events reference.

---

The bundle pairs Geo Entity's address support (`geo_entity:geo_entity_address`) with LocalGov defaults, so a single location record carries both the geometry used for maps and proximity search and the human-readable address shown on the page. This is the bundle the rest of the LocalGov stack expects: `localgov_directories_location` installs `field.storage.node.localgov_location` as a reference to it, and venue and organisation entries in Directories point at it, as do events with a location. Because the record is a separate entity, the same address can be referenced from several pieces of content without duplication — change the address once and every reference updates. Editors normally create these inline through Inline Entity Form on the referencing content's edit form rather than visiting the location admin directly, and the address can be geocoded from what they type, using whichever geocoder provider the site has configured (OpenStreetMap by default, Ordnance Survey Places for UK authorities).

---

- Store a venue's postal address and map point in one record.
- Reference the same address from several directory entries.
- Feed coordinates into proximity search and map displays.
- Let editors enter an address inline while creating content.
- Geocode a typed address to coordinates automatically.
- Keep addresses consistent across a council site.
- Update an address once and have every reference follow.
- Display a formatted postal address on an entry page.
- Support UK address lookup via Ordnance Survey Places.
- Show a location marker on an OpenStreetMap tile layer.
- Provide structured address data for Open Referral export.
- Model a building used by several services.
- Avoid duplicating address fields on every content type.
- Support address-based filtering in Search API.
- Give locations their own canonical pages.
- Migrate legacy address fields into shared location records.
- Enable "find your nearest" journeys.
- Attach an address to an event venue.
- Keep geodata editable by content editors.
- Reuse addresses between directories and events.
