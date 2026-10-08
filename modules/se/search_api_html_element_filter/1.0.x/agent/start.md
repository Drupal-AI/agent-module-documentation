# Search API HTML Element Filter — agent index

Adds one Search API processor, **`html_element_filter`**, that removes elements matching CSS
selectors from field markup before indexing (and optionally from result snippets). No admin
page, no config of its own, no permissions, no Drush — everything lives in the host index's
`processor_settings`.

- **Add/configure the processor on an index, its settings and where they are stored** →
  [configure/processor.md](configure/processor.md)

Key facts:
- Plugin id: `html_element_filter` (class `HtmlElementFilter` extends `FieldsProcessorPluginBase`).
- Settings: `css_selectors` (textarea, one selector per line) and `enable_postprocess_query`
  (bool, default TRUE).
- Stored at `search_api.index.<id>` → `processor_settings.html_element_filter.*`.
- Stages: `preprocess_index` (strip before indexing) and `postprocess_query` (strip result
  fields when `enable_postprocess_query` is on); uses Symfony DomCrawler + CssSelector.
