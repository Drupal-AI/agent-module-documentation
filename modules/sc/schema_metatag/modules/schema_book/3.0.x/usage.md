Adds a Schema.org `Book` group to Metatag, outputting JSON-LD structured data for books and their editions.

---

A companion submodule of Schema.org Metatag. It registers a Metatag group `schema_book` and a Tag plugin per Book property, extending `SchemaNameBase`. Enable it and the Book tags appear under the site's Metatag configuration, where each value is set with tokens so data is populated from your content's fields. On render, Schema.org Metatag gathers the tags and emits them in the page's `application/ld+json` script. Useful for publishers, libraries and bookstores wanting Book rich results and knowledge-panel eligibility. Configure globally or per bundle. Requires `schema_metatag`.

---

- Add `Book` JSON-LD to book detail pages.
- Set the book `name` / title from a field.
- Attribute an `author` (Person or Organization).
- Provide a cover `image`.
- Write a `description` of the book.
- Link editions with `workExample` (Book/BookEdition).
- Declare `sameAs` links (Wikipedia, catalog).
- Add `aggregateRating` from reader ratings.
- Include individual `review` markup.
- Set the canonical `url` for the book.
- Choose the precise `@type` (Book).
- Provide a stable `@id`.
- Support library and bookstore catalogs.
- Improve visibility in book-related searches.
- Configure per content type, override per node.
- Validate the output in Google's Rich Results Test.
