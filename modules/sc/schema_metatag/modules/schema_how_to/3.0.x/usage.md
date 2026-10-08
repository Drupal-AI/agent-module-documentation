Adds a Schema.org `HowTo` group to Metatag, outputting JSON-LD for step-by-step instructions so they qualify for HowTo rich results.

---

A companion submodule of Schema.org Metatag. It provides a Metatag group `schema_how_to` with a Tag plugin per HowTo property, extending `SchemaNameBase`; steps, supplies and tools render as nested structured data. Enable it and the HowTo tags appear under the site's Metatag configuration, populated from content via tokens. On render, Schema.org Metatag gathers the tags and emits them in the page's `application/ld+json` script. Great for tutorials, guides and DIY content. Requires `schema_metatag`.

---

- Add `HowTo` JSON-LD to tutorial and guide pages.
- Set the HowTo `name` and `description`.
- Provide the sequence of `step`s.
- List required `supply` items.
- List required `tool`s.
- State an `estimatedCost`.
- Add an illustrative `image`.
- Set the canonical `url`.
- Provide a stable `@id`.
- Choose the `@type` (HowTo).
- Power DIY and craft instructions.
- Support cooking and repair guides.
- Improve eligibility for how-to rich results.
- Configure globally, override per content type.
- Keep steps in sync with content fields via tokens.
- Validate output in Google's Rich Results Test.
