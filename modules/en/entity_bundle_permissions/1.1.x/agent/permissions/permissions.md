# Permissions

## Static permission

| Permission | Gates |
|---|---|
| `administer entity_bundle_permissions` | Access to the settings form at `/admin/config/entity-bundle-permissions`. |

## Dynamically generated permissions

`DynamicPermissions::get()` (wired through `permission_callbacks` in
`entity_bundle_permissions.permissions.yml`) emits **one permission per bundle** of every
applicable content entity type:

```
entity_bundle_permissions access {entity_type_id} {bundle_id}
```

Examples: `entity_bundle_permissions access node article`,
`entity_bundle_permissions access media image`,
`entity_bundle_permissions access block_content basic`.

Each generated permission has title *"Access &lt;bundle&gt; &lt;entity type plural&gt;"* and a
description stating that granting it imbues **no additional access** — it only further restricts
those who lack it. Each also carries a config dependency on its bundle entity so the permission is
removed if the bundle is deleted.

## How they gate access (critical semantics)

`entity_bundle_permissions_entity_access()` runs on **every** entity operation. When the entity's
type applies (see [api/mechanism.md](../api/mechanism.md)):

- User **has** `entity_bundle_permissions access <type> <bundle>` → result `neutral` (other access
  rules decide as normal).
- User **lacks** it → result **`forbidden`** for that operation, with reason
  *"The '&lt;permission&gt;' permission is required."*

This applies to all operations (view, update, delete, …) because the hook ignores `$operation`.
Net effect: after enabling the module, a role sees a bundle **only if** it has been granted that
bundle's permission (or the type is in `ignored_entity_types`). `forbidden` from any access hook
wins over `allowed`, so this overrides permissive grants from other modules.

## Grant/revoke via drush

```bash
drush role:perm:add editor 'entity_bundle_permissions access node article'
drush role:perm:remove anonymous 'entity_bundle_permissions access node private_note'
```
