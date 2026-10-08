<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Domain Access Entity

Defined in `domain_entity.permissions.yml` (+ a dynamic `permission_callbacks`).

## Static permissions (both `restrict access: true`)

| Permission key | Gates |
|---|---|
| `access entities affiliate on assigned domains` | Lets a multi-domain editor access/filter entities across **all their assigned domains** (mainly admin paths), instead of only the current domain. Assign the user to domains in `admin/people` ("Affiliate editor options"). |
| `set domain access status for all entities` | Lets an editor edit/set the domain affiliation on **any** entity type. |

## Dynamic per-bundle permissions

`DomainEntityPermissions::permissions()` generates, for every **enabled** entity type × bundle,
three permissions mirroring Domain Access's node permissions:

- `create {bundle} {entity_type} content on assigned domains`
- `update {bundle} {entity_type} content on assigned domains`
- `delete {bundle} {entity_type} content on assigned domains`

e.g. `create article node content on assigned domains`. These only appear once the entity type
is domain-enabled (has the `domain_access` field storage).

## Grant example

```bash
drush role:perm:add domain_editor 'access entities affiliate on assigned domains'
drush role:perm:add domain_editor 'create tags taxonomy_term content on assigned domains'
```
