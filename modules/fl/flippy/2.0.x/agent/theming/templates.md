# Flippy theming

## Theme hook

`flippy` (registered in `flippy_theme()`), template **`flippy.html.twig`**. Variables:
- `list` — raw neighbour array before preprocessing (unset after preprocess).
- `node` — the current node.
- After `template_preprocess_flippy()`: `first`, `prev`, `next`, `last`, `random` (each a link or
  an empty-`span` render array when `flippy_show_empty_<type>` is on), and `base_path`.

The default template wraps the links in `<div class="flippy">` with `.flippy-prev`, `.flippy-next`,
`.flippy-first`, `.flippy-last`, `.flippy-random` items. Changing the `flippy` wrapper class in a
custom template disables the `hammerjs` keyboard/swipe feature (it targets that class).

## Template suggestions

`flippy_theme_suggestions_flippy()` adds, in order:
- `flippy__<bundle>` — e.g. `flippy--article.html.twig`
- `flippy__<bundle>__<nid>` — e.g. `flippy--article--123.html.twig`

Put these in your theme's `templates/` directory to override markup per content type or per node.

## Labels & preprocessing

`template_preprocess_flippy()` reads the per-type labels (`flippy_first_label_<type>`, etc.) from
`flippy.settings`, applies the loop wrap-around when `flippy_loop_<type>` is on, and builds each
link via `FlippyPager::flippy_generate_link()` (token replacement + optional truncation happen
there). Empty links are rendered as `<span class="empty">` only when `flippy_show_empty_<type>`
is enabled.

## Libraries & CSS

- `flippy/drupal.flippy` — base CSS (`css/flippy.css`), attached whenever the pager renders.
- `flippy/flippy.swipe` — `js/flippy.js`, attached (with `hammerjs/hammerjs`) only when
  `flippy_press_swipe_<type>` is on and the `hammerjs` module is installed.
