Adds Schema.org/Service JSON-LD structured data via Metatag, describing an offered service with provider, offers, and ratings.

---

Schema.org Service is a Schema.org Metatag submodule that registers Metatag tag plugins for the `Service` type. Enabling it adds a `Schema.org Service` group to Metatag configuration where token-driven values render into the page's JSON-LD block. It covers `name`, `description`, `image`, a `brand`/provider association, `offers` (price and terms), `aggregateRating`, and `review`, plus `@type` and `@id` for specialization and cross-referencing. Because values map from tokens, one configuration covers every "service" content node. It is used by agencies, professional services, and service-catalog sites to describe intangible offerings in a machine-readable way and to associate pricing and rating data with them.

---

- Mark up a service-offering node as a `Service`.
- Set the service `name`, `description`, and `image`.
- Associate a `brand`/provider with the service.
- Emit an `offers` block with price and terms.
- Add `aggregateRating` for the service.
- Include individual `review` markup.
- Set the `@type` to specialize the service.
- Give the service a stable `@id`.
- Describe professional/agency service pages.
- Build a machine-readable service catalog.
- Associate services with an Organization provider.
- Standardize service markup across nodes via tokens.
- Surface service ratings in search results.
- Map service pricing dynamically from fields.
- Provide structured data for local service businesses.
- Improve discoverability of service landing pages.
- Cross-reference a service from an Organization entity.
- Keep service structured data synced with editable content.
