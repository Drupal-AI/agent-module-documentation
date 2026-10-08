ActivityPub Comment federates comments: inbound Fediverse replies to a local node become Drupal comments, and local comments can be sent back out over ActivityPub.

---

ActivityPub Comment (`activitypub_comment`) integrates the core Comment module with ActivityPub. It ships an `@ActivityPubType` plugin (`activitypub_comment`) and an `inbox_reply` type config entity. When an inbound `Create` activity is a reply (`inReplyTo`) to a local node whose comment field is open, the plugin creates a local comment from the remote content using a configurable comment type, body field, filter format and default status; when the source activity is deleted, the mirrored comment is deleted too. Local comments carry a reference field to the originating activity so they can be federated, and a comment can be served as ActivityPub/IndieWeb JSON. The comment form is altered to show the ActivityPub outbox element only to appropriate users.

---

- Convert inbound Fediverse replies to a node into local Drupal comments.
- Attach remote replies to the correct node (and thread under a parent comment via `pid`).
- Store the remote reply body through a configurable comment filter format (default `restricted_html`).
- Set the comment type, body field, activity-reference field and default status via plugin config.
- Only create comments when the target node's comment field is open (status 2 / open).
- Delete the mirrored local comment automatically when the source activity is removed.
- Federate a local comment back to the Fediverse via the referenced activity.
- Queue inbound reply activities for processing through the ActivityPub inbox queue.
- Expose a comment as ActivityPub/IndieWeb JSON at `/comment/indieweb/{comment}`.
- Show the ActivityPub outbox form element on the comment form only to the comment/content owner or a comment administrator.
- Truncate the remote actor handle into the comment subject/author name.
- Keep federated comment threads in sync with their originating activities.
