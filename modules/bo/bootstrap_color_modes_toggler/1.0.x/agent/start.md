<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Theme Toggler (bootstrap_color_modes_toggler) — agent index

A front-end-only module that adds **one block** rendering a light/dark/auto color-mode dropdown for
a **Bootstrap 5** theme. Selecting a mode sets `data-bs-theme` on `<html>` and stores it in browser
`localStorage`. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed
1.0.0-alpha7 (version dir 1.0.x).

- **The block, its template/SDC, the JS behavior, and how to place it** →
  [blocks/toggler.md](blocks/toggler.md)

## What it actually is

- One block plugin: `BootstrapThemeTogglerBlock` (id **`bootstra_theme_toggler_block`** — note the
  spelling; admin label *"Bootstrap Theme Toggler"*, category *Custom*) in
  `src/Plugin/Block/BootstrapThemeTogglerBlock.php`, extending core `BlockBase`.
- `build()` returns a container plus a `#theme => 'bootstrap_theme_toggler_block'` element, passing
  a `Html::getUniqueId('theme-mode-toggle')` and the constant modes `['light','dark','auto']`.
  There is **no `blockForm()`/`blockSubmit()`** — the block has no admin settings.
- `hook_theme()` in `bootstrap_color_modes_toggler.module` declares the `bootstrap_theme_toggler_block`
  theme hook (template `templates/bootstrap-theme-toggler-block.html.twig`), which simply includes the
  Single Directory Component `bootstrap_color_modes_toggler:bootstrap_color_modes_toggler`.
- The SDC (`components/bootstrap_color_modes_toggler/`) holds the real markup, the client JS
  (`bootstrap_color_modes_toggler.js`), CSS, and an inline pre-render `<script>`.

## What it does NOT have

- **No permissions** (no `*.permissions.yml`), **no routes**, **no services**, **no config schema or
  config/install**, **no Drush**, **no install/update hooks**. The only hook is `hook_theme()`.
- No server-side state at all — the mode lives only in the visitor's `localStorage` (`theme-mode`).

## Dependencies

- Runtime: a Bootstrap 5 theme that honors `data-bs-theme` (e.g. Bootstrap Barrio). No Drupal module
  deps.
- Asset: library `bootstrap_color_modes_toggler/bootstrap-icons` loads the Bootstrap Icons 1.11.3
  webfont from **`/libraries/bootstrap-icons/font/bootstrap-icons.css`** (must be installed there for
  the sun/moon/auto glyphs).
