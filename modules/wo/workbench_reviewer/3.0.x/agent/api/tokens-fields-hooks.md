# API — field, token, Views argument and hooks

The module has **no services and no public PHP API class**. Everything integrators touch is the
`workbench_reviewer` field, an entity token, a Views argument, and a handful of hooks in
`workbench_reviewer.module` / `workbench_reviewer.views.inc`.

## The `workbench_reviewer` field

An `entity_reference` base field targeting `user`. Read or set it like any entity reference:

```php
// Read the assigned reviewer of a node.
if (!$node->get('workbench_reviewer')->isEmpty()) {
  /** @var \Drupal\user\UserInterface $reviewer */
  $reviewer = $node->get('workbench_reviewer')->entity;
}

// Assign a reviewer and save (writes on the current revision — the field is revisionable).
$node->set('workbench_reviewer', $uid);
$node->save();
```

- Added to a bundle only when it is under Content Moderation
  (`workbench_reviewer_entity_bundle_field_info()`, `workbench_reviewer.module:19`).
- Storage declared for `node` (revisionable, `target_type: user`) in
  `workbench_reviewer_entity_field_storage_info()` (`workbench_reviewer.module:53`).
- `handler: default`, so the reference is **unfiltered** — any user account is a valid target (there
  is no selection restriction to "users who can moderate"; see
  [../permissions/access.md](../permissions/access.md)).

## Entity token — `[<entity>:workbench_reviewer]`

`workbench_reviewer_token_info_alter()` (`workbench_reviewer.module:102`) registers a
`workbench_reviewer` token (name "Reviewer", type `user`) on **every entity type Content Moderation can
moderate** and for which a token type already exists (resolved via `token.entity_mapper`).
`workbench_reviewer_tokens()` (`workbench_reviewer.module:131`) resolves it:

- `[node:workbench_reviewer]` → the reviewer user's `label()` (username), or empty string if unassigned.
- Chained user tokens work too: `[node:workbench_reviewer:mail]`, `[node:workbench_reviewer:uid]`, …
  (it delegates to `\Drupal::token()->generate('user', …)` with the reviewer as the `user` data).
- Adds the reviewer account as a cacheable dependency (`BubbleableMetadata`) when present.

## Views argument — `workbench_reviewer_node_reviewer`

`workbench_reviewer_views_data_alter()` (`workbench_reviewer.views.inc:11`) registers a Views argument
on `node_field_revision`:

```php
$data['node_field_revision']['nodes_moderation_reviewer'] = [
  'title' => t('Node Workbench Reviewer'),
  'argument' => [
    'field' => 'workbench_reviewer',
    'id' => 'workbench_reviewer_node_reviewer',
  ],
];
```

The handler is `Drupal\workbench_reviewer\Plugin\views\argument\NodeModerationReviewer`
(`@ViewsArgument("workbench_reviewer_node_reviewer")`), which **extends core user
`Drupal\user\Plugin\views\argument\Uid`** and overrides `query()`:

```php
public function query($group_by = FALSE) {
  $this->ensureMyTable();
  $this->query->addWhere(0, "$this->tableAlias.workbench_reviewer", $this->argument, 'IN');
}
```

The argument value is passed as a **parameterised placeholder** through `addWhere()` (no string
interpolation of user input into SQL), and the column/alias are fixed — so it filters revisions whose
`workbench_reviewer` matches the given uid(s). Use this argument in your own View to build a
per-reviewer queue; combine with `default_argument_type: current_user` for a "mine" listing.

## Hooks implemented (in `workbench_reviewer.module`)

| Hook | Purpose |
|---|---|
| `hook_entity_bundle_field_info` | Defines the `workbench_reviewer` reference field on moderated bundles. |
| `hook_entity_field_storage_info` | Declares revisionable storage for the field on `node`. |
| `hook_form_BASE_FORM_ID_alter` (node_form) | Builds the "Workflow" sidebar group; moves `revision_log` + `workbench_reviewer` into it. |
| `hook_entity_presave` | **Present but empty** — a no-op stub (`if ($entity->getEntityTypeId() === 'node') {}`). Does nothing today. |
| `hook_token_info_alter` / `hook_tokens` | The `workbench_reviewer` entity token above. |
| `hook_views_data_alter` | Registers the `nodes_moderation_reviewer` argument. |

There are **no integrator-facing alter hooks defined by this module**, no event subscribers, and no
services to inject.
