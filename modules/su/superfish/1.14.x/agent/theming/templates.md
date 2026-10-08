# Theming / templates

Superfish renders through overridable Twig templates in the module's `templates/` dir. Copy
one into your theme and clear cache to override.

- `superfish.html.twig` — the outer `<ul class="sf-menu …">` wrapper for the menu.
- `superfish-menu-items.html.twig` — recursive rendering of menu items / sub-menus.
- `superfish--help.html.twig` — help/description markup.

Theme suggestions follow the block/menu name, so you can target a specific menu
(e.g. `superfish--main.html.twig`) or a specific block. The CSS classes (`sf-menu`,
`sf-horizontal` / `sf-vertical` / `sf-navbar`, style presets) come from the settings and the
`lobsterr/drupal-superfish` library's stylesheets; add your theme's CSS to restyle. Assets are
attached via the `superfish` library defined in `superfish.module`.
