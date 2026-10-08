# PTools — manual setup guide

**PTools** (`ptools`) is a library of utility and helper classes for other Drupal
modules. It is a **developer dependency**: it bundles reusable helper classes (and a
`ptools_queue` submodule) so that contrib and custom modules can share common utilities
instead of re‑implementing them.

PTools ships **no site‑facing features of its own** — there are no content types,
fields, blocks, or settings screens for a site builder to use. You install and enable it
because another module requires it, or because you are writing code that builds on its
utilities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and the optional queue submodule).

There is **no configuration page** for this module — it has no settings form and no
site‑facing UI.
