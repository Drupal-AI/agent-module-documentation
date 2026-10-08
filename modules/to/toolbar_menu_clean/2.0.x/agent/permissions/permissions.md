# Toolbar Menu Clean — permissions

Defined in `toolbar_menu_clean.permissions.yml`. All three are **opt-in**: a role that lacks
the permission has the corresponding toolbar element removed/hidden. Assign a permission to a
role to let that role keep the standard element.

| Permission | Default | Effect when the user LACKS it |
|---|---|---|
| `show administration menu in the toolbar` | not granted | The `administration` (Manage) toolbar item is wrapped with `#wrapper_attributes` class `visually-hidden`. Its `tray` is preserved under `$items['tray']`, and library `admin_toolbar/toolbar.tree` is re-attached so visible child menu items still expand. |
| `show shortcut menu in the toolbar` | not granted | The `shortcuts` toolbar item is `unset()` entirely. |
| `show edit button in the toolbar` | not granted | Only relevant if the user also has core `access contextual links`: the `contextual` (Edit) toolbar item is `unset()`. Without `access contextual links` there is no edit button to remove. |

## Behaviour notes

- Logic lives entirely in `toolbar_menu_clean_toolbar_alter(&$items)` — there is no config form.
- The administration item is **hidden with CSS (`visually-hidden`), not removed**, so its markup
  is still in the DOM; the shortcut and contextual items are actually removed from the render array.
- This controls **toolbar presentation only**. It does not revoke `access administration pages`,
  `access shortcuts`, or `access contextual links` — a user can still reach those routes directly.
  Treat it as UX tidying layered on top of Toolbar Menu, not as a security boundary.

## Grant with Drush (example)

```bash
# Let the "editor" role keep the standard Shortcuts tab but nothing else.
ddev drush role:perm:add editor 'show shortcut menu in the toolbar'
```
