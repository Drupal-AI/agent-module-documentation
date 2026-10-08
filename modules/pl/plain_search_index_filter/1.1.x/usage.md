<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plain Search Index Filter adds a Twig filter that strips out all HTML in a neat way, removing script/style contents and adding breaks between tags.

---

Plain Search Index Filter adds a Twig filter that strips HTML cleanly — removing all HTML tags while
adding line breaks between block tags and stripping the contents of `<script>`/`<style>` tags, producing
clean plain text suitable for a search index. It is configured at `plain_search_index_filter.settings`.

Use it in search-index templates to feed clean text to the index (avoiding markup, scripts and styles
polluting indexed content or search snippets). It is a site-search/indexing helper; it processes text for
indexing and has no access-control role. Its removal of `<script>`/`<style>` content is a small quality/
hygiene benefit for the index. Apply the filter where indexable text is prepared.

---

- Strip HTML for search indexing.
- Remove script/style contents.
- Add breaks between tags.
- Produce clean plain text.
- Configure at the settings.
- Feed clean text to the index.
- Avoid markup in indexed content.
- Have no access-control role.
- Apply in index templates.
- Clean up indexable text.
- Strip tags neatly.
- Remove scripts/styles.
- Handle index text.
- Configure the filter.
- Prepare indexable text.
- Clean search content.
- Strip HTML cleanly.
- Process index text.
- Filter for indexing.
- Clean the index.
