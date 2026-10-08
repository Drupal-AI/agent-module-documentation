# Entity Route Context — manual setup guide

**Entity Route Context** (`entity_route_context`) is a small **developer utility**.
It provides a plugin *context* for "the entity whose page you're currently on" —
for any entity type, not just nodes — plus a helper service that maps routes to the
entity types that own them. Think of it as a generic, entity‑type‑agnostic version
of core's built‑in `node_route_context`.

Why is that useful? Core ships a route context only for nodes, so a block or Layout
Builder component that wants to react to "the current entity" has to hard‑code node
logic. With this module enabled, you get a **canonical_entity** context ("Entity
from route") that matches *any* entity type, and one **canonical_entity:{type}**
context per entity type so a site builder can target, say, only taxonomy‑term pages.
At runtime the module inspects the current route; if it's an entity link template
(canonical, edit‑form, delete‑form, and so on), it hands the matching entity to your
plugin as context.

The second half is the **route helper** service, which answers questions like
"which entity type owns this route name?", "what routes does this entity type have,
keyed by link template?", and "what entity type and link template does the current
route match resolve to?". It builds this map once by walking every entity type's
link templates and caches it permanently, rebuilding automatically when entity types
or routes change.

There is **no UI, no configuration, no permissions, and no entities** — it's pure
code you consume from your own plugins and modules. It requires **PHP 8.3+** and
**Drupal 11.1 or newer**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs — they include the exact service methods and code
examples.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — this module has no admin pages. Its two contexts simply become available
to the context system (blocks, Layout Builder, Display Suite, condition plugins)
once the module is enabled, and its route‑helper service is available for injection
in your own code.

## How to use it

This is a developer tool, so "using it" means consuming it from code:

- **From a block or Layout Builder component:** declare a context definition for an
  entity, and the site builder can wire it to **Entity from route** (the generic
  `canonical_entity` context) or to a type‑specific one such as
  `canonical_entity:taxonomy_term`. Your plugin then receives the current page's
  entity without any node‑specific code. This is how you add a contextual block on
  media, user, or custom‑entity pages the same way you would on nodes.
- **From custom code:** inject the `entity_route_context.route_helper` service (or
  fetch it with `\Drupal::service('entity_route_context.route_helper')`) to ask
  which entity type owns a route, to list an entity type's routes by link template,
  or to resolve the current route match back to its entity type and link template.

For the exact method signatures, return types, and worked examples, see the
[`agent/`](../agent/start.md) docs, which document both services in detail.
