# ADVA access-provider plugins

RAC does **not define** a plugin type. It supplies plugins of ADVA's `@AccessProvider` type
(manager `plugin.manager.adva.provider`; consumers via `plugin.manager.adva.consumer`). ADVA collects
each provider's grants and access records and enforces them through Drupal's entity/node access-grants
system (query-level, so they also apply to Views and search). All three providers declare operations
`view`, `update`, `delete`.

## `rac` — `RoleAccessProvider`

`src/Plugin/adva/AccessProvider/RoleAccessProvider.php`, extends ADVA `ReferenceAccessProvider`.

- `getTargetType()` → `"user_role"` — it acts on entity-reference fields whose target is a role.
- `getAuthorizedEntityIds($operation, $account)` → `$account->getRoles()`.

Meaning: a user is authorized for the realm of every role they hold; an entity is protected by the
roles referenced in its RAC-enabled field. If the user holds one of the referenced roles, ADVA grants
the operation the field is configured to confer (view by default; see below). Note the method ignores
`$operation` — the same set of roles is returned for view/update/delete, so which operations a
reference actually grants is decided by the per-field ADVA config, not here.

## `rac_typed` — `EntityTypeRoleAccessProvider`

`src/Plugin/adva/AccessProvider/EntityTypeRoleAccessProvider.php`, extends ADVA
`EntityTypeAccessProvider`. Grants access by **entity type / bundle configuration** rather than a
per-entity reference field.

- `getAccessGrants($operation, $account)` → one grant `"rac_typed_<role_id>" => [1]` for each of the
  user's roles.
- `buildOperationConfigForm()` adds a `roles` checkboxes element ("Grant *%op* to users with…") to
  ADVA's per-entity-type / default / bundle-override operation config.
- `getAccessRecordsFromConfig($config)` emits one record per configured role:
  `realm = "rac_typed_<role_id>"`, `gid = 1`, `grant_view/update/delete` set from which ops that role
  was ticked for.

So an admin picks, per bundle+operation, which roles get access; every entity of that bundle then
carries those role realms. A user holding a matching role gets the operation.

## `rac_relations` — `RoleAccessControlRelationsProvider`

`modules/rac_relations/src/Plugin/adva/AccessProvider/RoleAccessControlRelationsProvider.php`, extends
ADVA `ReferenceAccessProvider`. Like `rac`, but authorization is by **related** roles rather than the
user's own roles.

- `getTargetType()` → `"user_role"`.
- `getAuthorizedEntityIds($operation, $account)` → the ids of roles for which the account holds the
  `RAC_update_<role_id>` permission (`_rac_get_account_roles('update', $account)`). Those role
  relations are configured in the `rac_relations.settings` grid (see configure/settings.md).
- `getHelperMessage()` renders admin help linking to `rac_relations.settings`.

This lets, e.g., an "editor" role update content owned by a "member" role without the editor holding
the member role, by mapping editor→member in the relations grid.

## Adding your own provider

To add a role-based provider, implement an ADVA `@AccessProvider` plugin in
`src/Plugin/adva/AccessProvider/` (extend `ReferenceAccessProvider` for field-reference models or
`EntityTypeAccessProvider` for bundle-config models) and return grants/records from its methods. RAC
itself contributes no new base class beyond these ADVA ones.
