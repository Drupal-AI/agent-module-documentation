<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook Post Action — the post-write hooks

Declared in `hook_post_action.api.php`. All fire **after** the entity write is committed.

## The eight hooks

Entity-generic (any entity type):

| Hook | Signature | Fires |
|---|---|---|
| `hook_entity_postinsert($entity)` | `EntityInterface` | after an insert |
| `hook_entity_postupdate($entity)` | `EntityInterface` | after an update |
| `hook_entity_postdelete($entity)` | `EntityInterface` | after a delete |
| `hook_entity_postsave($entity, $op)` | `EntityInterface, string` | after any write; `$op` = insert/update/delete |

Entity-type-specific (`hook_ENTITY_TYPE_post*`, e.g. `node`, `taxonomy_term`, `commerce_order`):

| Hook | Signature |
|---|---|
| `hook_ENTITY_TYPE_postinsert($entity)` | `EntityInterface` |
| `hook_ENTITY_TYPE_postupdate($entity)` | `EntityInterface` |
| `hook_ENTITY_TYPE_postdelete($entity)` | `EntityInterface` |
| `hook_ENTITY_TYPE_postsave($entity, $op)` | `EntityInterface, string` |

Every write dispatches all four applicable hooks in this order (see `_hook_post_action_post_save`):
`hook_ENTITY_TYPE_post{op}` → `hook_ENTITY_TYPE_postsave` → `hook_entity_post{op}` →
`hook_entity_postsave`.

## When / how they fire

`hook_post_action.module` implements core `hook_entity_insert/update/delete`; each registers a
shutdown callback:

```php
function hook_post_action_entity_insert(EntityInterface $entity) {
  drupal_register_shutdown_function('_hook_post_action_post_save', $entity, 'insert');
}
```

At shutdown, `_hook_post_action_post_save($entity, $op)` verifies the write:
- `insert`/`update` → always proceeds.
- `delete` → re-loads the entity; proceeds only if it is now gone (a missing entity **type** is also
  treated as done).

Then it dispatches via `\Drupal::moduleHandler()->invokeAll(...)`. Because dispatch is on PHP
shutdown, the hooks run at the very end of the request, after the DB write is committed.

## Implementing a hook

In `MYMODULE.module`:

```php
use Drupal\Core\Entity\EntityInterface;

/** Implements hook_entity_postinsert(). */
function MYMODULE_entity_postinsert(EntityInterface $entity) {
  // Runs after ANY entity is inserted and committed.
  \Drupal::state()->set('my_last_insert', $entity->getEntityTypeId() . ':' . $entity->id());
}

/** Implements hook_ENTITY_TYPE_postupdate() for nodes. */
function MYMODULE_node_postupdate(EntityInterface $entity) {
  // Runs after a node update is committed.
}

/** Implements hook_entity_postsave(): $op is insert|update|delete. */
function MYMODULE_entity_postsave(EntityInterface $entity, $op) {
  // One handler for all three operations.
}
```

No return value is expected; do your side effect (queue a job, call an API, invalidate a cache, etc.).

## The reference submodule

`hook_post_action_example` implements every hook and logs to the `hook_post_action_test` logger
channel on each event — enable it and watch `admin/reports/dblog` (via a real web request) to see the
order in which the hooks fire. See its docs under
`modules/hook_post_action_example/2.0.x/`.

## Gotcha for tooling/tests

Dispatch happens on **request shutdown**. Under `drush php:eval`, Drupal's shutdown handlers do not
run the same way, so saving an entity there will not synchronously trigger these hooks. To exercise a
handler deterministically from code/tests, dispatch it yourself, e.g.
`\Drupal::moduleHandler()->invokeAll('entity_postinsert', [$entity]);` — which is exactly what the
module does at shutdown.
