Content Lock applies a pessimistic locking strategy: it exclusively locks a content entity while one user edits it, so no one else can save concurrent changes and cause an edit conflict.

---

Content Lock protects the edit forms of content entities you choose. When a user opens an enabled entity's edit form, a `hook_form_alter` implementation locks the entity (writing a row to the `content_lock` table via the `content_lock` service) and adds an "unlock" button for that user; the lock is released automatically when they submit the form or is released by a submit handler. If a *different* user opens the same edit form while it is locked, the form is fully disabled (`#disabled`) and they see a message naming the lock owner. Which entity types are lockable is configured at **Admin → Configuration → Content authoring → Content lock** (`/admin/config/content/content_lock`, route `content_lock.settings`), where you enable per entity type, restrict to specific bundles, optionally lock at translation level (requires the Conflict module), and optionally limit locking to specific form operations via allowlist/denylist modes. A "Break content lock" permission lets privileged users forcibly release someone else's lock through dynamically generated `content_lock.break_lock.{entity_type_id}` routes, and Views integration ships a "Is locked" filter, a "Break link" field, a sort, and an access check. Developers can drive locks directly through the `content_lock` service (`locking()`, `release()`, `fetchLock()`, `releaseExpiredLocks()`, etc.), react to `ContentLockLockedEvent` / `ContentLockReleaseEvent`, and veto lockability with `hook_content_lock_entity_lockable()`. A configurable timeout (stored in seconds, edited in minutes; default 30 minutes) records when locks go stale, and the bundled `content_lock_timeout` submodule (now deprecated) auto-releases forgotten locks. The module requires no dependencies beyond Drupal core.

---

- Stop two editors from overwriting each other's changes on a busy node.
- Lock a node's edit form for the first editor so a second editor gets a read-only, disabled form.
- Show a message naming who currently holds the lock on a piece of content.
- Enable content locking only for the `node` entity type and leave media/users unlocked.
- Restrict locking to specific bundles (e.g. only the `article` and `page` content types).
- Give trusted staff a "Break content lock" permission to release a colleague's forgotten lock.
- Break a stale lock from the entity's break-lock route so editing can resume.
- Turn on the "Verbose" option to notify users when their edit locks the content.
- Lock at translation level so different users can edit different translations concurrently (with Conflict installed).
- Limit locking to certain form operations (e.g. only the default edit form, not a delete or layout form) using allowlist mode.
- Exclude specific form operations from locking using denylist mode.
- Automatically release a lock when the editor saves the form or navigates away.
- Set a lock timeout (in minutes) so abandoned locks are considered stale.
- Auto-release forgotten locks after the timeout via the deprecated `content_lock_timeout` submodule.
- Programmatically lock an entity for a user with the `content_lock` service `locking()` method.
- Programmatically release a lock (or all of a user's locks) from custom code.
- Release all expired locks in bulk with `releaseExpiredLocks()`.
- Check whether an entity is currently locked by a given user with `isLockedBy()`.
- Veto lockability for specific entities by implementing `hook_content_lock_entity_lockable()`.
- React when content is locked or unlocked by subscribing to `ContentLockLockedEvent` / `ContentLockReleaseEvent`.
- Add an "Is locked" filter column to an editorial Views listing.
- Add a "Break link" field to a Views admin dashboard to unlock content inline.
- Guard the content-moderation form so a locked entity's moderation form is inaccessible to other users.
- Prevent edit-conflict "the content has been modified" errors on high-traffic editorial teams.
- Deploy content-lock configuration (enabled entity types, timeout) between environments as config.
- Break another user's lock from a bulk Views operation using the Break Lock action.
