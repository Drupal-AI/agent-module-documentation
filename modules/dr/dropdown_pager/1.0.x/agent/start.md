<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dropdown Pager (dropdown_pager) — agent index

A single **Views pager plugin** that renders View pagination as a compact, accessible dropdown
button (current position + First/Prev/Next/Last, optional numeric search) instead of a row of
numbered links. Package `Views`. Depends only on core **`views`**. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Version 1.0.2 (version dir 1.0.x). No routes, no permissions, no config
schema, no Drush, no settings page.

- **The pager plugin, its options, the hook class, template and JS/CSS library, and how to select
  it on a View** → [plugins/dropdown-pager.md](plugins/dropdown-pager.md)

## What it actually provides

- One plugin: `Dropdown` (id **`dropdown`**, label *"Paged output, dropdown pager"*) in
  `src/Plugin/views/pager/Dropdown.php`, extending core `Drupal\views\Plugin\views\pager\SqlBase`,
  `#[ViewsPager]`, `theme: "views_dropdown_pager"`. It is a pager plugin **instance**, not a new
  plugin type.
- One hook class: `DropdownPagerHook` (`src/Hook/DropdownPagerHook.php`), registered as an
  autowired service in `dropdown_pager.services.yml`, implementing `hook_theme()` (declares the
  `views_dropdown_pager` theme, template `views-dropdown-pager`) and
  `template_preprocess_views_dropdown_pager()` (builds the pager item render arrays via the core
  **`pager.manager`** service). `dropdown_pager.module` only forwards these via `#[LegacyHook]`.
- Template `templates/views-dropdown-pager.html.twig` (themeable, `views_dropdown_pager`).
- Library `dropdown_pager/dropdown_pager` (`dropdown_pager.libraries.yml`): `css/dropdown-pager.css`
  + `js/dropdown-pager.js` (`Drupal.behaviors.dropdownPager`), deps `core/drupal`, `core/jquery`,
  `core/drupal.ajax`, `core/once`.

## How to use it

Edit a View → **Pager** settings → choose **"Paged output, dropdown pager"** → set options
(items per page, `quantity`, text templates, search) → Save. No admin config page; nothing else
to enable. See the solution doc for every option key and the render/preprocess flow.

## Notes

- Only affects pager **presentation**; the View's query, results and access are unchanged.
- All configurable text (button/label/page-link templates, tag labels, title, search placeholder)
  is **admin-set** (requires Views admin) and is escaped on output — see the solution doc.
