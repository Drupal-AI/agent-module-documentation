# Views Load More — agent index

Provides one Views **pager plugin** (`id: load_more`, extends core `Full`) that renders a
"Load more" button instead of numbered pages and AJAX-**appends** the next page of results
to the bottom of the list. No configure route (`configure: null`), no settings form, no
permissions, no Drush. Depends on `views`.

- **Turn a view's pager into "Load more" and all its options (button text, finished text, effects, selectors) + config schema** →
  [configure/pager.md](configure/pager.md)
- **How the AJAX append works, the theme hook / Twig template, and the CSS selectors it relies on** →
  [theming/pager-template.md](theming/pager-template.md)

Key facts:
- Pager plugin id is `load_more`; its config lives inside the view display's
  `pager` option (`type: load_more`, plus `options.more_button_text`, `options.end_text`,
  `options.effects`, `options.advanced`). Config schema id: `views.pager.load_more`.
- Requires **AJAX enabled** on the display to append; without AJAX the button is a plain
  next-page link.
- Default selectors: content `> .view-content`, pager `.pager--load-more`.
