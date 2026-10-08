<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Replicate UI

Defined in `replicate_ui.permissions.yml`.

| Permission | Machine name | Gates |
|---|---|---|
| Replicate entities via UI | `replicate entities` | Whether a user may use the Replicate UI at all. **Not restrict-access flagged** — grant only to trusted roles. |

The admin **settings** form itself is gated by core's `administer site configuration`
(see `replicate_ui.routing.yml`), not by `replicate entities`.

## How access is actually decided per replicate route

Each `entity.{type}.replicate` route carries the custom requirement
`_replicate_access: TRUE`, checked by `ReplicateAccessChecker`
(service `replicate_ui.access_check`). A user may replicate an entity only if **all**
of these pass:

1. Core **create** access on that entity type (you must be allowed to create the kind
   of thing you are cloning).
2. Core **view/entity** access on the entity.
3. The `replicate entities` permission.

If `check_edit_access` is enabled in `replicate_ui.settings`, the route additionally
requires core **update (edit)** access on the original entity
(`_entity_access: {type}.update`).

So a typical editor role needs: `replicate entities` **plus** the normal
create/edit permissions for the target content type (e.g. `create article content`,
`edit any article content`). Granting `replicate entities` alone is not enough — the
Replicate tab/operation stays hidden without create access.

```bash
drush role:perm:add editor 'replicate entities'
drush role:perm:add editor 'create article content'
```
