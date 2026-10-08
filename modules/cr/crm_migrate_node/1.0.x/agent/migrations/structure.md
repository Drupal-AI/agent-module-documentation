<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generated migration structure

All entities produced are standard `migrate_plus` Migration config entities (`migrate_plus.migration.*`),
so they run with normal Migrate tooling (`drush migrate:status/import/rollback`, Migrate UI). The
config-install file `config/install/migrate_plus.migration_group.crm_migrate_node.yml` defines the
group `crm_migrate_node` ("Node to CRM Contact", source_type Node). The module ships **no** config
schema of its own.

## Parent migration (one per mapping)
- **id:** `node_<node_type>_to_crm_<contact_type>` (from `AddForm::buildMigrationId()`).
- **source:** `content_entity:node`, `bundle: <node_type>` (Migrate Plus / core content-entity source).
- **destination:** `entity:crm_contact`.
- **process:** always `type` = `{plugin: default_value, default_value: <contact_type>}`, then one key
  per mapped field, produced by `EditForm::buildParentProcess()`. Whole Name/Address selections are
  expanded into per-component keys like `full_name/given` / `addresses/locality`
  (`expandWholeNameSourceToProcess()`, `compositeSourceToProcess()` — scalar `string` fields stay
  flat; other multi-value fields use `<field>/0/<prop>`). Contact-method fields are omitted here and
  handled as children.
- **tags/group:** `crm_migrate_node`. **migration_dependencies.required** lists active child ids.

## Child migrations (contact methods)
`CONTACT_METHOD_FIELDS` maps the contact reference fields to bundles+value keys:
`emails→email/email`, `telephones→telephone/telephone`, `addresses→address/address`.
`buildChildProcesses()` collects the mapped subfields for each; a child is only emitted when at
least one **non**-dependent field is set (`DEPENDENT_CONTACT_METHOD_FIELDS` = revision_* only).
`saveChildMigrations()` creates/updates (or deletes when unmapped) a migration:
- **id:** `<parent_id>__<bundle>` (`CHILD_SEPARATOR = __`).
- **source:** `content_entity:node`, same node bundle.
- **destination:** `entity:crm_contact_method`; **process** `type` = default_value `<bundle>` plus the
  mapped keys (address components use `<field>/0/<component>` so the source yields scalars).

The parent then references each child through `migration_lookup`:
`process[<field>] = {plugin: migration_lookup, migration: <child_id>, source: nid}`.

## Round-tripping the form
`processToMappingIndexedByDestination()` + `mergeChildProcessIntoMapping()` read the parent and child
`process` back into the flat `field__component` table shape (also tolerating a legacy
`entity_generate` format), so re-editing a saved migration repopulates every row and radio.

## Hooks (`Hook\MigrationHooks`, attribute-based)
- `#[Hook('migration_presave')]` — invalidates cache tag `crm_migrate_node.migration_tabs`
  (`MIGRATION_TABS_CACHE_TAG`) for any tagged migration, refreshing the dynamic tabs.
- `#[Hook('migration_delete')]` — invalidates the same tag and, for a deleted **parent**,
  cascade-deletes every `migrate_plus` migration whose id starts with `<parent_id>__`.

Only migrations carrying the `crm_migrate_node` tag are treated as owned by this module; child ids
(containing `__`) are excluded from the tab list via `EditForm::isChildMigration()`.
