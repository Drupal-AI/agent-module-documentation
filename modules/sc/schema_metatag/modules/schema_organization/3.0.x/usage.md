Adds a Schema.org `Organization` group to Metatag, outputting JSON-LD for a company or LocalBusiness — its logo, contact points, address and more.

---

A companion submodule of Schema.org Metatag. It registers a Metatag group `schema_organization` with a Tag plugin per Organization property, extending `SchemaNameBase`; address, geo, contact points and opening hours render as nested structured data. Commonly configured once globally so every page carries the site's organization identity (and logo), which powers Google knowledge panels and LocalBusiness features. Enable it and the tags appear under the site's Metatag configuration, populated via tokens. On render, Schema.org Metatag emits them in the page's `application/ld+json` script. Requires `schema_metatag`.

---

- Add site-wide `Organization` JSON-LD.
- Mark up a `LocalBusiness` via the `@type` tree.
- Set the organization `name` and `description`.
- Declare the `logo` for knowledge panels.
- Provide an `image`.
- Set the postal `address`.
- Add `geo` coordinates.
- Provide a `telephone` and `contactPoint`.
- Publish `openingHoursSpecification`.
- State a `priceRange`.
- Flag `acceptsReservations`.
- Link a `menu` (restaurants).
- Add `sameAs` social/profile links.
- Include `aggregateRating` and `starRating`.
- Show `brand` and `memberOf` relationships.
- Set the canonical `url` and stable `@id`.
- Power knowledge panels and local search.
- Validate output in Google's Rich Results Test.
