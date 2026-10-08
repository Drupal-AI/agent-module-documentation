Layout Builder Search API provides a Search API processor that exposes fields from the block content used inside an entity's Layout Builder layout, so you can index those block fields instead of (or alongside) the rendered page.

---

When content is built with Layout Builder, the searchable text often lives in **inline blocks** and referenced **block content** placed in the layout, not in the host entity's own fields. This module adds a Search API processor plugin, `layout_builder_references` ("Layout builder references"), that walks a Search API item's Layout Builder sections, finds every `inline_block` and `block_content` component, and makes their fields available as Search API properties. In the processor's settings you pick which **block content types** to expose; for each selected type the processor generates entity-reference properties (named `search_api_layoutbuilder_references_<bundle>`) whose nested fields you can then add on the index's *Fields* tab. At index time (`addFieldValues()`) it loads the correct block content revision for each component in the entity's layout and extracts the requested field values, so the indexed document contains the block field data. This lets you build precise, field-level search over Layout Builder content rather than indexing a blob of rendered HTML. The processor is language-aware (references cache is varied per language) and only supports indexes whose datasources are entities. There is no admin settings page of its own (`configure: null`) and no permissions — all configuration happens on the Search API index. Requires Search API and Layout Builder (and core Language).

---

- Index the body/text fields of inline blocks placed in a node's Layout Builder layout.
- Make referenced reusable block content searchable as part of the host page.
- Avoid indexing rendered page HTML and index selected block fields instead.
- Add a "Hero" block's headline field to the search index for landing pages.
- Search across CTA/promo blocks embedded via Layout Builder.
- Expose only chosen block content types for indexing (fine-grained control).
- Build faceted search over structured block fields rather than full-text page dumps.
- Improve relevance by indexing meaningful block fields, not layout markup.
- Index custom fields on inline blocks (e.g. a "summary" field) for a node index.
- Keep search results accurate when content authors move data into Layout Builder blocks.
- Surface FAQ blocks' question/answer fields in site search.
- Index testimonial or team-member blocks placed through Layout Builder.
- Add block-content taxonomy reference fields to an index for filtering.
- Support multilingual indexing of Layout Builder block fields (per-language references).
- Combine host-entity fields and layout block fields in one Search API index.
- Index the current revision of block content actually used in a page's layout.
- Power an autocomplete that includes text from embedded blocks.
- Give editors' Layout Builder content first-class searchability without custom code.
- Index inline blocks by revision so search matches what is really on the page.
- Selectively index only marketing block types on a campaign index.
- Provide field-level Search API properties per selected block bundle.
- Feed a Solr/Elasticsearch index with structured Layout Builder block data.
- Migrate from rendered-HTML indexing to structured block-field indexing.
