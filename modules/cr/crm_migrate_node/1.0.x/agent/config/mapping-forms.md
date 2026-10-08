<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forms, routes & permission

## Install / enable
`drush en crm_migrate_node -y`. Requires `crm` and `migrate_plus` enabled. The admin menu link
`crm_migrate_node.mapping_add` ("Node to CRM Migration") is placed under `crm.admin_config`
(Configuration → CRM). Grant `administer crm_migrate_node` (declared in
`crm_migrate_node.permissions.yml`, `restrict access: true`) — it guards **both** routes.

## Add form — `Form\AddForm` (`crm_migrate_node.mapping_add`)
Path `/admin/config/crm/node-migration/add`, form id `crm_migrate_node_mapping_add`. Two required
selects: **Node content type** (`node` bundles) and **CRM contact type** (`crm_contact` bundles;
empty if the `crm_contact` entity type is undefined). On submit it builds a migration id via
`buildMigrationId()` (`node_<type>_to_crm_<contact>`, lowercased, non-`[a-z0-9_]` collapsed to `_`),
`validateForm()` rejects a duplicate id, then `submitForm()` calls `Migration::create([...])->save()`
with:
- `migration_group` / `migration_tags` = `crm_migrate_node` (`EditForm::MIGRATION_GROUP` / `MIGRATION_TAG`).
- `source` = `{plugin: content_entity:node, bundle: <node_type>}`.
- `process` = `type` (default_value = contact type), plus `status`, `created`, `changed` passthrough.
- `destination` = `{plugin: entity:crm_contact}`.

It then redirects to the edit form. Node and contact types are **not** editable afterward.

## Edit form — `Form\EditForm` (`crm_migrate_node.mapping_edit`)
Path `/admin/config/crm/node-migration/{migration_id}` (string param), form id
`crm_migrate_node_mapping`. `buildForm()` loads the migration, aborts (redirect to add) unless it
carries the module tag (`migrationHasOurTag()`). Fields: **Migration label** (textfield) and a
`#type => table` mapping built by `buildFieldMappingTable()`.

### Mapping table
Left column = CRM contact field (from `getContactFieldsForMapping()`, which skips id/type/revision*/
age/relationship_statistics and, when `full_name` exists, the plain `name`). Right column = a select
of node fields (`getNodeFieldOptions()`), grouped and ordered by `GROUP_ORDER`
(name, addresses, telephones, emails). Special handling:
- **Name** (`name` field type) and **Addresses** parent rows use `#type => radios` with an Ajax
  callback `ajaxFieldMappingWrapper` (wrapper `field-mapping-wrapper`) plus a "Map subfields
  individually" option (`NAME_MAP_SUBFIELDS = __sub_components`). Choosing it reveals per-component
  rows; otherwise a whole node Name/Address field is expanded to all components on save.
- **status** offers fixed default values Active/Inactive (`CONTACT_STATUS_DEFAULT_OPTIONS`).
- Contact-method **detail** rows offer `crm_method_detail` entities filtered by bundle
  (`getMethodDetailOptions()`), stored as `default_value:<id>` (`METHOD_DETAIL_DEFAULT_VALUE_PREFIX`).

`validateForm()` requires at least one non-`type` mapping. `submitForm()` calls
`buildMigrationSet()` + `saveChildMigrations()` (see [migrations/structure.md](../migrations/structure.md)),
persists the parent `process`/`label`/tags/group/dependencies, and stores an internal flag
`_crm_migrate_node_addresses_map_subfields` inside the migration `source` (ignored by source plugins,
used to restore the radio state). `__wakeup()` re-injects services on Ajax rebuilds.

## Dynamic tabs
`Hook\MenuLocalTasksHooks::menuLocalTasksAlter()` renders one "Add migration" primary tab plus one
tab per tagged parent migration on both routes (base task declared in `crm_migrate_node.links.task.yml`).
