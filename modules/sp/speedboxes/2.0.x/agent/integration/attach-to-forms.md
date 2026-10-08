<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speedboxes — attaching the drag-select behaviour to a form

Speedboxes is a pure front-end asset library. It ships no routes, services, permissions,
config or plugins. All you can do server-side is decide **which forms get the library**; all
behaviour lives in `js/speedboxes.js` and `css/speedboxes.css`.

## Where it already activates

`src/Hook/FormAlter.php` attaches the library to exactly two forms via attribute hooks:

```php
#[Hook('form_user_admin_permissions_alter')]   // core /admin/people/permissions
#[Hook('form_group_admin_permissions_alter')]  // Group module group permissions form
public function formAlterHook(array &$form, FormStateInterface $form_state): void {
  $form['#attached']['library'][] = 'speedboxes/speedboxes';
}
```

The `group_admin_permissions` alter is harmless when the Group module is absent — the form ID
simply never fires.

## Add it to another checkbox-heavy form

In your own module, implement the matching form-alter and attach the library:

```php
#[Hook('form_MY_FORM_ID_alter')]
public function alter(array &$form, FormStateInterface $form_state): void {
  $form['#attached']['library'][] = 'speedboxes/speedboxes';
}
```

`MY_FORM_ID` is the form's build id (e.g. `taxonomy_overview_terms`). No other wiring is
needed; the JS binds globally to `<body>` on any page where the library loads.

## Library

`speedboxes.libraries.yml` → `speedboxes/speedboxes`:
- CSS: `css/speedboxes.css` (theme group)
- JS: `js/speedboxes.js`
- Dependencies: `core/drupal`, `core/jquery`

## Runtime behaviour (js/speedboxes.js)

`Drupal.behaviors.speedboxes.attach()` binds `mousedown` / `mousemove scroll` /
`mouseup mouseleave` on `<body>`. Drag draws `#speedboxes-selection`; on release it collects
every `input:checkbox:enabled:visible` whose `offset()` falls inside the drag rectangle
(`updateSelectedCheckboxes`) and shows the `#speedboxes-popup` toolbar
(`createEditingPopup`). Toolbar actions, keyed by the `speedboxes-action` data attribute:

- `check_all` → `.attr('checked','checked')` on the selection
- `uncheck_all` → `.removeAttr('checked')`
- `reverse` → toggles each box

`Drupal.speedboxes.config` holds `ignore_elements: ['input','select']` (drags starting on
those tags are ignored) and the localized labels `localization.{check_all,uncheck_all,reverse}`
(run through `Drupal.t()`).

## Important: toggling is DOM-only

The toolbar changes checkbox state **in the browser only**. Nothing is persisted until the
underlying form is submitted through normal Drupal FAPI — which keeps its own access check and
CSRF token. Speedboxes adds no server-side write path of its own.

## CSS hooks

`speedboxes-selection`, `speedboxes-selected`, `speedboxes-popup`, `speedboxes-action`,
`speedboxes-action-check-all`, `speedboxes-action-uncheck-all`, `speedboxes-action-reverse`,
`speedboxes-active-action`. Override in your theme to restyle the marquee and toolbar.
