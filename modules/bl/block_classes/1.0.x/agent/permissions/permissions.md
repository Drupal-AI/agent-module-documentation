<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`block_classes.permissions.yml` defines exactly one permission:

| Machine name | Title |
|---|---|
| `administer block css classes` | Administer block css classes |

It is checked in `block_classes_form_block_form_alter()`:

```php
if (\Drupal::currentUser()->hasPermission('administer block css classes')) { … }
```

Effect:

- **Without** it the three class textfields are simply **not added** to the block configure form.
  Any classes already stored keep rendering — the permission gates *editing*, not *output*.
- It is **not** restricted-access, and it does not imply `administer blocks`; a user still needs
  core's `administer blocks` to reach `/admin/structure/block/manage/<id>` at all.

Grant it with:

```bash
drush role:perm:add site_builder 'administer block css classes'
```
