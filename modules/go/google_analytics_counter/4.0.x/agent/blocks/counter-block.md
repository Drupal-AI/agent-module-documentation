# Block, `[gac]` token & theme

Three display surfaces render the pageview count for the **current request context** by calling
`GoogleAnalyticsCounterAppManager::gacDisplayCount()`. That method returns a `number_format`-ed count for the
front page, a node route, or a plain path, using the active result processor (default `url_alias`).

## Block

- Plugin id: `google_analytics_counter_form_block` (`GoogleAnalyticsCounterBlock`), admin label
  "Google Analytics Counter", category "Block".
- `build()` returns `['#theme' => 'google_analytics_counter', '#pageviews' => $appManager->gacDisplayCount()]`.
- `getCacheMaxAge()` returns `0` (uncacheable — the count is context-sensitive).

Place it like any block; it shows the count for whatever page it is rendered on.

## Filter token `[gac]`

- Filter id: `google_analytics_counter_filter` (`GoogleAnalyticsCounterFilter`), title
  "Google Analytics Counter token", type `TYPE_MARKUP_LANGUAGE`.
- Enable the filter on a text format, then put `[gac]` in content — it is replaced with the current page's
  pageview count (`gacDisplayCount()`).
- The code matches `[gac...]` via regex and also documents `[gac|all]`, `[gac|1234]`, `[gac|node/1234]`,
  `[gac|path/to/page]` variants, but only the plain `[gac]` (current page) form is functional in this
  release — all matches resolve to the current context count.

## Theme hook & template

- `hook_theme` registers `google_analytics_counter` with a single variable `pageviews`.
- Template `templates/google-analytics-counter.html.twig`:
  `<span class="google-analytics-counter">{{ pageviews }}</span>`.
- `hook_page_attachments` attaches the `google_analytics_counter/google_analytics_counter` library (a small
  CSS file) only on the legacy `bartik`/`seven` themes.

Override the template or target `.google-analytics-counter` in CSS to style the output.
