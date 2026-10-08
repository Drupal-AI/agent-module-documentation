<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Static

- **`administer embedded content`** — defined in `embedded_content.permissions.yml`. Gates the button
  admin routes (collection/edit/delete at `/admin/config/content/embedded-content/button`).

> Note: the `embedded_content_button` entity annotation and the add-form route reference
> `administer embedded_content` (with an underscore), which is **not** defined in
> `permissions.yml` — only `administer embedded content` (spaces) exists. In practice manage the
> feature with the spaces permission (uid 1 bypasses all checks).

## Dynamic (per button)

`EmbeddedContentPermissions::getPermissions()` (a `permission_callbacks` entry) generates one
permission **per button** config entity:

```
use <button_id> embedded content button
```

e.g. `use default embedded content button`, titled "Use \<label\> embedded content button". Grant this
to the roles that should be allowed to use that button's dialog to insert components. This is checked
by the dialog form's access callback (`EmbeddedContentDialogForm::checkAccess`).

So a typical setup grants editors:
- `use <button> embedded content button` for each button they may use, and
- the relevant text format (which has the `embedded_content` filter + toolbar item enabled).

Rebuild permissions/caches after adding buttons (`drush cr`) so the new `use … embedded content
button` permission appears.
