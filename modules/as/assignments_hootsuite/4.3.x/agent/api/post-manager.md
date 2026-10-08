<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HootsuitePostManager — scheduling & hooks

Service `assignments_hootsuite.post_manager`, class `Service\HootsuitePostManager` implements `HootsuitePostManagerInterface`. Constructor args: `@assignments_hootsuite.client`, `@token`, `@config.factory`, `@logger.factory`, `@messenger`, `@entity_type.manager`. Reads `assignments_hootsuite.settings`; assignment-reference field name is fixed to `field_hs_assignment`.

## Hook entry points (`assignments_hootsuite.module`)
- `hook_node_insert` → `handleNode($node)`.
- `hook_node_update` → `handleNode($node, TRUE)` (also reconciles removed assignments).
- `hook_node_predelete` → `deletePost()` for each social assignment on the node.
- `hook_assignment_predelete` → `deletePost($assignment)`.
- `hook_entity_translation_create` → clears `field_hs_assignment` on new translations.

## Key methods
- `handleNode(NodeInterface $entity, $update = FALSE)` — iterates `field_hs_assignment` items; for each referenced `Assignment` that has `field_hs_profile_id`, if `validate()` passes calls `sendPost()`. On update, diffs `$entity->original` vs current to `deletePost()` assignments that were detached.
- `validate()` — refuses to schedule for an unpublished node (unless a `publish_on` date precedes `field_hs_date`) and refuses past `field_hs_date` (`< time()`).
- `sendPost(NodeInterface $entity, Assignment $assignment)` — if `field_hs_post_id` already set, deletes the old post first. Builds the request body:
  - `text` = `strip_tags` + `html_entity_decode` of token-replaced `field_hs_post` (tokens resolved against `['node' => $entity]`).
  - `socialProfileIds` = `[field_hs_profile_id]`.
  - `scheduledSendTime` = `field_hs_date . 'Z'`.
  - image (if `field_hs_image` set): token-replaced value is a **file id**; loads the `file`, for Instagram profiles requires a square image (`checkImageSquare()` via `getimagesize`), then `uploadImage()` and attaches `media => [['id' => …]]`.
  - Pinterest (`augmentForPinterest()`): if `field_hs_pinterest_board` present, adds `extendedInfo` with `boardId` + destination URL (node canonical URL or `field_hs_pinterest_url`).
  POSTs to `url_post_message_endpoint` via `client->connect()`. On a `SCHEDULED` response, stores the returned Hootsuite post id back into `field_hs_post_id` and `$assignment->save()`.
- `deletePost(Assignment $assignment, $update = FALSE)` — no-op if no `field_hs_post_id` or if `field_hs_date` is in the past; otherwise `connect('delete', url_post_message_endpoint . '/' . post_id)`.
- `uploadImage()` / `registerImage()` — registers the image with Hootsuite (`url_post_media_endpoint`, sends `mimeType` + `sizeBytes`), then `uploadToAws()` PUTs the file bytes to the `uploadUrl` Hootsuite returns, and polls the media state up to 20× (1s sleep) until `READY`. In-request memoized in `$this->images`.
- `getProfileMetadata(Assignment $assignment)` — GET `url_social_profiles_endpoint . '/' . profile_id`, returns the `data` payload (used to detect Instagram).

## Bundle fields (created by `Form\Profiles`)
`field_hs_post` (string_long, post text/tokens), `field_hs_date` (datetime, schedule), `field_hs_image` (string_long, must resolve to a file id), `field_hs_profile_id` (string), `field_hs_profile_name` (string), `field_hs_post_id` (string, Hootsuite id). Optional Pinterest fields (`field_hs_pinterest_board`, `field_hs_pinterest_url`) are read if present but not created by this module. Node-side reference: `field_hs_assignment`.
