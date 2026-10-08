<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Exclude Paragraphs adds a Search API processor that strips selected Paragraph types out of content before it is indexed, so their text never becomes searchable.

---

The module contributes a single `search_api` processor plugin, `SearchApiExcludeParagraphs`. In the processor settings you choose which Paragraph bundles to exclude; during indexing the processor removes those paragraphs from the item's rendered/extracted content so their body text is not written to the search index. Typical targets are paragraphs that hold Views output, promotional link blocks, or repetitive layout features that would otherwise pollute search results.

It has no routes, permissions, services or config entities of its own — configuration lives entirely inside the Search API index's processor settings, which are already gated by `administer search_api`. Set-up: add a server and index, enable the "Exclude Paragraphs" processor on the index, and select the Paragraph types to exclude.

---

- Exclude a Paragraph type from a Search API index.
- Keep Views-embedding paragraphs out of search results.
- Stop promotional/CTA link paragraphs from polluting the index.
- Exclude repetitive layout paragraphs from indexed content.
- Enable the "Exclude Paragraphs" processor on a specific index.
- Select which Paragraph bundles to exclude in the processor settings.
- Improve search relevance by trimming noise paragraphs.
- Reduce index size by dropping unnecessary paragraph text.
- Apply exclusions per index (different indexes can exclude different types).
- Prevent duplicated content (embedded views) from being indexed twice.
- Keep decorative or navigational paragraphs unsearchable.
- Re-index after changing the excluded types to apply changes.
- Combine with other Search API processors in the processing pipeline.
- Exclude paragraphs holding third-party embeds from search.
- Curate what rendered-content text reaches the search backend.