Publish Content adds granular per-content-type and per-role permissions for publishing and unpublishing nodes, plus a one-click Publish/Unpublish local task tab, an optional node-form checkbox, and a Views link field — all without granting the broad "administer nodes" permission.

---

Publish Content is a lightweight editorial-workflow helper for Drupal core nodes. Instead of the all-or-nothing "administer nodes" permission, it defines fine-grained permissions: five global permissions (publish/unpublish any content, publish/unpublish editable content, and access to its settings) and, dynamically per content type, six more per role (publish/unpublish for any, own, or editable nodes of that bundle). A `PublishContentAccess` service (`publishcontent.access`, tagged as the `_publish_access_check` route access checker) combines these permissions with translation checks and any module's `hook_publishcontent_publish_access`/`hook_publishcontent_unpublish_access` implementations to decide access. When allowed, a "Publish/Unpublish" local task tab appears beside a node's View/Edit tabs, toggling status via `/node/{node}/toggleStatus` (CSRF-protected), with a translation-aware variant at `/node/{node}/toggleStatus/{langcode}`. A settings form at `/admin/config/workflow/publishcontent` toggles the local task and/or an in-form checkbox, controls whether toggling creates a new revision or a watchdog log entry, and customises the Publish/Unpublish button and status-markup labels. If Views is enabled, a "Publish/Unpublish" field handler renders a per-row toggle link. Toggling also dispatches `PublishContentPublishEvent`/`PublishContentUnpublishEvent` for other code to react to. It requires only Drupal core's node module and applies to nodes only.

---

- Let editors publish/unpublish content without giving them "administer nodes"
- Grant a reviewer role the ability to publish any content site-wide
- Grant an author role the ability to unpublish only their own articles
- Allow publishing only of content a user already has permission to edit
- Restrict publishing rights to a single content type (e.g. only "article")
- Give writers "unpublish own" rights so they can retract their own posts
- Add a one-click Publish/Unpublish tab beside a node's View and Edit tabs
- Add a Publish/Unpublish checkbox at the bottom of the node edit form
- Disable the core status checkbox for users who lack publishing permission
- Add a Publish/Unpublish toggle link column to an editorial Views listing
- Build a moderation queue View where reviewers publish rows in one click
- Automatically create a new node revision each time status is toggled
- Log every publish/unpublish action to watchdog for accountability
- Customise the Publish/Unpublish button labels (e.g. "Go live"/"Retract")
- Customise the Published/Unpublished status markup shown in the form meta area
- Toggle the published status of a specific translation of a node
- Prevent users without permission from creating already-published content
- React to publish/unpublish via `PublishContentPublishEvent` subscribers
- Deny or force publishing access programmatically via the access hooks
- Integrate publishing rights with Organic Groups membership
- Set up tiered editorial workflows (writer drafts, editor publishes)
- Expose publishing to inline entity forms (nodes) via IEF form alter
- Keep the publish action available on the canonical node view page
- Separate "can edit" from "can publish" for compliance/approval flows
- Give a role publish rights on new content types automatically as they are added
