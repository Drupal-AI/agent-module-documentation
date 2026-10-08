<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `AccessControl` — the Commerce License type plugin

File: `src/Plugin/Commerce/LicenseType/AccessControl.php`
Class: `Drupal\commerce_license_access_control\Plugin\Commerce\LicenseType\AccessControl`
Extends `LicenseTypeBase`; implements `ExistingRightsFromConfigurationCheckingInterface`,
`GrantedEntityLockingInterface`, `ContainerFactoryPluginInterface`.

Plugin annotation: `@CommerceLicenseType(id = "commerce_license_access_control",
label = "Access Control", activation_order_state = "complete")`.

## Install / enable
```
composer require drupal/commerce_license_access_control
drush en commerce_license_access_control -y
```
Pulls in `acl` (`^2.0@beta`) and `commerce_license` (`^3.0`). No config to import; no settings route.
Use it by adding a **License** field to a product variation type and selecting the **Access Control**
license type (standard Commerce License setup), then configure it per the form below.

## Injected services (`create()`)
- `database` → `$connection` (queries the `acl` / `acl_node` tables directly)
- `entity_type.manager` → node storage + node access control handler
- `node.grant_storage` (`NodeGrantDatabaseStorageInterface`) → writes node_access rows
- `logger.channel.commerce_license_access_control`

## Configuration (`buildConfigurationForm` / `submitConfigurationForm`)
Stored plugin configuration keys (`defaultConfiguration()`): `acl_id`, `grant_view`, `grant_update`,
`grant_delete`, `acl_priority` (all default `NULL`). Also a bundle field `acl_id` (string, required —
`buildFieldDefinitions()`) is added to the license entity.

Form fields:
- `license_label` (textfield, required) — becomes the **ACL name** (`acl.name`).
- `licensed_entity` (`entity_autocomplete`, `#target_type: node`, `#tags: TRUE`, maxlength 4096) —
  one or more nodes (comma-separated) to protect.
- `grant_view` / `grant_update` / `grant_delete` (checkboxes) — which node ops the ACL grants.
- `acl_priority` (number, required, default 0) — ACL grant priority.
- `acl_id` (hidden) — the ACL id once created.

On submit:
1. If `acl_id` is empty → `acl_create_acl('commerce_license_access_control', $license_label)`; else
   `UPDATE {acl} SET name = :label WHERE acl_id = ...`.
2. `DELETE FROM {acl_node} WHERE acl_id = ...` (clears prior node mappings), then for each selected
   node `acl_node_add_acl($nid, $aclId, grant_view, grant_update, grant_delete, acl_priority)`.
3. Saves `grant_*` and `acl_priority` back to plugin configuration.

All DB access uses parameterized queries / the query builder (`:acl_id` placeholders,
`->condition()`), and the form is a standard FormAPI form gated by Commerce product admin permissions
(CSRF token handled by FormAPI). No custom routes.

## Lifecycle (called by Commerce License state machine)
- **`grantLicense(LicenseInterface $license)`** — runs when the license activates. If the license has
  no `acl_id` yet (manual admin activation), it hydrates config from the purchased entity's license
  type (`setValuesFromPlugin`). Adds the owner to the ACL (`acl_add_user($acl_id, $ownerUid)`). If the
  owner is **anonymous**, it logs a notice and returns **without** writing node grants (anonymous is
  never granted content access). Otherwise, for each node returned by `getLicensedNodes($acl_id)`, it
  re-acquires grants (`getAccessControlHandler('node')->acquireGrants($node)`) and writes them
  (`nodeGrantStorage->write($node, $grants)`).
- **`revokeLicense(LicenseInterface $license)`** — removes the owner from the ACL
  (`acl_remove_user`) and rewrites node grants for the licensed nodes, so access disappears on
  expiry/cancel.
- **`checkUserHasExistingRights(UserInterface $user)`** — returns
  `ExistingRightsResult::rightsExistIf(acl_has_user($acl_id, $uid), ...)`, so a user who already has
  access can't buy the same license twice.
- **`buildLabel()`** — the ACL name via `getLicenseLabel($acl_id)`, else "Access Control License".

Helpers: `getLicensedNodes($acl_id)` = `SELECT nid FROM {acl_node} WHERE acl_id = :acl_id` then loads
each node; `getLicenseLabel($acl_id)` = `SELECT name FROM {acl} WHERE acl_id = :acl_id`.

## Enforcement model (important for operators)
This module does **not** implement `hook_node_access`. Enforcement is delegated to the **ACL** module
plus **core node grants** (deny-by-default per node once any grant record exists). ACL's
`acl_node_access_records()` reads the module's `commerce_license_access_control_enabled()` static
(set `FALSE` in `hook_uninstall` so grants aren't re-emitted while uninstalling).

Consequences to keep in mind:
- Node grants are (re)written only during `grantLicense`/`revokeLicense` (per licensed node) — not at
  the moment you edit the license configuration. After changing which nodes a license protects (or the
  grant checkboxes/priority), **rebuild node access permissions** (`drush php:eval
  'node_access_rebuild();'` or the admin "Rebuild permissions" action) so the `node_access` table
  matches the ACL/node mapping.
- Node grants govern the **node** (and its canonical/listing access). Confirm that attached private
  files and non-page delivery paths (JSON:API, REST, other view modes) are covered by your own file /
  entity access configuration — that is a site-integration responsibility, not something this plugin
  enforces.
