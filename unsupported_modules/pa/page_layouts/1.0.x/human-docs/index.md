# Page Layouts — manual setup guide

**Page Layouts** (`page_layouts`) defines named sections of a page for use in
structured content such as tutorials or documentation. The idea is to mark up
consistent page sections — steps or blocks — that guided content can reference and
render the same way each time. It builds on core's **Views** module.

> **Heads up — this project is no longer maintained.** Its own project page lists
> it as *Unsupported* and *Obsolete* ("No longer in use"), and it has no security
> advisory coverage. Treat it as end‑of‑life: it is documented here for
> completeness, but for a new build you should look for a supported alternative
> rather than adopting it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. Once enabled, it defines
its page sections and relies on core Views for rendering.

## Where it lives in the admin menu

Page Layouts adds no configuration page of its own. Because it depends on Views,
any related listings are managed through the standard Views UI at **Structure →
Views** (`/admin/structure/views`).
