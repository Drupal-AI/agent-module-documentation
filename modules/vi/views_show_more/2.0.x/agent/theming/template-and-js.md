<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Template, JS library & the AJAX response subscriber

## Template & preprocess

- Theme hook `views_show_more_pager` → `templates/views-show-more-pager.html.twig`.
- `views_show_more_preprocess_views_show_more_pager(&$vars)` builds the button: if the current page
  is before the last, it sets `vars['item']` with an `href` to the next page (via
  `PagerManager::getUpdatedParameters`) and the `show_more_text` label; otherwise it adds the
  `pager-show-more-empty` class. Pager wrapper classes: `js-pager__items pager__items
  pager-show-more`. Adds the `url.query_args` cache context and a unique `heading_id`.

Override the template in your theme to change the button markup (keep the `.pager-show-more`
wrapper class or set a custom `advance.pager_selector`).

## JS library

`views_show_more/views_show_more` (`js/views_show_more.js`; deps `core/jquery`, `core/once`,
`core/drupal`, `core/drupal.ajax`) — attached by the pager's `render()` **only when the display is
AJAX-enabled**. It implements the `viewsShowMore` AJAX command (append/replace + animations +
header/footer updates) using the configured selectors.

## AJAX response subscriber

`ShowMoreEventSubscriber` (service `views_show_more.event_subscriber`, on `KernelEvents::RESPONSE`)
rewrites the Views AJAX response when the view's pager is `show_more` and the page is > 0:

- Removes the `scrollTop` / `viewsScrollTop` commands (no jump to top).
- Converts the default `insert`/`replaceWith` command into a `viewsShowMore` command, setting its
  `method` to the pager's `result_display_method` and, when the style is `html_list` (`ul`/`ol`),
  `table`, or `grid`, an `append_at` target so new rows land in the correct container.
- Attaches `effect` / `speed` / `scroll_offset` when an animation is configured.
- Passes the `advance` selectors (content/pager/header/footer) to the command.
- Renders the view header/footer and puts them in `drupalSettings.header` / `.footer` so the JS can
  refresh those areas (e.g. a live result count).

So: styling/markup → the Twig template; runtime append/replace behaviour → the JS + this subscriber;
what/how-many rows → the pager plugin's `query()`.
