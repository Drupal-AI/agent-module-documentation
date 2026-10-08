<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Theme Toggler block

Everything this module does happens through one block and its Single Directory Component. There is no
config form, permission, or route.

## Install & place

1. `drush en bootstrap_color_modes_toggler`.
2. Install the **Bootstrap Icons** webfont at `/libraries/bootstrap-icons/` (so
   `/libraries/bootstrap-icons/font/bootstrap-icons.css` resolves) — declared by the
   `bootstrap-icons` library in `bootstrap_color_modes_toggler.libraries.yml` (version 1.11.3).
3. On **Block Layout** (`/admin/structure/block`) place **"Bootstrap Theme Toggler"** (block plugin
   id `bootstra_theme_toggler_block`) into a region — typically the header/navbar. No block settings
   beyond the standard core visibility options.
4. Use a **Bootstrap 5 theme** whose CSS reacts to `data-bs-theme` (e.g. Bootstrap Barrio). On a
   non-Bootstrap theme the dropdown still renders but toggling has no visible effect.

## Rendering path (from source)

- `BootstrapThemeTogglerBlock::build()` (`src/Plugin/Block/BootstrapThemeTogglerBlock.php`) builds a
  `#type => container` with classes `theme-mode-switcher d-inline-block`, then a child
  `#theme => 'bootstrap_theme_toggler_block'` element carrying `#unique_id`
  (`Html::getUniqueId('theme-mode-toggle')`), `#color_mode => 'auto'`, `#modes => ['light','dark','auto']`
  (the `DEFAULT_MODES` constant), empty `#attached`/`#cache`, wrapped in `<div class="nav-item">`.
- `hook_theme()` maps that theme hook to `templates/bootstrap-theme-toggler-block.html.twig`
  (variables `color_mode`, `modes`), which contains only:
  `{% include 'bootstrap_color_modes_toggler:bootstrap_color_modes_toggler' %}`.
- The SDC template `components/bootstrap_color_modes_toggler/bootstrap_color_modes_toggler.twig`
  produces the actual markup: it `attach_library`s the icons, **hard-codes** the three modes
  (`light` → `bi-sun-fill`/*Light*, `dark` → `bi-moon-stars-fill`/*Dark*, `auto` → `bi-circle-half`/*Auto*),
  and renders a Bootstrap `dropdown` (`<button ... data-bs-toggle="dropdown">` + a `dropdown-menu` of
  `dropdown-item` buttons each with `data-bs-theme-value`). Labels/icons are fixed literals in the
  template — not admin- or user-supplied.

## Client behavior

- `components/bootstrap_color_modes_toggler/bootstrap_color_modes_toggler.js` defines
  `Drupal.behaviors.bootstrapColorModesToggler`. On attach it uses `once('bs-color-mode-toggler',
  '.bootstrap-theme-toggler', context)` then `init()` per toggler.
- `updateTheme()` reads `localStorage.getItem('theme-mode')`; if the value is `auto` or missing it
  sets `<html data-bs-theme>` from `window.matchMedia('(prefers-color-scheme: dark)')`, otherwise to
  the stored value. Clicking a `dropdown-item` writes the item's `data-bs-theme-value` to
  `localStorage['theme-mode']`, re-applies the theme, and swaps the toggle button's icon
  (`updateTogglerIcon()`).
- The SDC template also inlines the same read-and-apply `<script>` at render time so the stored mode
  is applied before the behavior runs (avoids a light→dark flash).

## SDC props/slots

- `components/bootstrap_color_modes_toggler/bootstrap_color_modes_toggler.component.yml`: name
  *"Bootstrap Color Modes Toggler"*, `status: stable`. One prop `modes` (array) and one slot
  `toggler`. In practice the template ignores the `modes` prop and uses its own hard-coded map, so
  passing `modes` from an embedding template has no effect.

## Operating notes

- State is **per-browser** (`localStorage`), never sent to Drupal — no cache tags/contexts needed and
  nothing to configure per user or role.
- Because the modes are hard-coded in the SDC Twig, you cannot change labels/icons/order through the
  UI; override the component or template in a subtheme to customize.
- The block `id` contains a typo (`bootstra_theme_toggler_block`); reference that exact string when
  placing it via config or code.
