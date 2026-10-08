# Theming

Theme hooks registered in `viewsreference_theme()` (`viewsreference.module`), templates in
`templates/`.

| Theme hook | Template | Purpose |
|---|---|---|
| `viewsreference__view_title` | `viewsreference--view-title.html.twig` | renders the (optionally overridden) view title above the embed |
| `viewsreference__lazy_builder_loading` | `viewsreference--lazy-builder-loading.html.twig` | placeholder shown while the lazy formatter resolves the view |

- `template_preprocess_viewsreference__view_title()` sets `title` and adds the view storage as a
  cacheable dependency.
- `hook_theme_suggestions_viewsreference__view_title()` adds per-view suggestions so you can
  override the title template for a specific view.

Override by copying a template into your theme, or add a suggestion-based variant
(e.g. `viewsreference--view-title--my-view.html.twig`).
