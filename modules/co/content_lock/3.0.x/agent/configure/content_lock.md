# Configure — content_lock

![Content lock settings form](../../../../../../../screenshots/content_lock/3.0.x/settings.png)

Settings form route `content_lock.settings` at `/admin/config/content/content_lock`
(**Admin → Configuration → Content authoring → Content lock**), gated by the
`administer content lock` permission. All settings live in the config object
`content_lock.settings` (`provides_config_schema: true`).

## Config keys (`content_lock.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `verbose` | boolean | `true` | Show a message to the user when their edit locks the content (and when another user is blocked). |
| `types` | sequence | `{}` | Which entity types/bundles are lockable. Shape: `types.{entity_type_id}` is a list of bundle ids to lock, or `*` for all bundles. |
| `types_translation_lock` | sequence | `{}` | List of entity type ids that lock at translation level instead of entity level. Requires the Conflict module to enable via the UI. |
| `form_op_lock` | sequence | `{}` | Per entity type: `form_op_lock.{entity_type_id}.mode` (int) + `.values` (list of form operation ids). |
| `timeout` | integer (nullable) | `1800` | Seconds after which a lock is considered stale. The form edits this in **minutes** (default shows 30); clear the field to disable timeout-based breaking. |

Only content entity types with an **integer id** appear as lockable options in the form.

### Form operation lock modes

`form_op_lock.{type}.mode` uses `ContentLockInterface` constants:

- `0` `FORM_OP_MODE_DISABLED` — lock regardless of form operation (default).
- `1` `FORM_OP_MODE_ALLOWLIST` — only lock for the form operations listed in `.values`.
- `2` `FORM_OP_MODE_DENYLIST` — lock for every form operation **except** those in `.values`.

Available form operations come from the entity type's form handler classes (e.g. `default`,
`edit`, `delete`). Use allow/deny lists to let users edit *different* forms of the same entity
concurrently.

## What locking does at runtime

- `hook_form_alter` (`src/Hook/FormAlter.php`) locks an enabled entity when its edit form is
  opened (skips entity-creation forms with no id).
- The current lock holder gets an extra **unlock** button; other users get the whole form
  `#disabled` plus a message naming the owner.
- The lock is released by a submit handler when the owner saves (then redirects to the canonical
  view). The content-moderation form is made inaccessible to non-owners when locked.

## Drush / config examples

```bash
# Lock all bundles of the node entity type.
drush cset content_lock.settings types.node.0 '*' -y

# Enable verbose lock messages.
drush cset content_lock.settings verbose 1 -y

# Set the stale timeout to 3600 seconds (1 hour); the UI shows this as 60 minutes.
drush cset content_lock.settings timeout 3600 -y

# Disable timeout-based breaking (clear the value).
drush cset content_lock.settings timeout null -y
```

## Notes

- The bundled `content_lock_timeout` submodule (auto-releases stale locks after the timeout) is
  `lifecycle: deprecated` in 3.0.x — see https://www.drupal.org/node/3530741.
- Views integration ships an "Is locked" filter, a "Break link" field, a sort, and a permission
  access check for building editorial dashboards.
