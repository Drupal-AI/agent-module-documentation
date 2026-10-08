Adds Schema.org/Place JSON-LD structured data via Metatag, describing a physical location (venue, office, landmark) with address and geo coordinates for local/maps rich results.

---

Schema.org Place is a Schema.org Metatag submodule that registers Metatag tag plugins for the `Place` type. After enabling it, a `Schema.org Place` group is available in Metatag configuration where each property accepts text or tokens and is rendered into the page's JSON-LD. It provides the core Place properties: `name`, `description`, `image`, `url`, `telephone`, a nested postal `address`, and a `geo` block for latitude/longitude coordinates. The `@type` tag lets you specialize the place, and values are token-driven so a bundle of "location" nodes can all share one mapping. Place data is frequently nested inside other types (Event location, LocalBusiness, Organization) but this module lets you output a standalone Place entity. It is useful for venues, points of interest, and location landing pages that should surface in map and local search results.

---

- Describe a venue or landmark node as a `Place`.
- Set the place `name` from the node title token.
- Provide a nested postal `address` (street, locality, region, postal code, country).
- Add `geo` latitude/longitude coordinates for map placement.
- Attach a representative `image` of the location.
- Expose a `telephone` number for the place.
- Link the place's `url` (its canonical page).
- Add a `description` summarizing the location.
- Specialize the `@type` for the specific kind of place.
- Reuse the Place mapping across every "location" content node via tokens.
- Nest Place data as an Event's location.
- Provide structured location data for a directory of points of interest.
- Improve eligibility for local/maps rich results.
- Give search engines precise coordinates instead of a text address alone.
- Mark up a campus, park, or building landing page.
- Support a "find us" page with machine-readable address and geo.
- Standardize location markup across a multi-site venue listing.
- Combine with Organization/Event modules for richer local data.
