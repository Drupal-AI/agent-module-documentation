Adds Schema.org `Movie`, `Series`, `Season` and `Episode` groups to Metatag, outputting JSON-LD for film and TV content.

---

A companion submodule of Schema.org Metatag. It provides Metatag groups for movie/TV types with a Tag plugin per property, extending `SchemaNameBase`; cast, crew and season/series relationships render as nested structured data. Enable it and the tags appear under the site's Metatag configuration, populated from content via tokens. On render, Schema.org Metatag emits them in the page's `application/ld+json` script. Suited to streaming catalogs, review sites and media databases. Requires `schema_metatag`.

---

- Add `Movie` JSON-LD to film pages.
- Mark up TV `Series`, `Season` and `Episode`.
- Set the title `name` and `description`.
- List `actor`(s) in the cast.
- Credit the `director` and `producer`.
- Credit `musicBy`.
- Provide the poster `image`.
- Set the `duration` (ISO 8601).
- Record `dateCreated` and `releasedEvent`.
- Number episodes via `episodeNumber` / `seasonNumber`.
- Link `partOfSeason` and `partOfSeries`.
- Relate parts with `hasPart`.
- Add `aggregateRating`.
- Declare `sameAs` (IMDb, Wikipedia).
- Add a `potentialAction` (e.g. watch action).
- Set the canonical `url` and stable `@id`.
- Power streaming catalogs and review sites.
- Validate output in Google's Rich Results Test.
