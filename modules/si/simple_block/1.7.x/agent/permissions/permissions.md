<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `simple_block.permissions.yml`:

| Permission | Gates |
|---|---|
| `update simple blocks` | Editing an existing simple block (`entity.simple_block.edit_form`, access requirement `simple_block.update`). |
| `clone simple blocks` | Cloning a simple block (`entity.simple_block.clone_form`, `simple_block.clone`). |
| `delete simple blocks` | Deleting a simple block (`entity.simple_block.delete_form`, `simple_block.delete`). |

These map to entity operations via `SimpleBlockAccessControlHandler`.

## Not covered by these permissions

- **Adding** a block (`simple_block.form_add`) and **listing** the collection
  (`entity.simple_block.collection`) require core's **`administer blocks`** (the routes use
  `_permission: 'administer blocks'`, not a dedicated create permission).
- **Placing** a `simple_block:<id>` block in a region is standard block administration
  (`administer blocks`).

## Grant examples

```bash
# let an editor edit (but not add/delete) simple blocks
drush role:perm:add content_editor 'update simple blocks'

# full lifecycle for a manager (add/list still needs administer blocks)
drush role:perm:add site_manager 'update simple blocks,clone simple blocks,delete simple blocks,administer blocks'
```

So to give someone the ability to create new simple blocks you must grant `administer blocks`;
the three module permissions only refine edit/clone/delete of existing ones.
