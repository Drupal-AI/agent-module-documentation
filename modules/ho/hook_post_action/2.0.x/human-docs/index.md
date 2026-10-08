# Hook Post Action — manual setup guide

**Hook Post Action** (`hook_post_action`) is a small developer module that
introduces **eight new Drupal hooks** which fire *after* an entity write has actually
been committed — so your code can react to a completed save, insert, update or delete
rather than acting mid-transaction.

Core's own `hook_entity_insert` / `update` / `delete` run inside the save flow,
before the request finishes and sometimes before everything is fully persisted, which
makes "do this once the entity is definitely saved" awkward. This module fills that
gap. It hooks core's entity write hooks and registers a shutdown callback, so at the
very end of the request — after the database write is committed — it dispatches
post-write hooks: an operation-specific one and a generic `postsave` one, in both an
entity-generic form (`hook_entity_postinsert`) and an entity-type-specific form
(`hook_node_postinsert`, `hook_commerce_order_postupdate`, and so on). Deletes are
double-checked by reloading the entity and only firing if it is really gone.

There is nothing to configure. The module has no settings form, no permissions, no
services, and no Drush commands. You use it by implementing the new hooks in your own
module's `.module` file. It has no dependencies, and it ships one optional submodule,
**Hook Post Action Example** (`hook_post_action_example`), which implements every hook
and logs on each event — a ready-made, copy-paste reference.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — the exact hook signatures, firing
order and gotchas — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the example submodule.

## Where it lives in the admin menu

Nowhere — there is no admin page or settings form. This is a code-only API.

## How to use it

Implement one or more of the eight hooks in your own module. The hooks are:

- **Entity-generic** (any entity type): `hook_entity_postinsert($entity)`,
  `hook_entity_postupdate($entity)`, `hook_entity_postdelete($entity)`, and
  `hook_entity_postsave($entity, $op)` where `$op` is `insert`, `update` or `delete`.
- **Entity-type-specific**: `hook_ENTITY_TYPE_postinsert($entity)` and its
  `postupdate`/`postdelete`/`postsave` siblings — e.g. `hook_node_postinsert`,
  `hook_commerce_order_postsave`.

A minimal example in `MYMODULE.module`:

```php
use Drupal\Core\Entity\EntityInterface;

/** Implements hook_entity_postinsert(). */
function MYMODULE_entity_postinsert(EntityInterface $entity) {
  // Runs after ANY entity is inserted and committed —
  // e.g. queue a job, call an external API, invalidate a front-end cache.
}

/** Implements hook_node_postupdate(): runs after a node update is committed. */
function MYMODULE_node_postupdate(EntityInterface $entity) {
  // Node-specific side effect.
}
```

For each write, the four applicable hooks fire in this order:
`hook_ENTITY_TYPE_post{op}` → `hook_ENTITY_TYPE_postsave` → `hook_entity_post{op}` →
`hook_entity_postsave`. Because dispatch happens on PHP request shutdown, these hooks
run at the very end of the request — which is what makes the entity "definitely
saved." One consequence worth knowing: under `drush php:eval` the shutdown handlers
do not run the same way, so saving an entity there will not synchronously trigger
these hooks. The full signatures, the delete safety-check, and testing notes are in
the [`agent/` hook docs](../agent/hooks/post-hooks.md). The bundled
**Hook Post Action Example** submodule is the quickest working reference.
