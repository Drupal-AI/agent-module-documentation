Custom Search enhances Drupal's core Search: it provides a configurable "Custom Search" block whose search box can include content-type and taxonomy selectors, and it lets you restyle and restrict the core search form and results pages (labels, placeholders, default text, ordering, advanced criteria).

---

The module's main piece is the **`custom_search` block** (class `CustomSearchBlock`): a search
form you place in any region, with rich block settings (`block.settings.custom_search`) for the
**search box** (label, placeholder, hint/title, size, max length), the **submit** button (text
or image), and **content/taxonomy/criteria selectors** — dropdowns or checkboxes that let a
visitor narrow a search to chosen content types, taxonomy terms (with depth), or add-phrase /
or / negative criteria before submitting. It also alters the **core search settings and results
pages**: on install it seeds per-search-page configuration (config object
`custom_search.settings.results`, keyed by each `node_search` page id) controlling whether the
search form and an advanced (collapsible) form show, which content types/criteria/languages the
advanced form offers, what result "info" is displayed, and a results filter. Via
`hook_form_alter()` it injects these options into the search page settings form and the search
block form, and it can route searches to a **Search API** page instead of core search. There is
no single admin settings route (`configure` is null); you configure the block through Block
layout and the search behaviour through each search page's settings form. Templates and a small
CSS/JS library provide an optional popup search box.

---

- Add a search block with a content-type dropdown so visitors can search only "Articles".
- Let visitors restrict a search to selected taxonomy terms via a term selector.
- Offer a taxonomy selector with a configurable depth (include child terms).
- Change the search box label, placeholder and hint text without theming.
- Replace the search submit button with an image/icon.
- Set the size and max length of the search input.
- Provide checkboxes (instead of a dropdown) to pick multiple content types to search.
- Add "any word / all words / exact phrase / without the words" criteria to a search form.
- Restrict the core search results to specific content types.
- Show or hide the advanced (collapsible) search form on the results page.
- Choose which content types the advanced search form exposes.
- Control which languages the advanced search offers.
- Customize the "displayed info" (author, date, type) shown per result.
- Add a results filter to re-scope results after searching.
- Route a custom search block to a Search API page instead of core search.
- Build a popup/overlay search box using the module's template and library.
- Exclude certain content types from a search block's results.
- Force an "- Any -" option or make choosing it restrict to selected types.
- Place multiple search blocks with different scopes (e.g. news vs docs).
- Customize the empty/default text shown in the search form.
- Give an intranet a scoped search box limited to internal content types.
- Order/position selectors and criteria within the search form by weight and region.
- Localize search form labels and "- Any -" texts per language.
- Provide a compact header search that expands into an advanced form.
