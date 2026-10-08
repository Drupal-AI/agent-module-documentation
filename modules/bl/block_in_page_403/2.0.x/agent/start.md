<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block In Page 403 (block_in_page_403) — agent index

Adds a **block-visibility condition** ("Show in page 403") so a chosen block renders on the **403
access-denied page**. Package `Administration`. Depends only on core **`block`**. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.1.

- **The `page_403` condition plugin — how it evaluates, config, schema, how to use it** →
  [plugins/page-403-condition.md](plugins/page-403-condition.md)

## What it actually is

- One core **Condition** plugin: `Page403Request` (id **`page_403`**, label *"Page 403"*), in
  `src/Plugin/Condition/Page403Request.php`, extending `ConditionPluginBase` and implementing
  `ContainerFactoryPluginInterface`.
- It surfaces as a **"Show in page 403"** checkbox inside every block's *Visibility* settings
  (Structure → Block layout → block config). No routes, no permissions, no services, no hooks, no
  `.module`/`.install`, no menu links, no settings form of its own.
- Provides `config/schema/block_in_page_403.schema.yml` (a condition-plugin schema fragment) and a
  README. That's the entire project.

## Mechanism (from source)

- `evaluate()`: if config `page_403 == 1`, reads `request_stack->getCurrentRequest()
  ->attributes->get('exception')` and returns TRUE only when `$exception->getStatusCode() == 403`,
  else FALSE. If the box is **unchecked**, `evaluate()` returns TRUE (inert — never restricts).
- The core condition resolver applies **negate** (`Do not return true on the following page 403.`).
- `getCacheContexts()` adds `url.path`. `buildConfigurationForm()` renders a static `<h5>Page 403</h5>`
  label plus the checkbox; `submitConfigurationForm()` stores the boolean.

## Nature (not an access-control module)

- This is an **additive block-visibility condition** — like any core condition it can only *narrow*
  where a block appears; it is layered on top of the block's own access/visibility and cannot reveal
  a block a user otherwise could not see. Blocks on the 403 page still render through core's normal
  block access pipeline. The 403 itself still denies the requested resource; this only enriches the
  denial page's content.
