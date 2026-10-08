# Configure — the reviewer field and the "Assigned to me" View

There is **no module settings page** (`configure: null`). "Configuring" Workbench Reviewer means two
things: (1) putting content types under moderation so the reviewer field appears, and (2) optionally
adjusting the shipped View / field display.

## 1. Make the reviewer field appear — enable Content Moderation

`workbench_reviewer_entity_bundle_field_info()` (`workbench_reviewer.module:19`) only defines the
`workbench_reviewer` base field for a bundle when
`content_moderation.moderation_information->shouldModerateEntitiesOfBundle($entity_type, $bundle)` is
TRUE. So the field is present **only on bundles attached to a Content Moderation workflow**. If a
content type is not moderated, the module does nothing for it.

To turn it on for, e.g., Article:

```
1. /admin/config/workflow/workflows  → edit a workflow (e.g. Editorial)
2. "This workflow applies to" → Content types → check Article → Save
3. The `workbench_reviewer` (label "Reviewer") field now exists on Article nodes.
```

`hook_entity_field_storage_info()` (`workbench_reviewer.module:53`) declares the **revisionable**
storage for the field on the `node` entity type (`target_type: user`), so an assignment is tracked per
revision alongside the moderation state.

## 2. Where editors set it — the node form

`workbench_reviewer_form_node_form_alter()` (`workbench_reviewer.module:70`) adds a **"Workflow"**
details section (`$form['workflow']`, `#type => details`, `#group => advanced`, weight 100) to the
right-hand advanced sidebar of the node edit form, and moves two elements into it:

- `revision_log` (the core "Revision log message" box), and
- `workbench_reviewer` — rendered by its default form widget
  `entity_reference_autocomplete` (autocomplete on `user`, `match_operator: CONTAINS`, size 60).

So an editor opens the node, expands **Workflow**, and types a username into **Reviewer**. Assignment
is optional and is saved as an ordinary field value when the node is saved.

The field's display is `setDisplayConfigurable('view'/'form', TRUE)` with the view display defaulted to
the `hidden` region, so it does **not** render on the node page unless an admin enables it on
`admin/structure/types/manage/<bundle>/display`. The form widget can likewise be re-ordered on
`…/form-display` (the module only sets the initial `#group`).

## 3. The "Assigned to me" listing — an optional View

`config/optional/views.view.workbench_reviewer.yml` (id `workbench_reviewer`, label
"Workbench Reviewer: Assigned to me") is **optional config**: it is imported on install only when its
dependencies (`content_moderation`, `node`, `user`, and `views`) are all present, and it is **not**
re-created if you delete it. Base table: `node_field_revision` (it lists node *revisions*).

| Property | Value |
|---|---|
| View id | `workbench_reviewer` |
| Displays | `default` (Master), `page_assigned_to_me` (page) |
| Page path | `admin/content/assigned-to-me` (runtime route `view.workbench_reviewer.page_assigned_to_me`, `/admin/content/assigned-to-me/{arg_0}`) |
| Display access | **permission `view all revisions`** (core node revision permission) |
| Page menu | `workbench` menu, title "Assigned to me" |
| Contextual filter | `nodes_moderation_reviewer` (argument plugin `workbench_reviewer_node_reviewer`), default = **current user's uid** (`default_argument_type: current_user`) |
| Fixed filters | `status = 0` (unpublished revisions only), `latest_revision`, exposed `title` / `uid` / `moderation_state` filters |
| Fields | title, author name, changed, nid, vid, published, workflow state, revision log message, "View" revision link |
| SQL rewrite | `disable_sql_rewrite: false` (node access grants applied); cache tag-based, context `user.node_grants:view` |

Because the contextual filter defaults to `current_user`, visiting `/admin/content/assigned-to-me`
shows **the current user's** assigned unpublished content. A `{arg_0}` uid may be supplied in the URL
to scope to another reviewer, but reaching the page at all requires the `view all revisions`
permission (see [../permissions/access.md](../permissions/access.md)).

### Tab / menu entry

`workbench_reviewer.links.task.yml` registers the local task **`content_moderation.workbench_reviewer`**
("Assigned to me", parent `system.admin_content`, route `view.workbench_reviewer.page_assigned_to_me`),
so the queue also appears as a tab under **Content** (`/admin/content`).

### Customising / re-importing the View

Edit it at `/admin/structure/views/view/workbench_reviewer` like any View — change the columns,
exposed filters, or the `view all revisions` access permission to a role-specific one. If you deleted
it and want it back, re-import from the module's `config/optional` (e.g. with the Config
Update / single-import UI) — a module reinstall alone will only re-create optional config on the next
install of the module.
