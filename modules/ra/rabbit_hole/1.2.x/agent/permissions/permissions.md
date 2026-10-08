# Permissions

Permissions are **generated dynamically per supported entity type** by
`RabbitHolePermissionGenerator::permissions()` (wired through
`rabbit_hole.permissions.yml` → `permission_callbacks`). For every entity type registered by an
enabled entity plugin submodule you get two permissions:

| Permission | Gates |
|---|---|
| `rabbit hole administer <entity_type>` | See and edit the "Rabbit Hole settings" tab on that entity type's forms (change action, redirect, override). |
| `rabbit hole bypass <entity_type>` | Bypass the configured action and always view the real canonical page for that entity type. |

Example machine names (depend on which submodules are on): `rabbit hole administer node`,
`rabbit hole bypass node`, `rabbit hole administer media`, `rabbit hole bypass taxonomy_term`, …

The `administer` permission is checked in `hook_form_alter()` before adding the settings tab;
the `bypass` permission is checked by `BehaviorInvoker` before performing the action. Grant per
role, e.g.:

```
drush role:perm:add editor 'rabbit hole administer node'
```
