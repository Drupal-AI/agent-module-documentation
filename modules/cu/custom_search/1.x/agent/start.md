# Custom Search — agent index

Enhances core **Search**. Two surfaces: (1) a placeable **`custom_search` block** (search box
+ content-type / taxonomy / criteria selectors) and (2) alterations to the core **search
settings & results pages** (labels, advanced form, allowed types/criteria/languages, optional
Search API routing). No single admin route (`configure` is null): configure the block via
Block layout, and the results behaviour via each search page's settings form.

- **The Custom Search block: settings keys and how to place/configure it** →
  [configure/block.md](configure/block.md)
- **Customizing the core search results pages + Search API routing (per-page results config)** →
  [configure/results-and-forms.md](configure/results-and-forms.md)

Key facts:
- Block plugin id `custom_search` (`CustomSearchBlock`); block config schema
  `block.settings.custom_search` (search_box, submit, content, taxonomy, criteria, …).
- Per-search-page config seeded at install into `custom_search.settings.results` (keyed by
  each `node_search` page id): advanced form types/criteria/languages, displayed info, filter.
- Depends on `search` + `block`. Provides config schema; no permissions, no Drush.
