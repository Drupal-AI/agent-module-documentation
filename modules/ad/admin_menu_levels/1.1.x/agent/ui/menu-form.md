<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The menu-edit controls and client-side filter

## Install & enable

```bash
composer require drupal/admin_menu_levels
drush en admin_menu_levels -y
```

No dependencies (composer.json declares none), no configuration. Enabling is enough; the controls
appear on every menu edit page.

## The form_alter (PHP — the module's only hook)

`admin_menu_levels_form_menu_edit_form_alter(array &$form, FormStateInterface &$form_state, string
$form_id)` in `admin_menu_levels.module` (a `hook_form_FORM_ID_alter` targeting the core
`menu_edit_form`, i.e. `/admin/structure/menu/manage/{menu}`):

- adds `field_levels` — `#type => select`, options `1 => One, 2 => Two, 3 => Three`,
  `#empty_option => 'All'`, `#empty_value => 'all'`, `#weight => -1`;
- adds `field_enabled_toggle` — `#type => checkbox`, title "Hide disabled items", `#weight => -1`;
- re-weights core elements so they sort sensibly: `label` -20, `id` -15, `description` -10,
  `langcode` -5;
- `$form['#attached']['library'][] = 'admin_menu_levels/admin_menu_levels';`.

There is **no submit handler**: `field_levels`/`field_enabled_toggle` are never read in PHP and never
saved — they exist purely to drive the JavaScript on the current page.

## The library

`admin_menu_levels.libraries.yml`:

```yaml
admin_menu_levels:
  js:
    js/admin-menu-levels.js: { attributes: { defer: true } }
  dependencies:
    - core/drupal
    - core/jquery
```

## The behavior (JS)

`js/admin-menu-levels.es6.js` (source; `js/admin-menu-levels.js` is the compiled build)
defines `Drupal.behaviors.adminMenuLevels`:

1. For each `#menu-edit-form`, tags every `#menu-overview tbody > tr` with a depth class by counting
   its `> td .indentation` cells: 0 → `admin-menu-levels--1`, 1 → `--2`, 2 → `--3`, deeper →
   `admin-menu-levels`.
2. Reads the select value (`#edit-field-levels`) and the checkbox state (`#edit-field-enabled-toggle`).
3. `tr_toggle_choice(choice)` first hides all rows, then shows the subset for the chosen depth
   (inclusive: "Two" shows levels 1 and 2), and when "Hide disabled items" is checked it additionally
   restricts to rows with core's `.menu-enabled` class (hiding `.menu-disabled`).
4. Re-runs on `change` of either control.

All filtering is presentational and client-side; the stored menu is unchanged.

## Notes

- Depth is inclusive — selecting "Three" shows levels 1, 2 and 3.
- Since 1.0.1 the JS reads the select with `.val()` (not `textContent`); 1.1.0 adds Drupal 11
  support and lint cleanup (see CHANGELOG.md).
- Works on any menu edit page; no per-menu configuration.
