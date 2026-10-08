<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`ckeditor_templates.permissions.yml`:

| Machine name | Title | Gates |
|---|---|---|
| `administer ckeditor templates` | Administer CKEditor Templates | the whole `/admin/config/content/ckeditor-templates` UI — collection, add, edit, delete. Also the config entity's `admin_permission`. |
| `insert ckeditor templates` | Insert CKEditor Templates | the dialog route `ckeditor_templates.selector` (`…/template-selector/{editor}`) — i.e. actually using the Templates button. |

An editor therefore needs only `insert ckeditor templates` to use templates; managing the
library is a separate, stronger permission.

```bash
drush role:perm:add content_editor 'insert ckeditor templates'
drush role:perm:add site_builder   'administer ckeditor templates'
```

Note: the toolbar button is rendered by CKEditor regardless, but the modal request 403s
without `insert ckeditor templates`.
