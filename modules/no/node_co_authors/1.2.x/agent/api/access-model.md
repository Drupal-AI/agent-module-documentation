# Access model — the `co_authors` field and its two hooks

Everything is in `node_co_authors.module`. There are no routes, controllers or forms; co-authorship
is edited through the normal node edit form's field widget and enforced entirely by entity/field
access hooks.

## The field — `co_authors`

`node_co_authors_entity_base_field_info()` adds one base field to the `node` entity type:

- `entity_reference`, `target_type` = `user`, `CARDINALITY_UNLIMITED`, `setRevisionable(TRUE)`,
  translatable iff the entity type is translatable.
- Form widget `entity_reference_autocomplete_tags` (weight 17, `match_operator` CONTAINS,
  `match_limit` 10, size 60), display-configurable on `form` and `view`; default `view` region is
  `hidden`.
- `node_co_authors_form_node_form_alter()` sets `$form['co_authors']['#group'] = 'author'`, so it
  renders in the node form's Authoring-information group.

Because it is a base field, it exists on every node bundle with no per-bundle configuration.

## Entity access — who may view/edit/delete the node (`node_co_authors_node_access`)

Implements `hook_ENTITY_TYPE_access` for `node`. This is the **runtime** entity access hook
(`hook_node_access`), *not* the `hook_node_grants` / `hook_node_access_records` grants API — so it
affects per-entity access checks (viewing/editing a specific node) but does **not** rewrite listing
queries (Views/node listings keep core's grant behaviour).

```php
function node_co_authors_node_access(NodeInterface $node, $op, AccountInterface $account): AccessResultInterface {
  if (!$node->hasField('co_authors')) {
    return AccessResult::neutral();
  }
  $type = $node->bundle();
  $ids  = array_column($node->get('co_authors')->getValue(), 'target_id');

  $isCoAuthor = AccessResult::allowedIf(in_array($account->id(), $ids, TRUE))
    ->cachePerUser()
    ->addCacheableDependency($node);

  if ($op === 'view' && !$node->isPublished()) {
    return AccessResult::allowedIfHasPermission($account, 'view own unpublished content')->andIf($isCoAuthor);
  }
  if ($op === 'update') {
    return AccessResult::allowedIfHasPermission($account, 'edit own ' . $type . ' content')->andIf($isCoAuthor);
  }
  if ($op === 'delete') {
    return AccessResult::allowedIfHasPermission($account, 'delete own ' . $type . ' content')->andIf($isCoAuthor);
  }
  return AccessResult::neutral();
}
```

Key properties an agent should rely on:

- **Purely additive.** Every branch returns either `allowed` or `neutral`; it never returns
  `forbidden`. So the hook can only *grant* extra access, matching core's rule that any allowing
  hook grants unless something else forbids.
- **Conjunction, not disjunction.** `allowedIfHasPermission(...)->andIf($isCoAuthor)` is `allowed`
  only when the user both holds the core "own content" permission for that op/bundle **and** is
  listed in that node's `co_authors`. A co-author who lacks `edit own <type> content` gets nothing
  for `update`; a user who is not a co-author gets nothing regardless of permissions.
- **Scoped to the specific node.** `$ids` is read from *this* node's `co_authors`, so the grant
  never spills to nodes the user was not added to.
- **`view` only for unpublished.** For published nodes the `view` op falls through to `neutral`
  (core already governs published view access). Co-authors can view an *unpublished* node only if
  they hold `view own unpublished content`.
- **Correct cacheability.** `cachePerUser()` + `addCacheableDependency($node)` so the decision
  re-computes per user and invalidates when the node (its co-author list) changes.

## Field access — who may edit the co-author list (`node_co_authors_entity_field_access`)

Implements `hook_entity_field_access`. It short-circuits to `neutral` unless the field is
`co_authors` provided by `node_co_authors` **and** the operation is `edit` (so `view` of the field
is untouched). It then builds an allow result from four independent sources and, if none allow,
returns `forbidden`:

```php
if ($entity->getOwnerId() === $account->id()) {
  $result = $result->orIf(AccessResult::allowedIfHasPermission($account, 'edit co-authors of own content'));
}
$co_author_ids = array_column($items->getValue(), 'target_id');
if (in_array($account->id(), $co_author_ids, TRUE)) {
  $result = $result->orIf(AccessResult::allowedIfHasPermission($account, 'edit co-authors of co-authored content'));
}
$result = $result->orIf(AccessResult::allowedIfHasPermission($account, 'administer nodes'));
$result = $result->orIf(AccessResult::allowedIfHasPermission($account, 'edit co-authors of all content'));
return $result->isAllowed() ? $result : AccessResult::forbidden($result->getReason());
```

- The node **owner** may edit the list only with `edit co-authors of own content`.
- An existing **co-author** may edit the list only with `edit co-authors of co-authored content`
  (this is the permission that lets a co-author add *further* co-authors — a delegation chain to
  grant deliberately).
- `administer nodes` or `edit co-authors of all content` allow editing any node's list.
- Editing the field still additionally requires **update access to the node itself** (the widget
  only renders on a node form the user can reach), so the two hooks compose: node access decides who
  opens the edit form; field access decides whether the co-author list within it is writable.

The returned `forbidden` is scoped to this one field's `edit` op — it hides/locks the widget, it
does not forbid the whole node.
