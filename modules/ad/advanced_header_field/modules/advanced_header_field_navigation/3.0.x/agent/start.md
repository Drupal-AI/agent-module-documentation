<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Header Field (Navigation) (advanced_header_field_navigation) — agent index

Submodule of **Advanced Header Field**. Adds an in-page **jump menu**: a block that renders an empty
`<nav>` plus JavaScript that builds an anchor-link list from the page's opted-in
`advanced_header_field` headings. Depends on **`advanced_header_field`** (declared in
`*.info.yml`). Package `Other`. Core `^11 || ^12`. License GPL-2.0-or-later. Version 3.0.x.

- **The block, the widget additions, and the JS mechanism** →
  [plugins/jump-menu.md](plugins/jump-menu.md)

## What it provides (from source)

- **Block plugin** `ahf_navigation_jump_menu` — `src/Plugin/Block/JumpMenu.php` (`BlockBase`),
  category *Navigation*. `build()` returns `#theme => 'ahf_navigation_jump_menu'` and attaches
  library `advanced_header_field_navigation/jump-menu`. No block settings.
- **Hooks** — `src/Hook/AdvancedHeaderFieldNavigationHooks.php` (attribute hooks):
  - `theme` registers `ahf_navigation_jump_menu` (+ preprocess that sets `base_class = 'jump-menu'`
    and the fixed element id `jump-menu`).
  - `field_widget_single_element_advanced_header_field_form_alter` adds **Show in Jump Menu**
    (`show_in_jump_menu` checkbox) and **Short Title** (`short_title` textfield) to the header
    widget's Header Options, and a `validateFormNavigationOptions` callback that saves both into the
    value's `options`.
  - `help` page text.
- **Template** `templates/ahf-navigation-jump-menu.html.twig` → `<nav class="jump-menu"></nav>`.
- **JS** `js/advanced-header-field-jump-menu.js` — on DOMContentLoaded, finds
  `header[data-in-jump-menu]`, reads each heading's id + `data-short-title`/text, and appends a
  `<ul>` of `<a href="#id">` links into `#jump-menu`.
- **Service** `advanced_header_field_navigation.helper` → `AdvancedHeaderFieldNavigationHelper`
  (only holds the logger; no behavior used elsewhere).
- **No routes, no permissions, no config schema, no Drush.**

## How the two halves connect

The parent formatter emits `data-in-jump-menu` / `data-short-title` and an `id` on each opted-in
heading's `<header>` (see the parent's `preprocessThemeAdvancedHeaderField()`); this submodule's
block + JS consume those attributes. Parent docs:
[../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
