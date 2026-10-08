# Permissions — content_lock

Defined in `content_lock.permissions.yml` (`provides_permissions: true`).

| Permission | Gates |
|---|---|
| `administer content lock` | Access to the settings form (`content_lock.settings`, `/admin/config/content/content_lock`) — choosing which entity types/bundles are locked, translation/form-op lock modes, verbose, and timeout. |
| `break content lock` | Forcibly releasing another user's lock via the break-lock forms. |

## Break-lock access

Break-lock routes are generated dynamically per lockable content entity type as
`content_lock.break_lock.{entity_type_id}` at
`/admin/lock/break/{entity_type_id}/{entity}/{langcode}/{form_op}`
(`src/Routing/ContentLockRoutes.php`, `src/Form/EntityBreakLockForm.php`).

Access to break a lock (`EntityBreakLockForm::access`) is granted if the account **either**:

- has the `break content lock` permission, **or**
- already holds the lock itself (`isLockedBy()`) — so a user can always release their own lock.

Confirming the form releases the lock and reports "Unlocked. Anyone can now edit this content"
(or "…this content translation" when translation lock is on), then redirects to the destination
or the entity's canonical page.

The Views "Break link" field and the Break Lock action plugin expose the same break-lock flow in
listings and bulk operations, and honor the `break content lock` permission.
