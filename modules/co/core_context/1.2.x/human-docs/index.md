# Core Context — manual setup guide

**Core Context** (`core_context`) is a developer plumbing module. It lets you attach
ctools‑style **context values** to any entity and then makes those values available
as runtime contexts — the kind that context‑aware plugins (blocks, layouts, Page
Manager variants) can read. In plain terms: you can stash a value on a node,
content type, or view display, and have context‑aware blocks pick it up when that
entity is viewed or laid out.

There is **no admin UI** — this module is aimed at developers and site builders who
work through code and configuration. You store contexts in one of two ways: on a
fieldable entity, in a hidden `context` field the module provides; or on a config
entity (a content type, a view display, a menu), in its third‑party settings. Either
way, each stored context is a small record of an `id`, a data `type` (like `string`,
`integer`, or `entity:node`), a `label`, a `description`, and a `value`.

Those stored values are then surfaced through several **context providers**: a
generic aggregator, a provider that exposes an entity's contexts at its canonical
route (so, for example, the current node's contexts are available on `/node/{nid}`),
and — when Layout Builder is installed — a provider plus a render subscriber that
injects the entity's contexts into context‑aware components inside its layout. The
result is a lightweight way to feed entity‑scoped values into context‑aware
rendering without wiring up a heavier page‑building stack.

Core Context requires **ctools**, and it plays nicely with **Layout Library**
(pairing reusable layouts with layout‑specific contexts) and **Page Manager**
(exposing entity contexts to variants), though neither is required.

This guide is written for a **human** working through the admin UI and code. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   ctools) and enable it.

## Where it lives in the admin menu

Nowhere — Core Context has no settings page, no permissions, and no Drush commands.
You attach and read contexts programmatically or through exported configuration.

## How to use it

Because there is no UI, you work with contexts in code/config. A context is a small
map:

```yaml
my_flag:
  type: string          # e.g. 'string', 'integer', 'entity:node', 'boolean'
  label: 'My Flag'
  description: ''
  value: 'on'           # for entity:* types, use the entity UUID
```

- **On a config entity** (content type, view display, menu — anything implementing
  third‑party settings), store contexts under the `core_context` / `contexts`
  third‑party setting:

  ```php
  $display->setThirdPartySetting('core_context', 'contexts', [
    'my_flag' => ['type' => 'string', 'label' => 'My Flag', 'description' => '', 'value' => 'on'],
  ]);
  $display->save();
  ```

- **On a fieldable entity** (like a node), add a field of the module's `context`
  field type (it is `no_ui`, so add it in code), then append items to it.

- **Read them back** through the entity's `context` handler:

  ```php
  $handler = \Drupal::entityTypeManager()->getHandler($entity->getEntityTypeId(), 'context');
  $contexts = $handler->getContexts($entity);   // keyed by context id
  ```

Once stored, the contexts flow automatically to context‑aware blocks at the entity's
canonical route and inside its Layout Builder layout. To extend the system, register
a service implementing `ContextProviderInterface` and tag it
`core_context.context_provider`, and it will be aggregated under the generic
`core_context` provider.
