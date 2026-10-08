# Node Title — manual setup guide

**Node Title** (`node_title`) adds a second, supplementary title field to every node.
It declares an extra `node_title` base field on nodes and places it in a collapsible
**Node Title** group in the advanced sidebar of the node edit form. Use it when a node
needs an additional or alternate title alongside the standard one — for example a
marketing headline, a legacy secondary title, or an internal label that should live
next to (not replace) the main title.

Because it is added as a base field, the field is available on **all content types at
once** without you configuring a field per bundle. The value is optional per node, and
you can read it in Twig templates, custom display logic, or expose it to Views like any
other node field.

The module is deliberately small and code‑only: it has no routes, permissions,
services, or settings. There is nothing to configure — enable it and the extra title
field appears on node forms automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit any node. In the advanced sidebar of the edit form you'll find a collapsible
   **Node Title** group containing the extra title field.
3. Enter a value if the node needs one; leave it empty otherwise.
4. To show the value, reference the `node_title` field in your theme (Twig), in a
   custom display, or add it as a field in a View.
