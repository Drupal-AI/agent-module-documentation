Moderated Content Bulk Publish adds bulk moderation actions — publish latest revision, unpublish/archive current revision, and pin/unpin — to the `/admin/content` listing for content types running the core Content Moderation editorial workflow.

---

The module registers a set of node (and media) Action plugins — `publish_latest_revision_action`, `unpublish_current_revision_action`, `archive_current_revision_action`, `pin_content_action`, and `unpin_content_action` — and ships them as optional `system.action.*` config so they appear as bulk operations on content admin views. It leans on Views Bulk Operations and the core `content_moderation`/`workflows` modules: each action drives an entity through its moderation states via the internal `AdminModeration` and `AdminPin` helpers rather than merely toggling the `status` flag, so the correct default revision is published or archived. The transitions are translation-aware — the helpers iterate every translation of a node and apply the moderation state per language, which matters on multilingual sites. Which moderation states count as "published", "unpublished", and "archived" is configurable in `moderated_content_bulk_publish.settings`. A settings form at **Admin → Configuration → Content authoring → Moderated content bulk publish** (`/admin/config/content/moderated-content-bulk-publish`, route `moderated_content_bulk_publish.settings.form`) toggles a JS confirmation dialog on the node edit form and on the admin listing, an admin-toolbar language switcher, and whether original revision authoring info is retained. An event subscriber prevents a 403 when a translation has no pending revision by redirecting to the node, and a small `hook_moderated_content_bulk_publish_verify_*` API lets other modules (e.g. safedelete) veto a transition. Five permissions gate who may run each bulk operation. To use it you add the "Node operations bulk" field and these actions to the content view, then select rows and apply an action.

---

- Bulk-publish the latest (pending) revision of many moderated nodes at once from `/admin/content`.
- Bulk-unpublish the current revision of selected content, moving it to a draft/archived state.
- Bulk-archive the current revision of content that should be retired.
- Pin (make sticky) several nodes in one operation from the content listing.
- Unpin (remove sticky) content in bulk.
- Push moderated content through proper workflow states instead of just flipping the published flag.
- Publish every translation of a multilingual node in a single bulk action.
- Unpublish or archive content across all its translations at once.
- Define which workflow state means "published" for the publish action via config.
- Map custom "unpublish" states (e.g. draft plus archived) for the unpublish action.
- Configure which state the archive action transitions content into.
- Show a JavaScript confirmation dialog before bulk operations run on the admin listing.
- Show a confirmation dialog when publishing from the node edit form.
- Add a language switcher to the admin toolbar on multilingual sites.
- Hide that toolbar language switcher when it is not wanted.
- Retain original revision authoring info and append bulk context to the revision log message.
- Avoid a 403 when a node translation has no latest revision by redirecting to the node.
- Let another module (such as safedelete) veto a publish/unpublish via the verify hooks.
- Gate the publish bulk action behind the `moderated content bulk publish` permission.
- Restrict unpublish, archive, pin, and unpin each to their own permission.
- Give editors bulk moderation power without granting full "administer nodes".
- Speed up editorial cleanup after a launch by archiving stale pages in bulk.
- Apply bulk moderation to media entities as well as nodes via the shipped media actions.
- Enforce that a real published default revision exists (warns if moderation config is wrong).
- Manage large editorial queues on a content-moderation site without opening each node.
