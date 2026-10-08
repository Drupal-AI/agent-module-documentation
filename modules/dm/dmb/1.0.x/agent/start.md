<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dark Mode Button (dmb) — agent index

A single **block plugin** that renders an icon button which toggles a **client-side dark theme**.
Clicking it toggles a `dark-mode` class on `<body>` and persists the choice in the browser's
`localStorage`. Package `Other`. Depends only on core **`block`**. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version 1.0.1.

- **The block, the library, the toggle mechanism, how to place and restyle it** →
  [blocks/dark-mode-toggle.md](blocks/dark-mode-toggle.md)

## What it actually is

- One block plugin: `DmbBlock` (id **`dmb_block`**, admin label *"Dark Mode Toggle"*) in
  `src/Plugin/Block/DmbBlock.php`, extending core `BlockBase`. Its `build()` returns
  `#theme => 'dmb_dark_mode_toggle'` and attaches the `dmb/dark_mode` library.
- One theme hook: `dmb_dark_mode_toggle` declared in `dmb.module` (`hook_theme()`), template
  `templates/dmb-dark-mode-toggle.html.twig` — a `<button id="dark-mode-toggle">` with a
  Bootstrap Icons `<i>` glyph.
- One asset library `dmb/dark_mode` (`dmb.libraries.yml`): `css/dark-mode.css` + `js/dark-mode.js`,
  depending on `core/jquery`, `core/jquery.once`, and `dmb/bootstrap_icons`. The
  `dmb/bootstrap_icons` library pulls Bootstrap Icons CSS from `cdn.jsdelivr.net` as an external asset.
- **No** routes, **no** permissions, **no** config form or schema, **no** services, **no** Drush,
  **no** entities, **no** custom hooks beyond `hook_theme()`. All state is client-side only.

## Mechanism (from source)

- `js/dark-mode.js` defines `Drupal.behaviors.darkModeToggle`. On attach it reads
  `localStorage.getItem('dark-mode')`; if `'true'` it adds `dark-mode` to `<body>`. The button's
  click handler (bound once via `.once('darkModeToggle')`) toggles the `dark-mode` body class,
  writes the boolean back to `localStorage`, and swaps the icon class between `bi-moon-fill`
  (light) and `bi-sun-fill` (dark).
- `css/dark-mode.css` styles the button container and defines the `body.dark-mode` appearance by
  overriding common theme selectors (body, `.container`, headings, links, tabs, pager, tags,
  code blocks). No user- or server-supplied data is involved.

## Install / place

- `drush en dmb -y`, then place the **Dark Mode Toggle** block in a region at
  `/admin/structure/block` (or via block layout). No configuration is required.
