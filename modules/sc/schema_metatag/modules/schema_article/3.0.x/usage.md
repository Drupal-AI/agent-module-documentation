Adds a Schema.org `Article` group to Metatag, emitting JSON-LD for articles, blog posts and news — supporting subtypes BlogPosting, SocialMediaPosting, Report, ScholarlyArticle, TechArticle and APIReference.

---

A companion submodule of Schema.org Metatag, this provides a Metatag group `schema_article` plus one Tag plugin per Article property, all extending the base `SchemaNameBase`. Once enabled, the tags appear in the site's Metatag configuration where each value is set with tokens (e.g. `[node:title]`, `[node:author]`), so structured data is populated automatically from entity fields. The `@type` tag lets editors pick the precise Article subtype. On render, Schema.org Metatag collects these tags and outputs them inside the page's `application/ld+json` script. Configure globally and override per content type or per node. Values map to Google's Article rich-result requirements. Requires `schema_metatag`.

---

- Add `Article` JSON-LD to news and article nodes.
- Mark up blog entries as `BlogPosting`.
- Tag social posts as `SocialMediaPosting`.
- Describe research content as `ScholarlyArticle` or `Report`.
- Use `TechArticle` / `APIReference` for documentation pages.
- Set the article `headline` from `[node:title]`.
- Populate `description` from a summary field.
- Provide the `image` for Article rich results.
- Attribute an `author` (Person) to each article.
- Declare the `publisher` (Organization) with logo.
- Emit `datePublished` and `dateModified` timestamps.
- Point `mainEntityOfPage` at the canonical URL.
- Add `aggregateRating` and `review` for rated articles.
- Mark passages as `speakable` for voice assistants.
- Flag content with `isAccessibleForFree`.
- Link related topics via `about`.
- Reference sub-parts with `hasPart`.
- Set a stable `@id` for the article node.
- Configure per content type, override per node.
- Validate output in Google's Rich Results Test.
