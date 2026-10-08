<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Entity Index builds and maintains a database index that records which `menu_link_content` links reference which entities, so you can answer "what menus link to this node/term?" without scanning every menu.

---

The module keeps a dedicated `menu_entity_index` database table mapping each tracked menu link (the *host*) to the entity it points at (the *target*), storing menu name, level, host/parent/target entity type, bundle, id, uuid and langcode. You choose which menus and which content entity types to track on its settings form (`/admin/config/search/menu_entity_index`, config object `menu_entity_index.configuration` with keys `menus`, `entity_types`, `all_menus`); saving triggers a Batch API rescan of the selected menus. After the initial scan the `Tracker` service keeps the index current by reacting to `hook_entity_insert/update/delete` on hosts and targets. Two things consume the index: a **"Menu Links"** pseudo-field you can enable per bundle on *Manage form display*, which lists on an entity's edit form every menu link that references it (via `Tracker::getHostData()`), and **Views integration** for Menu Link Content (extra fields, filters, and a menu argument default). A Drush command `menu-entity-index:rebuild-index` (alias `mei-r`) rebuilds the index for all tracked menus or one named menu. Two permissions gate the settings form and the visibility of the edit-form widget. The module has no field types, plugin managers, or theme templates of its own.

---

- Show editors, on a node's edit form, every menu link that points to that node.
- Find all taxonomy terms that are referenced from the main navigation menu.
- Audit which menus link to a given entity before deleting or unpublishing it.
- Track only the menus and entity types you care about (e.g. main + footer menus, node + taxonomy_term).
- Track every menu at once by enabling the `all_menus` option.
- Build a View of Menu Link Content entities filtered by the menu they belong to.
- Use the tracked target entity type as a Views filter to list menu links pointing at nodes only.
- Provide a "referenced by N menu links" details section on entity edit forms via the pseudo-field.
- Rebuild the whole index after a bulk menu import with `drush menu-entity-index:rebuild-index`.
- Rebuild just one menu's index rows with `drush mei-r main`.
- Detect orphaned menu links whose target entity no longer exists.
- Report reverse menu references programmatically by calling `Tracker::getHostData($entity)`.
- Query the `menu_entity_index` table directly to power custom reports of menu-to-entity links.
- Keep the index automatically in sync as menu links are added, edited, or removed.
- Restrict who can configure tracking with the "Administer Menu Entity Index settings" permission.
- Restrict who can see the menu-links widget on edit forms with the "View entity edit form field" permission.
- Track menu references per language on a multilingual site (langcode and target_langcode are indexed).
- Surface a menu link's menu level so you can distinguish top-level from nested links.
- Give a menu argument default in Views that resolves the current menu context.
- Integrate menu-link reverse lookups into an editorial dashboard.
- Enforce content governance by checking menu references during content workflows.
- Support content migrations by re-scanning menus after `menu_link_content` entities are imported.
- Provide Menu Link Content Views data even when no other module supplies it.
- Help site builders understand navigation structure by exposing host/target relationships.
- Prevent broken navigation by listing which menu items must be updated when an entity URL changes.
