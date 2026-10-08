# Configuration

Configuring StoryChief is a two-part job: telling StoryChief about your Drupal site
(the destination), and telling Drupal how to authenticate and map the incoming
stories.

## Open the settings form

1. Log in as a user with permission to administer the module (StoryChief defines
   its own permissions for this).
2. Open the module's settings in the admin configuration area (the
   `storychief.admin` route).

## Save your key

The module authenticates every incoming webhook by recomputing an HMAC-SHA256
signature over the payload using the key you enter here, and comparing it — in
constant time — to the signature StoryChief sends. If they do not match, the
request is rejected as forbidden.

- Enter the **encryption/API key** from your StoryChief workspace so it matches
  exactly on both sides.
- **Treat this key as a secret.** It is the entire security boundary for the
  webhook: anyone who holds it can push content to your site. Do not commit it to
  version control or paste it where it could leak.

## Map the fields

StoryChief sends a story as a structured payload; the mapping tells Drupal which
StoryChief value goes into which Drupal field. Work through the mapping so the
title, body, and any other fields you care about land in the right place on the
content type you publish into.

For developers, mapping is built on Drupal's annotation-based plugin pattern, so you
can register additional field handlers (following the PSR-4 standard) or adjust
behaviour with the module's hooks:

- `hook_storychief_node_type_alter()` — change the node type to publish into at
  runtime.
- `hook_storychief_payload_alter()` — alter the incoming payload at runtime.
- `hook_storychief_field_handler_info_alter()` — remove or replace existing field
  handlers.

## Save and publish

Save the settings, then publish a story from StoryChief to confirm it flows into
Drupal as content with the fields mapped as you expect. Remember that pushed stories
become live site content, so treat the source workspace (and its key) as trusted.
