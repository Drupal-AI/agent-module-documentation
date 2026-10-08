Chophper provides two field formatters that truncate formatted (rich-text) fields while keeping their HTML markup balanced, using the code-atlantic/chophper PHP library.

---

Chophper is a small display-only module for Drupal 10 and 11. It ships two field formatters that extend core's Text formatters but delegate truncation to the `code-atlantic/chophper` library, which parses the field's HTML with a DOM/HTML5 parser and cuts it without leaving unclosed tags. `chophper_trimmed` ("Trimmed (Chophper)") is a drop-in alternative to core's Trimmed formatter for `text`, `text_long` and `text_with_summary` fields; `chophper_summary_or_trimmed` ("Summary or trimmed (Chophper)") renders a field's manual summary when one exists and otherwise truncates the value, for `text_with_summary` fields. Both add three settings on top of the core trim length — the unit to truncate by (words, characters, sentences or blocks), the ellipsis string, and an optional preserve-words flag for character truncation. The module has no routes, permissions, services, config objects, Drush commands or hooks; it is configured entirely on each entity's Manage display page.

---

- Show a teaser/summary of a body field on a node listing without breaking mid-tag HTML.
- Replace core's Trimmed formatter with an HTML-aware equivalent that never emits unbalanced markup.
- Truncate a rich-text body to a word count (e.g. 40 words) for card layouts.
- Truncate to a fixed number of characters for tight, uniform-length previews.
- Truncate to a number of sentences (e.g. first 2 sentences) for lead paragraphs.
- Truncate to a number of top-level blocks (e.g. first 2 paragraphs) for excerpts.
- Add a custom ellipsis (e.g. " …read more" or "—") to truncated previews.
- Preserve whole words when truncating by characters so previews never cut a word in half.
- Render a hand-written summary on text_with_summary fields, falling back to auto-truncation when the author left the summary blank.
- Configure different truncation lengths per view mode (teaser vs. search index vs. full).
- Apply the formatter to a custom bundle's long-text field on its Manage display page.
- Set truncation per entity type — nodes, taxonomy terms, media, users, custom entities.
- Export the chosen formatter and settings as entity view display config for deployment.
- Provide consistent excerpt lengths across a site that mixes plain and formatted text fields.
- Use the block unit to keep intact list or heading structures in a preview.
- Trim CKEditor-authored content in a Views field display while keeping valid HTML.
- Generate short previews for RSS or teaser blocks without a separate summary field.
- Swap in Chophper on an existing display by changing only the formatter, keeping the field data untouched.
- Standardize excerpt behavior for a multi-author site where summaries are inconsistently filled in.
