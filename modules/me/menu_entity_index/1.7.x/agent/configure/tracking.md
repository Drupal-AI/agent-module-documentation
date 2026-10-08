<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure which menus & entity types are tracked

Settings form: **Configuration → Search and metadata → Menu Entity Index**
(`/admin/config/search/menu_entity_index`, route `menu_entity_index.configure`).
Requires the `administer menu_entity_index` permission.

## Config object

Everything lives in the simple config object `menu_entity_index.configuration`
(schema type `config_object`):

```yaml
all_menus: false          # boolean: track every menu, ignoring the `menus` list
entity_types: {}          # sequence of entity type machine names, e.g. [node, taxonomy_term]
menus: {}                 # sequence of menu machine names, e.g. [main, footer]
```

Install default is `all_menus: false`, `entity_types: {}`, `menus: {}` (nothing tracked).
On the form the sequence values are stored keyed by their own value (e.g.
`menus: { main: main, footer: footer }`); reading with `drush cget` shows those keys.

Read / write from the CLI:

```bash
drush cget menu_entity_index.configuration
drush cset menu_entity_index.configuration entity_types.node node -y
drush cset menu_entity_index.configuration menus.main main -y
```

Only content entity types with a canonical/edit route are offered as trackable, and only
`menu_link_content`-capable menus appear as trackable menus (see
`Tracker::getAvailableEntityTypes()` / `getAvailableMenus()`).

## What saving does

Save the form (or call `Tracker::setConfiguration($form_values, $force_rebuild)`) and the
service diffs old vs new: removed menus/types have their index rows deleted, added ones
trigger a **Batch API** rescan (`menu_entity_index.batch.inc`) that walks the selected menus
and inserts index rows. After that first scan, `hook_entity_insert/update/delete` keep the
index current automatically — no cron needed.

## The "Menu Links" edit-form widget

For every tracked entity type the module exposes an extra form field (pseudo-field id
`menu_entity_index`, label **"Menu Links"**) via `hook_entity_extra_field_info()`. It is
hidden by default. Enable it per bundle on **Manage form display** (drag it out of the
*Disabled* region). On an entity's edit form it renders a collapsible
"Referenced by N menu links" table (menu, level, label, language). Its visibility is also
gated by the `view menu_entity_index form field` permission.

## Permissions (`menu_entity_index.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer menu_entity_index` | the settings form (restricted access) |
| `view menu_entity_index form field` | seeing the "Menu Links" table on edit forms |
