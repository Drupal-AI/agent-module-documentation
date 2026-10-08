<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# responsive_menu — configure

Everything is stored in the single config object **`responsive_menu.settings`**. There are no
config entities. Edit via the form at `/admin/config/user-interface/responsive-menu` (route
`responsive_menu.settings`, permission `administer site configuration`) or straight from Drush.

## Read / write with Drush

```bash
drush cget responsive_menu.settings                       # dump all keys
drush cget responsive_menu.settings horizontal_menu       # one key
drush cset responsive_menu.settings off_canvas_menus main -y
drush cset responsive_menu.settings horizontal_breakpoint Large -y
```

## Settings keys (`responsive_menu.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `horizontal_menu` | string | `main` | Machine name of the menu rendered by the **Horizontal menu** block. |
| `horizontal_depth` | int | `9` | Max depth shown in the horizontal menu (1–9). Mobile always shows all depths. |
| `off_canvas_menus` | string | `main` | Comma-delimited menu machine names merged into the off-canvas panel (in order). |
| `horizontal_wrapping_element` | string | `nav` | `nav` or `div` wrapping the horizontal menu block. |
| `use_breakpoint` | bool | `true` | If false, the mobile icon always shows and there is no horizontal menu/breakpoint. |
| `horizontal_breakpoint` | string | `wide` | **Label** of the theme breakpoint at which the horizontal menu appears (e.g. `Large`, `Nav`). Options come from the default theme's breakpoints. |
| `horizontal_media_query` | string | `(min-width: 960px)` | The actual media-query string for that breakpoint. The form sets this automatically from `horizontal_breakpoint`; when scripting, set both to keep them consistent. |
| `include_css` | bool | `true` | Load the module's bundled `responsive_menu.css`. Disable to style from your theme. |
| `off_canvas_position` | string | `left` | `left`, `right`, or `contextual` (LTR→left, RTL→right). *(Form field name: `position`.)* |
| `off_canvas_theme` | string | `theme-dark` | mmenu panel theme: `theme-light`, `theme-dark`, `theme-black`, `theme-white`. *(Form field name: `theme`.)* |
| `pagedim` | string | `pagedim` | Page-dim on open: `none`, `pagedim` (page colour), `pagedim-white`, `pagedim-black`. |
| `modify_viewport` | bool | `true` | Dynamically rewrite the viewport meta tag when the menu opens (fixes Chrome mobile). |
| `allow_admin` | bool | `false` | Also load the menu on admin-theme pages. |
| `wrapper_admin` | bool | `true` | Inject a page-wrapper div into the admin theme (mmenu needs one). Shown only when `allow_admin`. |
| `wrapper_theme` | bool | `false` | Inject a page-wrapper div into the front-end theme. |
| `use_bootstrap` | bool | `true` | Bootstrap 4 compatibility: make the navbar icon (`#navbar-main`) open the off-canvas menu. |
| `use_polyfills` | bool | `false` | Load mmenu IE11 polyfills. |
| `horizontal_superfish` | bool | `false` | Apply the Superfish library to the horizontal menu (requires `/libraries/superfish`). *(Form field: `superfish`.)* |
| `horizontal_superfish_delay` | int | `300` | Superfish: ms a submenu stays after mouse-out. |
| `horizontal_superfish_speed` | int | `100` | Superfish: fade-in ms. |
| `horizontal_superfish_speed_out` | int | `100` | Superfish: fade-out ms. |
| `horizontal_superfish_hoverintent` | bool | `true` | Use the HoverIntent plugin with Superfish. |
| `drag` | bool | `false` | Enable swipe/drag-to-open gesture on mobile. |
| `breakpoint_css_filepath` | string | `public://css` | Where the generated breakpoint CSS file is written. |

Note the few keys whose **form field name differs** from the config key: `position` →
`off_canvas_position`, `theme` → `off_canvas_theme`, `superfish` → `horizontal_superfish`,
`css` → `include_css`.

## Choosing menus and a breakpoint

- `horizontal_menu` and `off_canvas_menus` take **menu machine names** (`main`, `footer`,
  `admin`, `account`, …). List them with
  `drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("menu")->loadMultiple() as $m) print $m->id()."\n";'`.
- `off_canvas_menus` accepts several names comma-separated; their trees are merged in order.
- Valid `horizontal_breakpoint` **labels** come from the default theme's breakpoints. List them
  with `drush php:eval 'print_r(responsive_menu_get_breakpoints());'` (label ⇒ media query).
  Setting the breakpoint via the UI also generates a breakpoint CSS file; when you set it with
  `drush cset` set `horizontal_media_query` to the matching query too.

## Blocks to place

Config alone renders nothing until the blocks are placed (Admin → Structure → Block layout):

- **`responsive_menu_toggle`** — "Responsive menu mobile icon" (the burger toggle).
- **`responsive_menu_horizontal_menu`** — "Horizontal menu" (only visible past the breakpoint).

## Library requirement

The off-canvas menu needs the **mmenu** 8.x library at `/libraries/mmenu/dist`. Install with
`npm install` inside the module dir (then move the `libraries` dir to the docroot) or download
manually. Superfish (`/libraries/superfish`) is optional and only needed for
`horizontal_superfish`.
