<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission, defined in `file_rename.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Rename files | `rename files` | Access to the rename form/route, the file operation "Rename" link, and the widget "Rename" link. Marked `restrict access: true`. |

Access rules (both must hold to rename a given file):

- The account has the `rename files` permission.
- The file is **permanent** (`$file->isPermanent()`). Enforced by:
  - route requirement `_file_rename_access: '{file}'` →
    `Drupal\file_rename\Access\FileRenameAccessCheck` (allowed iff permission **and** permanent), and
  - `hook_entity_access()` for the `rename` operation on `file` entities (allowed iff permission).

The settings form at `file_rename.settings` is separately gated by core
`administer site configuration`.

```bash
drush role:perm:add editor 'rename files'
```
