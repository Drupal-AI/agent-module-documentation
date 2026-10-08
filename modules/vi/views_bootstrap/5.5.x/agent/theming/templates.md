# Templates & theme suggestions

Each style ships a Twig template in `templates/`, registered via
`hook_theme()` (in `src/Hook/ViewsBootstrapHooks.php`) with preprocessing in
`views_bootstrap.theme.inc`:

- `views-bootstrap-cards.html.twig`
- `views-bootstrap-carousel.html.twig`
- `views-bootstrap-accordion.html.twig`
- `views-bootstrap-tab.html.twig`
- `views-bootstrap-grid.html.twig`
- `views-bootstrap-list-group.html.twig`
- `views-bootstrap-dropdown.html.twig`
- `views-bootstrap-media-object.html.twig`
- `views-bootstrap-table.html.twig`

Copy the relevant file into your theme's `templates/` folder to override markup.

## Theme suggestions
`views_bootstrap_theme_suggestions_alter()` adds per-view / per-display
suggestions for any `views_bootstrap_*` hook, so you can override one view only:
- `{style}__{view_id}` — e.g. `views_bootstrap_cards__frontpage`
- `{style}__{display_id}` — e.g. `views_bootstrap_cards__block_1`
- `{style}__{view_id}__{display_id}`

Create e.g. `views-bootstrap-cards--frontpage.html.twig` to target one view.

## Library
`views_bootstrap/components` (`views_bootstrap.libraries.yml`) bundles
`js/views-bootstrap.js` (depends on core/jquery) for carousel helpers. Bootstrap
5's own CSS/JS must be supplied by the active theme.
