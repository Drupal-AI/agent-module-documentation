# Permissions

Defined in `moderated_content_bulk_publish.permissions.yml`. Each bulk action checks its own
permission at execute time (via `\Drupal::currentUser()->hasPermission(...)`), so you can hand
editors a subset of the operations.

| Permission | Gates |
|---|---|
| `moderated content bulk publish` | Running the "Publish latest revision" bulk action |
| `moderated content bulk unpublish` | Running the "Unpublish current revision" bulk action |
| `moderated content bulk archive` | Running the "Archive current revision" bulk action |
| `moderated content bulk pin content` | Running the "Pin Content" bulk action |
| `moderated content bulk unpin content` | Running the "Unpin content" bulk action |

The settings form itself is gated separately by core's `administer site configuration`
(see the routing file), not by any of the above.

```
drush role:perm:add editor 'moderated content bulk publish'
drush role:perm:add editor 'moderated content bulk unpublish'
```

Entity-level access is still enforced: an action only runs if the user also passes `update`
access on the entity and edit access on its `moderation_state` (moderated entities) or
`status` field.
