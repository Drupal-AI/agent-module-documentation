# Theming & JavaScript

## Template
`templates/views-infinite-scroll-pager.html.twig` renders the pager. Preprocess
`hook_preprocess_views_infinite_scroll_pager()` (in the `.module`) computes the `next` link and
sets `attributes` with `data-drupal-views-infinite-scroll-pager` = `automatic` (auto-load) or
`TRUE` (button). Override the template in your theme to change the button/markup.

Results are wrapped by `hook_preprocess_views_view()`: the rows get a container with
`data-drupal-views-infinite-scroll-content-wrapper` and classes
`views-infinite-scroll-content-wrapper clearfix` — the JS appends new rows into this wrapper.
The same preprocessing is applied to contributed **EVA** displays.

## JavaScript library
Library `views_infinite_scroll/views-infinite-scroll` (`views_infinite_scroll.libraries.yml`),
file `js/infinite-scroll.js`, depends on `core/jquery`, `core/once`, `core/drupal`,
`core/drupal.debounce`, `views/views.ajax`. An `AjaxResponseSubscriber`
(`views_infinite_scroll.ajax_subscriber` event subscriber) adjusts the AJAX response so appended
content behaves. To change behavior, override the library in your theme's `*.libraries.yml` via
`libraries-override` and supply your own script.
