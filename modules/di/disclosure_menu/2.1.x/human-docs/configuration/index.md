# Configuration

Disclosure Menu has no global settings page — everything is configured **per block
instance**. You place one block per menu and set its options on the block form.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, and choose the **Disclosure menu**
   entry for the menu you're targeting (there's one derivative per menu — Main
   navigation, Footer, etc.).
3. Configure the settings below and save. Place as many as you like (e.g. main menu,
   footer, account), each with independent settings.

## Core menu settings

Because the block extends the core menu block, the usual **menu level**, **depth**, and
**expand all items** options are available alongside the disclosure options below.

## Submenu disclosure

- **Submenu disclosure levels** (default *unlimited*) — how many menu levels get submenu
  toggle buttons: unlimited, none, or a specific count 1–9. (Hidden when depth is 1.)
- **Include chevron** (default on) — insert a chevron icon in each submenu toggle.
- **Include label** (default off) — whether submenu toggles carry a visible text label.
- **Button label** (default `More [menu-link:title] pages`) — the label text when the
  above is on. Supports `menu-link` tokens, so you can build labels from the parent
  link's title.

## Full-menu disclosure

- **Menu disclosure** (default off) — add one extra button that toggles the **whole
  menu** open/closed (handy as a mobile "menu" button).
- **Include label** (default on) — whether that full-menu button shows a visible label.
- **Button label** (default `Open [menu:name]`) — the full-menu toggle's label; supports
  `menu` tokens.

A token-tree helper appears under each label field so you can see the available tokens.

## JavaScript behaviour

- **Include default JS** (default on) — attaches the toggle JavaScript. **Without it the
  buttons don't work**, so leave it on unless you're supplying your own script.
- **Include hover JS** (default off) — also open submenus on hover (only takes effect
  when the default JS is on).
- **Resolve hover/click** (default *keyboard only*) — how to reconcile hover and click:
  - **keyboard_only** — the button reacts to keyboard activation only,
  - **only_open** — a click only opens (never closes),
  - **no_change** — plain toggle.
- **Hover show delay** (default `150` ms) — wait before opening a submenu on hover.
- **Hover hide delay** (default `250` ms) — wait before closing a submenu after the
  pointer leaves.

## Styling

- **Include CSS** (default *horizontal*) — which bundled styles to load:
  - **none** — no default styles (style `.menu__disclosure` yourself in your theme),
  - **horizontal** — a horizontal dropdown bar,
  - **vertical** — a vertical/sidebar-style menu.

## Theming (developers)

The block renders through a custom `menu__disclosure` theme hook. Override
`templates/menu--disclosure.html.twig` in your theme to change the markup — but keep the
ARIA wiring intact: each toggle must set `aria-controls` pointing at its submenu's id
(and the `li` carries `data-submenu-id` for hover). See the [`agent/`](../agent/start.md)
docs for the full list of template variables and libraries.
