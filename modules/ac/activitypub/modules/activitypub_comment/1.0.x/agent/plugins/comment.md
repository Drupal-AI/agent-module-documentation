<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Comment — reply→comment plugin

## Enable
`drush en activitypub_comment` (pulls `comment`). Then enable the shipped `inbox_reply` type at
`/admin/config/services/activitypub/activitypub-type` (imported from
`config/optional/activitypub.activitypub_type.inbox_reply.yml`). Ensure the target node type has a
comment field that is **open** and (if federating out) an `activitypub_dynamic_types` type mapping the
node to a `Note`.

## The `activitypub_comment` plugin (`src/Plugin/activitypub/type/Comment.php`)
Configuration (defaults, all on the type edit form):
- `comment_type` = `comment` (comment bundle to create)
- `comment_body_field` = `comment_body`
- `activity_reference_field` = `activitypub_activity` (entity-ref on the comment → the activity)
- `node_comment_field` = `comment` (the node's comment field name)
- `comment_status` = TRUE (created comment published state)
- `comment_filter_format` = `restricted_html` (text format applied to the remote body)

## Inbound reply → comment
1. `onActivityPostSave($activity, $update=FALSE)`: for an inbox `Create` that has a `reply` value, if
   the `inbox_reply` type is enabled it sets `$activity->config_id = 'inbox_reply'` and
   `processClient->createQueueItem($activity)`.
2. `handleInboxQueue` later calls `Activity::doInboxProcess()` → `Comment::doInboxProcess()` →
   `handleCommentCreation($activity)`:
   - `Utility::getEntityFromUrl($activity->getReply())` resolves the local target. If it's a
     `CommentInterface` on a node, its id becomes `pid` and its node the target; if a `NodeInterface`,
     that node is the target.
   - Only if `$node->{node_comment_field}->status == 2` (open) a comment is created:
     `subject` = "Reply by <actor>" (truncated), `name` = actor handle (truncated),
     `<comment_body_field>` = `{ value: object.content, format: comment_filter_format }`,
     `<activity_reference_field>` = activity id, created time copied from the activity.

## Outbound / deletion
- Local comments referencing an activity federate through the normal outbox (dynamic-type/`Note` flow).
- `onActivityDelete($activity)`: loads the `inbox_reply` config, then deletes comments matching
  `{comment_type, activity_reference_field: activity->id()}` — keeps the comment mirror consistent when
  the remote activity is deleted.

## Comment-form access (`activitypub_comment.module`)
`activitypub_comment_form_comment_form_alter()` adds the outbox element (`addActivityPubOutboxFormElement`)
and restricts `#access` on `activitypub_activity` to `administer comments`, or to a user who owns an
actor and owns the commented entity.

## JSON representation
`GET /comment/indieweb/{comment}` (`_format: activity_json`, `_entity_access: comment.view`) renders the
comment via the parent `EntityController::entity`.

## Notes
- The remote reply body is stored under `comment_filter_format` (default `restricted_html`), so output
  is filtered by that text format on render — keep it a restrictive format for remote content.
