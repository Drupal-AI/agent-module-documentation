# Hooks (`publishcontent.api.php`)

Two access-alter hooks let any module allow or deny publish/unpublish access for a node.
They run **only after** the user already passed the module's permission checks; the results
are merged with a default `AccessResult::allowed()` using `orIf`. So:

- Return `AccessResult::forbidden()` to **block** an otherwise-permitted toggle.
- Return `AccessResult::allowed()` to explicitly grant.
- Return `AccessResult::neutral()` to stay out of the decision (let other hooks/default win).

Note: because a default `allowed()` is always merged in with `orIf`, a lone `forbidden()`
from your hook is combined with that `allowed()`. To hard-deny reliably, return a
`forbidden()` result (its `orIf` semantics: forbidden dominates neutral but an explicit
allowed from another source can combine — see `processAccessHookResults`).

## `hook_publishcontent_publish_access(NodeInterface $node, AccountInterface $account)`

Called when the module is deciding whether `$account` may **publish** `$node`. Return an
`AccessResult`.

## `hook_publishcontent_unpublish_access(NodeInterface $node, AccountInterface $account)`

Same, for **unpublishing**.

```php
function mymodule_publishcontent_publish_access(NodeInterface $node, AccountInterface $account) {
  if ($node->getType() === 'article' && $node->get('field_ready')->value !== '1') {
    return AccessResult::forbidden();
  }
  return AccessResult::neutral();
}
```

Both hooks are invoked via `moduleHandler->invokeAll()`, so every implementation runs and
results are combined. There are no other hooks; for post-toggle reactions use the events
in [../api/api.md](../api/api.md).
