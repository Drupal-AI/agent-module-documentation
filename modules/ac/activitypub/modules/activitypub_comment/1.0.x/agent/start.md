<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Comment (activitypub_comment) — agent index

Submodule of **activitypub**. Bridges core Comment and ActivityPub: inbound replies → local comments,
local comments → Fediverse.

## Dependencies
`comment`, `activitypub`.

## What it provides
- `@ActivityPubType` plugin `activitypub_comment` (`src/Plugin/activitypub/type/Comment.php`,
  extends `TypePluginBase`). Default config: `comment_type: comment`, `comment_body_field: comment_body`,
  `activity_reference_field: activitypub_activity`, `node_comment_field: comment`, `comment_status: TRUE`,
  `comment_filter_format: restricted_html` (all editable on the type form).
- `inbox_reply` type config entity (`config/optional/activitypub.activitypub_type.inbox_reply.yml`) —
  enable it to turn inbound replies into comments.
- Comment field storage `activitypub_activity` on comments
  (`config/optional/field.storage.comment.activitypub_activity.yml`) linking a comment to its activity.
- Config schema `config/schema/activitypub_comment.schema.yml`.
- `hook_form_comment_form_alter()` (`activitypub_comment.module`) exposes the ActivityPub outbox element
  on the comment form only to `administer comments` or the actor-owning content owner.
- Route `activitypub_comment.comment.indieweb.json` `GET /comment/indieweb/{comment}`
  (`_entity_access: comment.view`, `_format: activity_json`) → `activitypub\Controller\EntityController::entity`.

## Plugin behavior (`Comment.php`)
- `onActivityPostSave()`: an inbound `Create` with a reply, when `inbox_reply` is enabled, sets the
  activity's `config_id` to `inbox_reply` and queues it.
- `doInboxProcess()` → `handleCommentCreation()`: resolves the reply target
  (`Utility::getEntityFromUrl()`) to a node/comment and creates a comment (subject/name derived from the
  remote actor, body = `object.content` under `comment_filter_format`, `pid` for threaded replies) when
  the node's comment field is open (`status == 2`).
- `onActivityDelete()`: deletes comments referencing the deleted activity.

## Solution doc
- Plugin config & reply→comment flow: [agent/plugins/comment.md](plugins/comment.md)
