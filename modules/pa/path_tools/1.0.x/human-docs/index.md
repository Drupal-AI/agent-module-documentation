# Path tools suite — manual setup guide

**Path tools suite** (`path_tools`) is a small collection of path‑based utilities
and APIs for site builders and developers. Path‑based logic is a familiar Drupal
pattern — core's default breadcrumb builder, for instance, uses the path to build
the breadcrumb — and this module extends that idea to other parts of a project so
you can lean on paths where they make editorial sense.

Two features ship in this release:

- **Path‑based breadcrumbs for Taxonomy Terms** — build a term's breadcrumb from
  its path, an approach editors find easy to understand.
- **A "Parent entity from path" service** — a developer API for resolving the
  parent entity implied by a given path, usable from your own custom code.

It's a developer/site‑builder tool with no content or access‑control role of its
own. It builds on the **Form Decorator** module, which it requires.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   its Form Decorator dependency, then enable it.

There is **no dedicated configuration page** for this module — it provides
path‑based building blocks (a breadcrumb behaviour and a service) rather than a
central settings form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. For **path‑based term breadcrumbs**, taxonomy term pages will build their
   breadcrumb from the path — no code required.
3. For the **"Parent entity from path" service**, call it from your own module or
   custom code where you need to resolve the parent entity for a given path.
