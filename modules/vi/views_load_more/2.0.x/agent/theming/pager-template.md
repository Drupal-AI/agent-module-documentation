# Mechanism, theme hook & template

## How the append works (AJAX flow)

1. `views_load_more_views_pre_render($view)` — if the display has AJAX enabled **and** its
   pager plugin id is `load_more`, it attaches the `views_load_more/views_load_more` library.
2. When the user clicks the button, Views issues its normal AJAX page request. The response
   is a `ViewAjaxResponse`.
3. `VLMEventSubscriber::onResponse()` (a `kernel.response` subscriber) inspects the response.
   If the pager is `load_more` and `getCurrentPage() > 0` it:
   - removes the `scrollTop` and `viewsScrollTop` commands (no jump-to-top),
   - removes the default `insert`/`replaceWith` command that would replace the whole view,
   - adds a **`VLMAppendCommand`** carrying the new rows + options (wrapper/content/pager
     selectors, effect, speed, and a `target_list` for list/table styles).
4. Client-side `Drupal.AjaxCommands.prototype.viewsLoadMoreAppend` (in
   `js/views_load_more.js`) appends the new rows into the content wrapper, replaces the pager
   markup, and runs the optional jQuery `fadeIn`/`slideDown` effect.

Style-specific targets set by the subscriber:
- `html_list` style with `ul`/`ol` → appends into `> div > <ul|ol>:not(.links)` (or the
  configured `wrapper_class`).
- `table` style → appends into `.views-table tbody`.

## Theme hook

`hook_theme()` registers `views_load_more_pager` with variables `element`, `parameters`,
`more_button_text`, `end_text` and pattern `views_load_more_pager__` (so you can override per
view: `views-load-more-pager--<view-id>.html.twig`).

`template_preprocess_views_load_more_pager()` uses `pager.manager` to compute the next page
and sets `next_url` only when a next page exists.

## Template (`templates/views-load-more-pager.html.twig`)

Renders `<nav class="pager pager--load-more">`; when `next_url` is set it prints the button
as `<a href="{{ next_url }}">{{ more_button_text }}</a>` inside `.pager__items.js-pager__items`;
otherwise, if `end_text` is set, it prints the finished text in `.pager__items--end`.

## Selectors an override must respect

- Rows wrapper defaults to `> .view-content` (`LoadMore::DEFAULT_CONTENT_SELECTOR`).
- Pager defaults to `.pager--load-more` (`LoadMore::DEFAULT_PAGER_SELECTOR`).
- If your theme moves the rows or renames the pager, set `advanced.content_selector` /
  `advanced.pager_selector` in the pager options so the JS can find and replace them.

## Optional: Waypoints

Installing the contrib **Waypoints** module lets the pager auto-trigger when it scrolls into
view (infinite-scroll feel) instead of requiring a click. It is a `suggests`, not a hard dep.
