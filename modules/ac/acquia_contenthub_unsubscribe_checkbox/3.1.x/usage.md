<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Content Hub unsubscribe content surfaces a per-entity checkbox that lets editors stop a subscriber entity from being auto-updated by Content Hub.
---
On a Content Hub subscriber site, incoming entities are normally kept in sync with the publisher. This module makes the `acquia_contenthub_unsubscriber_sync` checkbox (provided by `acquia_contenthub_unsubscribe`) visible on entity forms via `hook_form_alter`, relabels it "Check to desynchronise content", and adds a submit handler.

When an editor ticks the box, the submit handler flags the entity in the `acquia_contenthub_subscriber` tracker as `AUTO_UPDATE_DISABLED` and pushes an interest-list update (with `disable_syndication => TRUE`) to Content Hub through the `acquia_contenthub.client.factory`. Unticking re-queues the entity. This is UI glue on top of the Acquia Content Hub stack — it has no routes, permissions, or configuration of its own.
---
- Let editors keep a locally edited copy of a syndicated entity.
- Stop Content Hub from overwriting a manually customised node.
- Expose the desynchronise checkbox on node edit forms.
- Re-enable syndication by unchecking the box.
- Flag an entity as `AUTO_UPDATE_DISABLED` in the subscriber tracker.
- Push a `disable_syndication` interest-list update to Content Hub.
- Preserve local translations that diverge from the publisher.
- Give content teams control over which imported items stay frozen.
- Relabel the raw unsubscribe checkbox with editor-friendly text.
- Integrate with an existing Acquia Content Hub subscriber setup.
- Re-queue an entity for update when re-subscribed.
- Avoid losing hand-edited content on the next syndication run.
- Apply per-entity syndication policy from the standard edit form.
- Work across node and other fieldable entity forms.
- Audit which entities have opted out of syndication via the tracker.
- Coordinate desync state with the site's Content Hub webhook.