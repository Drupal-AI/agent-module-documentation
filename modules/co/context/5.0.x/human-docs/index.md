# Context — manual setup guide

**Context** (`context`) lets you define reusable "sections" of your site as a set
of **conditions** plus **reactions**: when the conditions match the current
request, the reactions fire. A reaction can place blocks into theme regions,
switch the theme, add a CSS class to the `<body>` tag, override the page title,
add Twig template suggestions, set the active menu trail, or disable regions. It
is a powerful, centralized alternative to scattered per‑block visibility rules.

Everything is built around a single `context` **config entity**. Each context
holds a list of conditions — which **reuse Drupal core's standard Condition
plugins** (request path, user role, node type, language, and a few Context adds of
its own) — and a list of reactions, which are Context's own plugin type. You
choose whether *all* conditions must pass (AND) or *any* (OR); a context with no
conditions is treated as sitewide. Because contexts are config entities, they
export and deploy with the rest of your configuration.

This is a **release candidate** (5.0.0‑rc2). It declares no other module
dependencies. Note that the base module ships only the entity, plugins, and
services — **the admin UI for building contexts lives in the bundled
`context_ui` submodule**, which you enable to get the interface at
*Structure → Context* (`/admin/structure/context`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and turn on the `context_ui` submodule.
2. [Configuration](configuration/index.md) — how to build a context: conditions,
   the "all vs any" toggle, and the available reactions.

## Where it lives in the admin menu

Once you enable the **Context UI** submodule, the context builder lives at
**Structure → Context** (`/admin/structure/context`). There you can add, edit,
group, weight, duplicate, and disable contexts. Managing contexts requires the
**Administer contexts** permission. The base **Context** module on its own adds no
menu item — it only provides the underlying entity and plugins.

## How to use it

1. Enable the `context_ui` submodule (see [Installation](installation/index.md)).
2. Go to **Structure → Context** and add a context.
3. Add one or more **conditions** (for example a request‑path pattern or a user
   role) and choose whether all of them must match or any of them.
4. Add one or more **reactions** — most commonly the **blocks** reaction to place
   blocks into regions for the matched pages.
5. Save. On every request, Context evaluates each context and applies the
   reactions of the ones whose conditions pass.

See [Configuration](configuration/index.md) for the full list of conditions and
reactions.
