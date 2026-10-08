Adds a Schema.org `Course` group to Metatag, outputting JSON-LD for educational courses so they qualify for Course rich results.

---

A companion submodule of Schema.org Metatag. It provides a Metatag group `schema_course` with a Tag plugin per Course property, extending `SchemaNameBase`. After enabling, the Course tags show up in the site's Metatag configuration and are filled with tokens from your content. On render, Schema.org Metatag collects the tags and emits them in the page's `application/ld+json` script. Aimed at schools, universities and e-learning platforms that want their catalog pages eligible for Google's course listings. Requires `schema_metatag`.

---

- Add `Course` JSON-LD to course catalog pages.
- Set the course `name` from a field.
- Provide a `description` of the course.
- Declare the `provider` (Organization offering it).
- Add a `courseCode` identifier.
- List `coursePrerequisites`.
- State the `educationalCredentialAwarded`.
- Set a stable `@id` for the course.
- Choose the `@type` (Course).
- Support university and school catalogs.
- Support e-learning / MOOC platforms.
- Improve eligibility for course carousels in search.
- Configure globally, override per content type.
- Keep values in sync with course fields via tokens.
- Combine with Organization markup for the provider.
- Validate the output in Google's Rich Results Test.
