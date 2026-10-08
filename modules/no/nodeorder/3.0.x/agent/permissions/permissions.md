<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Order permissions

Two permissions (`nodeorder.permissions.yml`):

| Permission | Gates |
|---|---|
| `order nodes within categories` | Access the per-term ordering page `nodeorder.admin_order` (`/taxonomy/term/{tid}/order`) and save a new node order. Also required for the term's **Order** operation/tab to be usable. |
| `administer nodeorder` | Access the settings form `nodeorder.admin` (`/admin/config/content/nodeorder`) where you choose orderable vocabularies and display options. |

Notes:

- Neither permission is marked `restrict access`, but *administer nodeorder* effectively controls
  which vocabularies become orderable site-wide, so treat it as an administrative permission.
- Access to the ordering page additionally requires a custom access check
  (`NodeOrderAccess::adminOrder`): the vocabulary must be orderable **and** the `taxonomy_index.weight`
  column must exist (it is added on install).

Grant example:

```bash
drush role:perm:add editor 'order nodes within categories'
drush role:perm:add administrator 'administer nodeorder'
```
