# tb_megamenu — theming

Rendering starts from a render element `['#theme' => 'tb_megamenu', '#menu_name' => …,
'#block_theme' => …, '#attached' => ['library' => ['tb_megamenu/theme.tb_megamenu']]]`
returned by the block plugin, plus a `#post_render` callback that appends column counts.

## Theme hooks (hook_theme in tb_megamenu.module)

Frontend/shared templates in `templates/`:

| Hook | Template | Key variables |
|---|---|---|
| `tb_megamenu` | `tb-megamenu.html.twig` | `menu_name`, `content`, `section`, `block_theme` |
| `tb_megamenu_nav` | `tb-megamenu-nav.html.twig` | `items`, `menu_config`, `block_config`, `level`, `trail` |
| `tb_megamenu_item` | `tb-megamenu-item.html.twig` | `item`, `submenu`, `menu_config`, `block_config`, `trail` |
| `tb_megamenu_submenu` | `tb-megamenu-submenu.html.twig` | `parent`, `menu_config`, `block_config` |
| `tb_megamenu_subnav` | `tb-megamenu-subnav.html.twig` | `col`, `items`, `menu_config` |
| `tb_megamenu_row` | `tb-megamenu-row.html.twig` | `row`, `parent`, `level` |
| `tb_megamenu_column` | `tb-megamenu-column.html.twig` | `col`, `parent`, `level` |
| `tb_megamenu_block` | `tb-megamenu-block.html.twig` | `block_id`, `section`, `showblocktitle` |

Back-end (builder UI) templates live in `templates/backend/`:
`tb_megamenu_backend`, `tb_megamenu_item_toolbox`, `tb_megamenu_submenu_toolbox`,
`tb_megamenu_column_toolbox`, and `tb_megamenu_admin_settings` (`render element: form`).

Each hook has a matching `template_preprocess_{hook}()` in `tb_megamenu.module` that
resolves item/column/block config, builds the trail, and sets classes — override those
variables in a theme preprocess if needed. `template_preprocess_tb_megamenu` also injects
`drupalSettings.TBMegaMenu.theme`.

## Overriding

Copy any `tb-megamenu-*.html.twig` into your theme's `templates/` and clear cache. The
`section` variable is `frontend` for the placed block and `backend` inside the builder, so
you can branch on it.

## Libraries (tb_megamenu.libraries.yml)

- `tb_megamenu/theme.tb_megamenu` — frontend CSS/JS (bootstrap, base, default, compatibility
  CSS + `tb-megamenu-frontend.js`); depends on core/jquery, core/drupal, core/drupalSettings,
  core/once. Auto-attached by the block.
- `tb_megamenu/form.configure-megamenu` — admin builder assets (backend CSS/JS).
- `tb_megamenu/form.chosen`, `tb_megamenu/form.font-awesome` — optional external CDN assets.
- `tb_megamenu/block_style.black|blue|green` — the built-in color styles from
  `css/styles/*.css`, selected by the block-level `style` setting.

Note: several libraries reference external CDN URLs (Font Awesome 4.3.0, Chosen 1.1.0).
