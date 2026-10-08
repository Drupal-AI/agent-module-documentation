# Configure entity limits

## Admin UI & routes

All under `/admin/structure/entity_limit`, permission `administer entity limit`
(`entity_limit.routing.yml`):

| Route | Path | Form |
|---|---|---|
| `entity.entity_limit.collection` | `/admin/structure/entity_limit` | list builder |
| `entity.entity_limit.add` | `/admin/structure/entity_limit/add` | `EntityLimitAddForm` |
| `entity.entity_limit.edit_form` | `/admin/structure/entity_limit/edit/{entity_limit}` | `EntityLimitAddForm` |
| `entity.entity_limit.manage_form` | `/admin/structure/entity_limit/manage/{entity_limit}` | `EntityLimitAddLimitForm` |
| `entity.entity_limit.delete_form` | `/admin/structure/entity_limit/delete/{entity_limit}` | `EntityLimitDeleteForm` |

Typical flow: **Add** picks the label, entity type, bundles, and plugin; **Manage Limits** fills the
`limits` rows (role/user → number).

Permissions (`entity_limit.permissions.yml`): `administer entity limit` (gates all routes above) and
`manage entity limits` (defined but not referenced by any route in this version).

## The `entity_limit` config entity

`config_prefix: entity_limit`, `admin_permission: administer entity limit`. Exported fields
(`config_export`): `id`, `label`, `weight`, `plugin`, `entity_type`, `entity_bundles`, `limits`, `uuid`.
Schema `entity_limit.entity_limit.*`; each `limits` row is
`entity_limit.limits.[%parent.plugin]` → `{id: string, limit: integer}` where `id` is a role ID or user
ID depending on the plugin.

Example config (`entity_limit.entity_limit.article_role_cap.yml`):

```yaml
id: article_role_cap
label: 'Article cap for editors'
weight: 0
plugin: role_limit
entity_type: node
entity_bundles:
  article: article
limits:
  - { id: editor, limit: 10 }
  - { id: contributor, limit: 3 }
uuid: ...
```

## Shipped limit plugins

- **Role Limit** (`role_limit`, priority 1): `limits` rows map a **role id** → max. For a user with
  multiple matching roles it takes the **highest** limit; any matching role with `-1` means unlimited.
  Administrator role is not selectable.
- **User Limit** (`user_limit`, priority 0): `limits` rows map a **user id** (entity-autocomplete,
  anonymous excluded) → max. Admin-role users are excluded.

`-1` is unlimited in both (`EntityLimitInspector::ENTITYLIMITNOLIMIT`).

## How a limit is chosen and enforced (`EntityLimitInspector`)

On `hook_entity_create_access()` for an entity type/bundle:
1. `getBundleLimits()` gathers every `entity_limit` config matching the entity type whose `entity_bundles`
   include the target bundle.
2. Applicable limits are grouped by config **weight**, then by plugin **priority**, then by resolved
   limit-count; `ksort` + `reset` pick the top weight then top priority group.
3. `compareLimits()` — if any applicable limit is unlimited (`-1`) → allow; else take the **max** limit in
   the group and call that plugin's `checkAccess($max_limit, $config)`.
4. `checkAccess()` counts the current user's existing entities of the target bundles owned by them (entity
   query on the entity type's `owner` + `bundle` keys, `accessCheck(FALSE)`). If `count >= limit` →
   `AccessResult::forbidden()`, otherwise `AccessResult::neutral()`.

Because it hooks create-access, hitting the cap disables the entity add form/route for that user.
