<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workbench Reviewer (workbench_reviewer) — agent index

Adds a **reviewer** dimension on top of core **Content Moderation**: a per-entity `entity_reference`
base field (`workbench_reviewer`, target `user`) so an editor can assign a piece of content to a
named person to review, plus an "Assigned to me" listing so a reviewer can find what is waiting for
them. The field is added by `hook_entity_bundle_field_info()` **only to bundles that are under
moderation** (`content_moderation.moderation_information->shouldModerateEntitiesOfBundle()`), and its
revisionable storage is declared for `node` via `hook_entity_field_storage_info()`. On the node form,
`hook_form_node_form_alter()` creates a **"Workflow"** details group in the advanced sidebar and moves
the reviewer field and the core `revision_log` message into it. There is **no settings form and no
custom controller/service/permission** — assignment is just a field value written through the normal
node edit form.

The reading side is an **optional View** (`config/optional/views.view.workbench_reviewer.yml`, id
`workbench_reviewer`) with a page display at `/admin/content/assigned-to-me` (route
`view.workbench_reviewer.page_assigned_to_me`) whose **display access is the core permission
`view all revisions`**. It filters to unpublished revisions and is scoped to the current user through a
contextual filter backed by the module's Views argument plugin `NodeModerationReviewer`
(`@ViewsArgument("workbench_reviewer_node_reviewer")`, extends core user `Uid`), which is registered on
`node_field_revision` by `hook_views_data_alter()`. The module also exposes a `workbench_reviewer`
entity token on every moderatable entity type (`hook_token_info_alter()` / `hook_tokens()`).

- **Depends on:** `drupal:content_moderation (>= 8.4)`. Soft: the "Assigned to me" View also needs
  `views`, `node`, `user` (all core) — it is `config/optional`, installed only when they are present.
- **Core:** `^9 || ^10 || ^11`. **Package:** `Workbench`. **Version:** `3.0.0-beta2` (beta).
- **No settings page / `configure` route** (`configure: null`). **No module-defined permissions.**
  **No services. No drush. No config schema. Defines no plugin types.**
- Provides one Views **argument** plugin instance (not a plugin *type*), one base field, one optional
  View, one entity token, and one local-task tab.

## What you'd do → where

- **Turn assignment on for a content type / where the reviewer field comes from / display + storage** →
  [configure/reviewer-field-and-view.md](configure/reviewer-field-and-view.md)
- **The "Assigned to me" View, its route/path/menu, and how to reuse or re-import it** →
  [configure/reviewer-field-and-view.md](configure/reviewer-field-and-view.md)
- **Read/set the reviewer from code, the entity token, the Views argument + views data, the hooks** →
  [api/tokens-fields-hooks.md](api/tokens-fields-hooks.md)
- **Who can assign, who can see the queue, and the access model (the module defines no permissions)** →
  [permissions/access.md](permissions/access.md)

## Key facts (real machine names)

- **Base field:** `workbench_reviewer` (`entity_reference`, `target_type: user`, `handler: default`,
  revisionable) — added to moderated bundles in `workbench_reviewer.module`
  `workbench_reviewer_entity_bundle_field_info()`; storage declared for `node` in
  `workbench_reviewer_entity_field_storage_info()`.
- **Form alter:** `workbench_reviewer_form_node_form_alter()` — adds `$form['workflow']` (`#type
  details`, `#group advanced`) and reparents `revision_log` + `workbench_reviewer` into it.
- **Token:** `[<entity>:workbench_reviewer]` (name "Reviewer", type `user`) —
  `workbench_reviewer_token_info_alter()` / `workbench_reviewer_tokens()`; only on entity types where
  `content_moderation` can moderate them and a token type exists.
- **View:** `views.view.workbench_reviewer` (id `workbench_reviewer`, label "Workbench Reviewer:
  Assigned to me", base table `node_field_revision`). Displays `default` (Master) +
  `page_assigned_to_me` (page). Path `admin/content/assigned-to-me`; runtime route
  `view.workbench_reviewer.page_assigned_to_me` (`/admin/content/assigned-to-me/{arg_0}`); page menu in
  the `workbench` menu. Display access = permission **`view all revisions`**.
- **Views argument plugin:** `Drupal\workbench_reviewer\Plugin\views\argument\NodeModerationReviewer`
  (`@ViewsArgument("workbench_reviewer_node_reviewer")`, extends `Drupal\user\Plugin\views\argument\Uid`).
- **Views data:** `hook_views_data_alter()` registers `node_field_revision.nodes_moderation_reviewer`
  (argument id `workbench_reviewer_node_reviewer`) in `workbench_reviewer.views.inc`.
- **Local task tab:** `content_moderation.workbench_reviewer` (`workbench_reviewer.links.task.yml`) —
  title "Assigned to me", parent `system.admin_content`, route
  `view.workbench_reviewer.page_assigned_to_me`.
- **Hooks implemented:** `hook_entity_bundle_field_info`, `hook_entity_field_storage_info`,
  `hook_form_BASE_FORM_ID_alter` (node_form), `hook_entity_presave` (present but a **no-op**),
  `hook_token_info_alter`, `hook_tokens`, `hook_views_data_alter`.
