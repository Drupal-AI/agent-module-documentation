# ECA Content Access — actions

Source: `src/Plugin/Action/GrantAccess.php` (main logic), `src/Plugin/Action/RevokeAccess.php`
(subclass). Two core action plugins, each `#[Action(type: 'node')]` +
`#[EcaAction(version_introduced: '1.0.0')]`, extending ECA's `ConfigurableActionBase`:

| id | label | class |
|---|---|---|
| `eca_content_access_grant_access` | Content access: grant access | `GrantAccess` |
| `eca_content_access_revoke_access` | Content access: revoke access | `RevokeAccess` (extends `GrantAccess`) |

Both operate on a **single node** and add (grant) or remove (revoke) one **role** from one
**operation** in that node's **per-node** Content Access settings, then rebuild that node's grant
records. `RevokeAccess` overrides only `updateSettings()` — everything else (form, `access()`,
`execute()`) is inherited from `GrantAccess`.

## Config keys

| Key | Widget (`buildConfigurationForm`) | Values / notes |
|---|---|---|
| `operation` | `select`, required | `view`, `view_own`, `update`, `update_own`, `delete`, `delete_own` (schema `Choice`). |
| `role` | `select`, required | A user role id; options from `Role::loadMultiple()`. Schema validates against `\Drupal\eca_user\Plugin\ECA\Condition\CurrentUserRole::getAllValidUserRoles`. |
| `follow_up` | `select`, required | `none`, `display_message`, `rebuild` — see [follow_up](#follow_up) below. |
| `clear_cache` | `checkbox` | If TRUE, deletes **all** cache bins after the change. |
| `object` | ECA base config | Token name holding the node entity the action runs on. |

Defaults (`defaultConfiguration`): `operation` `''`, `role` `''`, `follow_up` `'none'`,
`clear_cache` FALSE. Schema: `action.configuration.eca_content_access_grant_access` /
`action.configuration.eca_content_access_revoke_access`.

## access() — preconditions (`GrantAccess.php:147`)

`access()` returns `AccessResult::forbidden()` with a reason unless ALL of these hold, in which case it
returns `AccessResult::allowed()`:

1. `$object instanceof NodeInterface` and `$object->id()` is non-empty.
2. `content_access.settings:content_access_node_type` has an entry for the node's bundle.
3. That bundle's (unserialized) settings have `per_node` enabled.

So the action is only permitted on a node whose content type has **per-node** access enabled in
Content Access. This gates *whether the action may run*; it is not a check of the current user's
permission to change grants — the trust boundary is who may build/trigger the ECA model.

## execute() — the write path (`GrantAccess.php:172`)

1. If the passed `$entity` is NULL, return immediately.
2. Read the existing `settings` field from the `content_access` DB table for `nid = $entity->id()`.
3. If **no** row exists: take the bundle defaults from `content_access.settings` and drop `per_node`.
   If a row exists: `json_decode()` the stored per-node settings array.
4. `updateSettings($settings, $operation, $role)`:
   - **Grant** — appends `role` to `$settings[$operation]`; returns FALSE (no-op) if the role is
     already present.
   - **Revoke** — `array_diff()`s `role` out of `$settings[$operation]`; returns FALSE (no-op) if the
     role is not present.
5. Only on a real change: `MERGE` into the `content_access` table keyed by `nid` with
   `settings => json_encode($settings)`, then
   `entityTypeManager->getAccessControlHandler('node')->acquireGrants($entity)` followed by
   `node.grant_storage->write($entity, $grants)`. This re-derives and stores that node's grant records
   through content_access/core's own grant machinery (correct realm/gid). If the role was already
   in (Grant) / already out (Revoke) of the operation, nothing is written.
6. If `clear_cache` is TRUE: iterate `Cache::getBins()` and `deleteAll()` on each — a full cache flush.

### follow_up

- `none` — nothing further.
- `display_message` — shows a status message linking to the `node.configure_rebuild_confirm` route
  ("you may have to rebuild permissions…").
- `rebuild` — **does not actually rebuild.** Despite the option label ("Rebuild access directly"), the
  `execute()` code for this case just prints a message saying *"Direct rebuild not possible at this
  point"* and links to the same `node.configure_rebuild_confirm` route. Treat `rebuild` and
  `display_message` as equivalent in effect today; if grants must take effect broadly, trigger a node
  access rebuild yourself (the rebuild-confirm form, or `node_access_rebuild()`).

## Compatibility caveat — content_access ^2 storage

`access()` and the "no existing row" branch of `execute()` read per-content-type settings from
`\Drupal::config('content_access.settings')->get('content_access_node_type')`. In **content_access
2.x** that legacy config key is migrated into each node type's *third-party settings* and then removed
(`content_access_update_9202()` in `content_access.install`), so on a standard content_access ^2 site
that config value is empty. Consequence: `access()` precondition #2 fails and the action returns
**forbidden** (it fails **closed** — no grant is written), unless that legacy key still happens to be
populated. When building models, verify the action actually runs on your site (e.g. that the node's
grant records change) rather than assuming it did.

## Notes for building models
- These are `type: node` actions — the model's subject (`object` token) must resolve to a node entity.
- The change is per-node and per-(operation, role); it never edits content-type defaults or any other
  node.
- Each call only re-acquires grants for the one edited node — pre-existing nodes or bulk changes may
  still need a full `node_access_rebuild`.
- `clear_cache` wipes every cache bin; use sparingly (it is a site-wide flush, not scoped).
