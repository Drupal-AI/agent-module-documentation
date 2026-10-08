<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: theme hooks, templates, libraries

We Mega Menu renders entirely through theme hooks registered in `we_megamenu_theme()`
(`we_megamenu.module`), each with a Twig template in `templates/` and a
`template_preprocess_<hook>()` in the `.module`. To override markup, copy the template into your
theme and clear caches.

## Theme hooks (and their templates)

| theme hook | template | role |
|---|---|---|
| `we_megamenu_frontend` | `we-megamenu-frontend.html.twig` | front-end menu wrapper (what the block renders) |
| `we_megamenu_backend` | `we-megamenu-backend.html.twig` | builder wrapper on the admin page |
| `we_megamenu_ul` | `we-megamenu-ul.html.twig` | top-level `<ul>` |
| `we_megamenu_li` | `we-megamenu-li.html.twig` | a menu item `<li>` (+ its dropdown) |
| `we_megamenu_submenu` | `we-megamenu-submenu.html.twig` | dropdown panel container |
| `we_megamenu_row` | `we-megamenu-row.html.twig` | a row inside a dropdown |
| `we_megamenu_col` | `we-megamenu-col.html.twig` | a column inside a row (links or an embedded block) |
| `we_megamenu_subul` | `we-megamenu-subul.html.twig` | nested `<ul>` of links in a column |
| `we_megamenu_block` | `we-megamenu-block.html.twig` | a Drupal block embedded in a column |

The frontend stack is the one you normally override; the backend hook is only used on the builder
page. The render pipeline nests top-down: `we_megamenu_frontend` → `we_megamenu_ul` →
`we_megamenu_li` → `we_megamenu_submenu` → `we_megamenu_row` → `we_megamenu_col` →
(`we_megamenu_subul` links **or** `we_megamenu_block`). Common variables threaded through every
hook: `menu_name`, `block_theme`, `section`, `items`, `data_config`, `trail`.

The wrapper preprocess sets `data-*` attributes on the `<nav>` from `data_config.block_config`
(`data-style`, `data-animation`, `data-action`, `data-mobile-collapse`, …), plus classes
`navbar navbar-we-mega-menu <menu_name> <section>`. The JS reads these attributes to drive
hover/click, animation, and mobile collapse.

## Libraries (`we_megamenu.libraries.yml`)

| library | when | contents |
|---|---|---|
| `we_megamenu/form.we-mega-menu-backend` | builder page (attached by the config controller) | Bootstrap 5.3 (CDN), jQuery UI, Chosen, `we_megamenu.icon.js`, `we_megamenu.js`, backend CSS |
| `we_megamenu/form.we-mega-menu-frontend` | rendered menu (attached by the block) | Bootstrap 5.3 (CDN), `we_mobile_menu.js`, `we_megamenu_frontend.js`, backend CSS |

Both depend on `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`. Note Bootstrap
CSS/JS load from `cdn.jsdelivr.net` (external), which matters for CSP / offline sites.

## Admin body class

`we_megamenu_preprocess_html()` adds a `we-mega-menu-backend` body class (plus the
`we_megamenu_backend_style` state value) on any `admin/structure/we-mega-menu/*` page, used to
skin the builder.
