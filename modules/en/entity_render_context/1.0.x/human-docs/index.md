# Entity Render Context — manual setup guide

**Entity Render Context** (`entity_render_context`) is a **developer/API‑only**
module. It provides one service that renders any entity to an HTML string under a
context you fully control — a chosen theme, acting user account, language, and view
mode — and then always restores the original context afterward, even if something
goes wrong mid‑render.

If you've ever written code to render a node "as the anonymous user" or "in the
email theme," you know the pain: you have to switch the account, switch the theme,
maybe force a language, render, and then remember to switch everything back — and if
the render throws, your switch‑backs never run and the rest of the request is
poisoned. This module packages all of that correctly. You call one method, you get
your HTML, and the framework state is guaranteed to be put back the way it was.

Typical uses include building an HTML email body from a rendered node without
leaking the admin theme, generating a PDF or snapshot from entity HTML in a print
theme, pre‑rendering teasers for a search index with consistent context, rendering
content as anonymous for a decoupled/JSON payload, or previewing access‑controlled
output as a specific user. Renders are cached per request (keyed by entity, view
mode, language, theme, and account) so repeated renders in the same request are
cheap, and you can clear that cache after a large bulk run.

There is **no UI, no routes, no permissions, and no configuration** — it's pure
code. Language switching only kicks in when core's **Language** module is enabled;
everything else works with core alone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs — they include the exact method signatures, the
cache‑key format, and code examples.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — this module has no admin pages. It contributes a single service,
`entity_render_context.renderer`, which you use from your own code.

## How to use it

This is a developer tool, so "using it" means calling the service from code. Inject
`entity_render_context.renderer` (or fetch it with
`\Drupal::service('entity_render_context.renderer')`) and call:

- **`renderEntity($entity, $viewMode, $theme, $account, $langcode)`** — render one
  entity to an HTML string. Everything after the entity is optional: by default it
  renders the **full** view mode, in the **current theme**, as the **anonymous
  user**, in the **entity's own language**. Pass a view mode (for example `teaser`),
  a theme machine name, a user account, or a language code to override any of those.
  On a render error it logs the problem and returns `NULL`.
- **`renderEntities([$a, $b, …], …)`** — render many entities in one call, each
  with its own full context switch. Returns an array in the same order, with `NULL`
  for any that failed.
- **`clearCache($cacheKey = NULL)`** — clear the per‑request render cache; pass
  nothing to clear all of it. Useful after a large bulk render to free memory.

For the full signatures, the cache‑key format, and worked examples (rendering in
German, as user 1, or in a specific theme), see the [`agent/`](../agent/start.md)
docs.
