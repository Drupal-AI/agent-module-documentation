# Advanced Render Auditor — manual setup guide

**Advanced Render Auditor** (`ara`) is a **render‑tree profiler** for local
development. Drupal builds every page from a tree of render arrays, each carrying
its own cache metadata; this module traces that tree so a developer can see what
was rendered, how it was cached, and where the performance cost sits. It is a
debugging aid for people building and theming a site, not a visitor‑facing
feature.

Reach for it when you are trying to understand why a page renders the way it
does, why something is (or is not) being cached, or where rendering time is
going. It profiles the render tree of pages and surfaces that information for
inspection.

This is a **development tool for local or dev environments — not production.**
Its output is gated behind a single permission, **Use ara profiler**, so it is
only ever visible to the roles you grant it to; even so, treat it as a dev‑only
module and keep it off live sites. It depends only on core's System module and
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the profiler permission.

## How to use it

After enabling the module, grant the **Use ara profiler** permission
(**People → Permissions**) to the role you develop under — typically a developer
or administrator role on a local/dev environment. With that permission in place,
the profiler traces the render tree as you browse pages, so you can inspect what
each part of the page rendered and how it was cached. Because it is a dev tool,
leave the permission ungranted (or the module uninstalled) on production.
