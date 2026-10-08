# advanced_language_selector — agent start

Provides ONE block plugin, `advanced_language_selector_block` (admin label "Advanced language
selector block", category "Language block"), that renders a styled language switcher with flag
icons. Eight display **styles** are defined as YAML in `config/styles/*.yml`
(bootstrap_dropdown, bootstrap_navigation, bootstrap_modal, bootstrap_offcanvas,
bootstrap_list_group, bootstrap_button_group, plain_html, plain_html_list). The block form is
built dynamically from those YAML style definitions via the `StyleManager` service; each style
has a matching `block--language-selector--<style>.html.twig` template. Flags are bundled SVGs in
`assets/flags/`, mapped by `src/Langcodes.php`.

No dependencies, no permissions, no Drush, no config route. Block is visible only on multilingual
sites and is uncacheable (`getCacheMaxAge() = 0`). Config schema exists (mostly stub). Bootstrap
styles can optionally attach a Bootstrap 5 + Popper CDN library.

- Place the block, pick a style, set langcode/flag/label options → [configure/block.md](configure/block.md)
- Twig templates per style, overriding markup, flag SVG assets → [theming/templates.md](theming/templates.md)
- How styles are defined (YAML + template + hook_theme) and the StyleManager service → [extend/styles.md](extend/styles.md)
