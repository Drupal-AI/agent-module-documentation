<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entityqueue Form Widget adds a checkbox panel to the sidebar of node add/edit forms so editors can add or remove the node from Entityqueue subqueues right while editing, instead of visiting the separate Entityqueue admin pages.

---

Entityqueue Form Widget is a small, zero-configuration companion to the Entityqueue module. It implements `hook_form_node_form_alter()` (via a hook-service class) to inject an **"Entityqueues settings"** details element into the node form's `advanced` group (the right sidebar). Inside it lists a checkbox for every subqueue whose parent queue **targets the node's entity type and bundle** (`target_type == node` and the node's bundle is in the queue's `target_bundles`, or the queue has no bundle restriction). Each checkbox is gated by the queue's own Entityqueue permission — the editor needs `update <queue_id> entityqueue` or `manipulate all entityqueues` for it to appear — and shows the queue's current fill (`N out of MAX items`), disabling the box when a fixed-size queue is full (unless the queue "acts as queue"). On submit, a submit handler adds the node to each checked subqueue (`EntitySubqueue::addItem()`) and removes it from unchecked ones (`removeItem()`), respecting the node's published state and any Scheduler `publish_on` date so unpublished content is not queued. It has no admin settings form, no configure route, no permissions of its own, no plugins, and no Drush commands; its only config schema is an empty `entityqueue_form_widget.settings` object. The widget appears automatically once at least one matching entityqueue exists.

---

- Let editors add an article to a "Featured" entityqueue directly from the article edit form.
- Remove a node from a homepage carousel queue by unchecking it while editing.
- Assign a node to several queues at once from a single sidebar panel.
- Curate a "Top stories" list without leaving the content editing screen.
- Show editors how full each queue is (e.g. "3 out of 5 items") before adding.
- Prevent adding to a full fixed-size queue by disabling its checkbox automatically.
- Restrict which editors can queue content per queue using Entityqueue permissions.
- Give a role `manipulate all entityqueues` so it sees every queue checkbox on node forms.
- Keep unpublished drafts out of queues until they are published.
- Work with Scheduler's `publish_on` so a scheduled node still gets queued on publish.
- Curate bundle-specific queues (e.g. only Article-targeting queues appear on article forms).
- Speed up editorial workflows by combining content edits and queue placement in one save.
- Add a new node to a "Breaking news" queue at creation time.
- Manage promotional slots (banners, spotlights) as entityqueues editable from the node form.
- Let section editors manage their own section's featured queue from the edit page.
- Reorder awareness: link editors to the Entityqueue management page for ordering from the widget.
- Support both simple and multiple-subqueue Entityqueue handlers (labels show the parent queue).
- Remove a node from all queues automatically when it has no published revision.
- Provide a consistent queue-assignment UI across all content types.
- Avoid training editors on the separate Entityqueue admin UI for basic add/remove tasks.
- Surface queue membership state (checked = already in queue) when opening a node for edit.
- Curate editorial "collections" of nodes inline during content review.
- Toggle a node in/out of a newsletter or digest queue while editing it.
- Keep queue curation permission-aware so editors only touch queues they own.
