# esa_pager — Views pager plugin & theme

## Views pager plugin (`src/Plugin/views/pager/EsaPager.php`)

```
@ViewsPager(
  id = "esa_pager",
  title = "Custom Esa pager",
  theme = "esa_pager",
  register_theme = FALSE
)
```

`EsaPager extends SqlBase` (core Views full pager base). Select it as the pager on any View
(Pager → "Custom Esa pager"). `render($input)` returns a `#theme 'esa_pager'` render array populated with
`#tags` (`1 => previous`, `3 => next`), `#element` (pager id), `#parameters` ($input, the exposed input),
`#total_items`, `#items_per_page`, and `#route_name` (`<current>` in live preview, else `<none>`).
`summaryTitle()` returns the standard items-per-page / offset summary.

## Theme + preprocess (`esa_pager.module`)

- `esa_pager_theme()` registers theme hook `esa_pager` → `templates/esa_pager.html.twig`, variables:
  `tags`, `element`, `parameters`, `total_items`, `items_per_page`, `route_name`, `route_params`.
- `esa_pager_preprocess_esa_pager()` builds the pager items from core `pager.manager` (based on the Views
  mini-pager / `pager.inc` logic): computes total pages from `total_items`/`items_per_page`, then fills
  `items.previous`, `items.next`, and `items.pages` (numbered, with first/last always shown, a center
  window, and `ellipsis` markers). Each link's href is built with
  `PagerManagerInterface::getUpdatedParameters()`; previous/next use the `<current>` route, numbered pages
  use `route_name`/`route_params`. Adds `data-page` attributes (used by the parent's `ajaxify` JS for AJAX
  paging), the `url.query_args` cache context, and attaches library `esa_pager/pager`.

## Template (`templates/esa_pager.html.twig`)

Renders a `<nav class="pager pager-large">` with previous / numbered (active state, ellipses) / next items,
using `data-page` for AJAX and `visually-hidden` labels for accessibility. Override it in your theme like
any Drupal pager template.

## Use with the parent

The parent's `SearchController::renderPager($query, $total, $size)` calls
`pager.manager->createPager($total, $size)` and returns a `#theme 'esa_pager'` array pointing at the search
route — so on a framework search page the pager renders without Views. Enable `esa_pager` to make the
`esa_pager` theme hook and library available.
