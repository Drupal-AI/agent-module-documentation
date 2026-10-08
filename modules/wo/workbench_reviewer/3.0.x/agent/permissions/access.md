# Permissions & access model

**Workbench Reviewer defines no permissions of its own** (there is no `*.permissions.yml`, confirmed
at runtime — no `workbench_reviewer` permission exists). Access is governed entirely by the core
permissions of the entities and surfaces it plugs into.

## Assigning a reviewer

The reviewer field is set through the **normal node edit form**, so the gate is core **node update
access** for that node (e.g. `edit any <type> content` / `edit own <type> content`, node grants). A
user who can edit the node can set the `workbench_reviewer` value; a user who cannot edit it cannot.

The reference uses `handler: default`, so the autocomplete can resolve to **any user account**. Note
what assignment does and does not do: it writes a field value and makes the content appear in that
user's "Assigned to me" listing — it grants the assignee **no moderation capability**. Whether the
assignee can actually transition/approve the content is decided by core **Content Moderation**
transition permissions (`use <workflow> transition <transition>`), which this module does not define,
alter, or bypass. There is no route or action in this module that approves or transitions content.

## Viewing the "Assigned to me" queue

The queue page (`view.workbench_reviewer.page_assigned_to_me`, `/admin/content/assigned-to-me/{arg_0}`)
has **display access = permission `view all revisions`** (the core node revision permission). That
permission is not granted to anonymous or authenticated users by default; an administrator grants it
explicitly. Additional properties of the listing:

- The View runs with `disable_sql_rewrite: false`, so **node access grants are applied** to its query,
  and it carries the `user.node_grants:view` cache context.
- The contextual filter (`nodes_moderation_reviewer`) defaults to the **current user's uid**, so the
  default page shows only content assigned to the viewer. A different uid can be supplied as
  `{arg_0}`; reaching the page still requires `view all revisions`, which is itself a trusted,
  admin-granted permission (a holder can already view revisions site-wide through core), so scoping to
  another reviewer's uid discloses nothing beyond what that permission already allows.
- The listing is filtered to unpublished revisions (`status = 0`) of the latest revision.

## Practical setup

Grant `view all revisions` (or edit the View to require a narrower, role-specific permission) to the
roles that should act as reviewers, e.g.:

```
drush role:perm:add content_reviewer 'view all revisions'
```

Then those users see their assigned content at **Content → Assigned to me**. Editors who assign work
need only ordinary node edit access for the content they assign.
