# Permissions

Defined in `feeds_tamper.permissions.yml` (+ dynamic callback
`FeedsTamperPermissions::feedTypeTamperPermissions`).

| Permission | Gates |
|---|---|
| `administer feeds_tamper` | Create, edit and delete tamper plugins for **any** feed type. Marked `restrict access` (trusted admins). |
| `tamper {feed_type_id}` | Per-feed-type permission, generated for each Feeds feed type. Lets a user manage tampers for just that one feed type. |

The **Tamper** entity operation link and the tamper forms grant access if the user has
`administer feeds_tamper` **or** the matching per-feed-type `tamper {id}` permission
(see `feeds_tamper_entity_operation()` and each form's `checkAccess`).
