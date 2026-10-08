<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drag-select the permissions grid (permissions_dragcheck)

The whole module is ~40 lines of PHP in `permissions_dragcheck.module` plus ~15 lines of JS in
`js/init.js`. It attaches a jQuery drag-selection plugin to the **core** permissions form. There is
no config, no route, no permission, no service, no plugin, and no PHP that reads or writes anything —
the permission save is 100% core's `user_admin_permissions` submit handler.

## Install / enable

1. Enable the module: `drush en permissions_dragcheck -y` (or via the UI). No Drupal module
   dependencies are declared in `permissions_dragcheck.info.yml`.
2. Provide the external front-end library. The drag behavior comes from scarlac's third-party
   **`drag-check-js`** plugin, which is *not* bundled — the site admin must place it at
   `/libraries/drag-check-js/` so the browser can load
   `/libraries/drag-check-js/dist/jquery.dragcheck.js`. README shows a Composer `type: package`
   recipe (`scarlac/drag-check-js`, e.g. v2.0.2) or you can drop the files in manually.
3. Without that library the module still enables cleanly; the page just has no drag behavior because
   the plugin's `.dragCheck()` method is undefined.

## How it attaches (source)

`permissions_dragcheck_form_user_admin_permissions_alter()` — a `hook_form_FORM_ID_alter()` keyed to
the core form id `user_admin_permissions` (route `user.admin_permissions`, path
`admin/people/permissions`) — attaches two libraries and does nothing else:

```php
function permissions_dragcheck_form_user_admin_permissions_alter(&$form, &$form_state) {
  // Add the library:
  $form['#attached']['library'][] = 'permissions_dragcheck/drag-check-js';
  // Init:
  $form['#attached']['library'][] = 'permissions_dragcheck/permissions-drag-check';
}
```

A companion `permissions_dragcheck_help()` (`hook_help()`) prints one static, `t()`-wrapped sentence
on the `user.admin_permissions` route. Both hooks fire only on that one core route.

## The two libraries (`permissions_dragcheck.libraries.yml`)

- `permissions_dragcheck/drag-check-js` — loads `/libraries/drag-check-js/dist/jquery.dragcheck.js`
  (the external plugin, declared `remote: github.com/scarlac/drag-check-js`, license CC BY 4.0) and
  `js/init.js`; depends on `core/jquery`.
- `permissions_dragcheck/permissions-drag-check` — loads `js/init.js`; depends on `core/jquery`.
  (`js/init.js` is thus referenced by both; harmless — the aggregator de-dupes.)

## The behavior (`js/init.js`)

`Drupal.behaviors.permissions_dragcheck.attach()`:

```js
$('table#permissions :checkbox:not([readonly],[disabled])', context).change(function (e) {
  $(this).closest('td').css('background-color', $(this).is(':checked') ? '#73B355' : '#FFFACD');
}).dragCheck();
```

- Scopes to `table#permissions` checkboxes only, skipping `[readonly]`/`[disabled]` boxes (so core's
  locked/authenticated-user checkboxes are left alone).
- On each `change`, tints the enclosing `<td>` green `#73B355` when checked, lemon `#FFFACD` when
  unchecked — at-a-glance state feedback.
- `.dragCheck()` (from the external plugin) enables click-and-drag / range selection across a run of
  checkboxes so many can be toggled in one gesture.

## Operate it

Open `admin/people/permissions` (requires the core **`administer permissions`** permission — enforced
by core, unchanged by this module), then click and drag across a column or run of checkboxes to tick
them, and press **Save permissions** as usual. Pairs with the `pfm` ("Permissions filtered by
modules") contrib module, which adds a per-module filter to the same grid.
