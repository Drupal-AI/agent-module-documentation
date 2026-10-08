<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `infinite_scroll_with_pager` Views pager plugin

The whole module is one Views pager plugin plus the glue (a preprocess hook, an AJAX response
subscriber, a Twig template and a JS behaviour) needed to make a numeric pager coexist with
infinite scroll.

## Install / enable

- `composer require drupal/views_infinite_scroll_with_pager` then `drush en
  views_infinite_scroll_with_pager -y`.
- Hard dependency (info.yml): contrib **`views_infinite_scroll`** (`^2.0`, via composer.json
  `require`). No core module deps beyond Views itself.
- No routes, no permissions, no admin/config page, no Drush, no install hooks. Everything is set
  per-view.

## Turning it on for a view

1. Edit the view → **Pager** → choose **"Infinite Scroll with Pager"**.
2. Under **Advanced**, set **"Use AJAX" = Yes** (required — the infinite append is driven by the
   Views AJAX response; without AJAX only the numeric pager works).
3. Pager options (see settings below).

## The plugin class

`src/Plugin/views/pager/InfiniteScrollWithPager.php`, class `InfiniteScrollWithPager`, annotation:

```
@ViewsPager(
  id = "infinite_scroll_with_pager",
  title = "Infinite Scroll with Pager",
  theme = "views_infinite_scroll_with_pager"
)
```

It **extends** `Drupal\views_infinite_scroll\Plugin\views\pager\InfiniteScroll`, so it inherits the
parent's `button_text` / `automatically_load_content` options and just adds a numeric-pager layer.

- `defineOptions()` adds a `pager_values` group: `quantity` (default **9** — number of visible page
  links), `user_friendly_keys` (default TRUE — display pages 1-based instead of 0-based; label
  only, no functional effect), and label strings `first` (`« First`), `previous` (`«`), `next`
  (`»`), `last` (`Last »`).
- `buildOptionsForm()` renders those as a collapsible **"Infinite Scroll Pager Options"** details
  element (weight `-99`, just under the inherited infinite-scroll settings): a `number` field
  (`#min => 0`) for quantity, a checkbox for user-friendly keys, and four textfields for the link
  labels.
- `render($input)` calls `parent::render()`, then attaches `#tags` (the label strings +
  `user_friendly_keys`), sets `#theme` to `views_infinite_scroll_with_pager`, computes
  `#quantity`, sets `#route_name` (`<current>` in live preview, else `<none>`), and attaches the
  library `views_infinite_scroll_with_pager/views-infinite-scroll-with-pager`.
- **Quantity clamp:** if `quantity * itemsPerPage > totalItems`, quantity is reduced to
  `ceil(totalItems / itemsPerPage)` so the pager never shows more page links than there are pages.

## Config object & schema

Pager options are stored inside the view's display config (`pager.options`), not a standalone
config object. Schema: `config/schema/views_infinite_scroll_with_pager.schema.yml` defines
`views.pager.infinite_scroll_with_pager` extending core's `views_pager_sql`, with the
`views_infinite_scroll` mapping (`button_text`, `automatically_load_content`) and the `pager_values`
mapping (`quantity` int, `user_friendly_keys` bool, `first`/`previous`/`next`/`last` labels).

## Rendering the pager markup

`views_infinite_scroll_with_pager.module` implements
`hook_preprocess_views_infinite_scroll_with_pager()`. It reuses the logic of core's
`template_preprocess_views_mini_pager()`:

- Reads the pager via `\Drupal::service('pager.manager')->getPager($element)`; returns early if
  there is no pager.
- Builds the window of visible page links centred on the current page (helpers
  `..._build_item_page()` for numbered links and `..._build_item()` for first/previous/next/last),
  using `PagerManager::getUpdatedParameters()` to build each link's query string and
  `Url::fromRoute('<none>', …)` for the href. `ksort()`s the page items.
- The "load more" (infinite-scroll) link gets an extra `next=TRUE` query param so the AJAX
  subscriber (below) can recognise scroll-append requests.
- Adds cache context `url.query_args`, and sets `attributes`
  (`data-drupal-views-infinite-scroll-pager` = `automatic` or TRUE) and `pager_attributes`
  (`data-drupal-views-infinite-scroll-numeric-pager`), which the JS keys off.

Template `templates/views-infinite-scroll-with-pager.html.twig`: renders the numeric pager by
`{% include '@system/pager.html.twig' %}` inside the `pager_attributes` wrapper, then the
infinite-scroll "load more" `<a class="button" id="load-more" rel="next">` from `items.more`.
All link text is Twig-autoescaped. **Override** by copying this template into your theme's
`templates/` and swapping the include for your framework's pager (README example:
`@bootstrap/system/pager.html.twig`).

## AJAX append behaviour

- **Service** `views_infinite_scroll_with_pager.ajax_subscriber` →
  `src/EventSubscriber/AjaxResponseSubscriber` (event subscriber on `KernelEvents::RESPONSE`).
  `onResponse()` acts only when the response is a `ViewAjaxResponse`, the view's pager is
  `infinite_scroll_with_pager`, the current page is > 0, and the request has a `next` query param.
  In `alterPaginationCommands()` it rewrites any `replaceWith` command's method to
  `infiniteScrollPagerInsertView` (so new rows are appended, not replaced) and drops
  `scrollTop`/`viewsScrollTop` commands (so the page doesn't jump to the top). It does **not**
  fetch or expose any rows itself — the rows are whatever the standard Views AJAX response already
  produced, subject to the view's normal access.
- **JS** `js/infinite-scroll-with-pager.js` (library `views-infinite-scroll-with-pager`, deps:
  jQuery, once, drupal, debounce, `views/views.ajax`,
  `views_infinite_scroll/views-infinite-scroll`) defines
  `$.fn.infiniteScrollPagerInsertView`: it finds the current view instance in
  `Drupal.views.instances`, swaps the old numeric pager
  (`[data-drupal-views-infinite-scroll-numeric-pager]`) for the new one from the incoming markup,
  then delegates the row-append to the parent module's `$.fn.infiniteScrollInsertView`.

## Operating notes

- Pager labels and `button_text` are set by view administrators (needs *administer views*); they
  are plain admin-configured strings, autoescaped on output.
- With JS off, only the numeric pager (standard page-parameter links) is functional — that is the
  progressive-enhancement point of the module.
- The pager links and the scroll must resolve to the same result set; verify after install and
  check that a theme hasn't hidden the pager with CSS.
