# Theming / templates

Superfish renders through overridable Twig templates in the module's `templates/` dir (registered
in the `theme` hook — `ThemeHooks::theme()` in 1.16.x). Copy one into your theme and clear cache to
override.

- `superfish.html.twig` — the outer `<nav>` + `<ul class="sf-menu …">` wrapper for the menu
  (theme hook `superfish`, preprocessed in `superfish.theme.inc`).
- `superfish-menu-items.html.twig` — recursive rendering of menu items / sub-menus
  (theme hook `superfish_menu_items`, preprocessed in `superfish.theme.inc`).
- `superfish--help.html.twig` — help/description markup (theme hook `superfish_help`).

Theme suggestions follow the block/menu name, so you can target a specific menu
(e.g. `superfish--main.html.twig`) or a specific block. The CSS classes (`sf-menu`,
`sf-horizontal` / `sf-vertical` / `sf-navbar`, `sf-depth-N`, style presets) come from the settings
and the `lobsterr/drupal-superfish` library's stylesheets; add your theme's CSS to restyle. Menu
link titles are rendered through core's `#type => link` element (escaped), and custom classes are
run through `Html::cleanCssIdentifier()` before output. Assets are attached via the `superfish`
libraries defined in `hook_library_info_build()` (`src/Hook/LibraryHooks.php`).
