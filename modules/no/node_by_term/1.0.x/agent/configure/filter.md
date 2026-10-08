<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Node by Term filter

Enable the module, then visit `/node-list` (linked as the module's configure action).

1. Choose a **Vocabulary**; its terms load into the **Term** select via AJAX.
2. Optionally choose a **Term** and a **Content Type**.
3. Submit — you are redirected to `/node-list?vocab=<vid>&t_id=<tid>&cont_type=<type>` and the paged table is built from those query parameters.
4. Use the pager (2 rows/page) and the per-row **Edit** / **View** links.

Notes for agents:
- Access requires the `administer node by term` permission, which the module never declares; grant it only if you first add a matching permission, otherwise only user 1 can reach the pages.
- The result table lists unpublished nodes as well as published ones — treat the page as admin-only.
- `NodeListController::nodelist()` reads `vocab` / `t_id` / `cont_type` from the request query and queries `taxonomy_index` joined to `node_field_data`; there is no settings/config to store.
