Change Requests captures a user's edits to a node as a separate, field-by-field "patch" entity (a proposed edit / pull-request-style change) that reviewers view as a diff and later merge into the node.

---

The module hooks into the node edit form: for content types you enable, when a permitted user saves changes they are diverted into a `patch` content entity instead of the node, using the Changed Field API to detect exactly which fields changed and the diff-match-patch library to store text changes as compact patch statements. Each node grows a "Change requests" tab listing its patches with status (proposed, conflicted, applied, declined). A reviewer opens the apply form, which shows the author's intended change on the left and the auto-merged result as editable field widgets on the right, resolves any merge conflicts, and applies it — creating a new node revision whose log message credits the patch author. Field-type support is provided by a `FieldPatchPlugin` plugin type covering almost all core field types (text, numbers, lists, email/telephone, link, date/daterange, entity_reference, file, image), and custom field types can plug in their own patch logic. A settings form selects which content types are managed and which fields are excluded from patching.

---

- Let community or anonymous-of-role users propose edits to articles without granting them direct write access to the live node.
- Run a lightweight editorial review workflow where proposed changes wait for a reviewer to approve and apply them.
- Collaborate on shared content (wiki-style pages) without edit-wars, since concurrent proposals are stored separately rather than overwriting each other.
- Capture suggested corrections (typos, factual fixes) from many contributors and merge the good ones.
- Present a side-by-side diff of "current value" vs "proposed value" for each changed field before accepting a change.
- Auto-merge a proposed change against the latest node revision and surface merge conflicts for manual resolution before saving.
- Keep the node's revision history clean: proposals live in patch entities and only accepted ones become node revisions.
- Record who proposed a change and their log message in the node revision log when the change is applied.
- Enable change-request handling per content type (e.g. only "article" and "page") from the admin settings form.
- Exclude specific fields (globally or per content type) from being captured into patches.
- Require a log message when users submit changes, and override the confusing default "Revision log message" label.
- Let trusted editors bypass the workflow and save directly to nodes via the "bypass change request" permission.
- Show a badge/count of active or conflicted change requests on a node's "Change requests" local task tab.
- Expose a per-node change-request overview table (`/node/{node}/patches`) with view/apply/edit/delete operations.
- Load a rendered change request in a modal dialog via the AJAX endpoint (`/ajax/patch/{patch}`).
- Attach a newly created patch to an entity-reference (to `patch`) field on another entity via an `attach_to` query parameter, to build custom listings.
- Support text fields (string, string_long, text, text_long, text_with_summary) with word-level diff/merge.
- Support number, boolean, list, email, telephone, link, datetime, timestamp and daterange fields.
- Support entity_reference, file and image fields as change requests.
- Add change-request support for a custom field type by implementing the `FieldPatchPlugin` plugin interface.
- Diff two node revisions field-by-field programmatically through the `plugin.manager.field_patch_plugin` service.
- Use a computed `cr_count` field on managed node bundles to display the number of change requests referencing a node.
- Integrate with the Diff module so applied changes remain transparent in the node's revision history.
- Choose the image style used when displaying image-field change requests in the diff and apply views.
