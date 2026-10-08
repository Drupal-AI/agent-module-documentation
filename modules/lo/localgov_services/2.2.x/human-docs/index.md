# LocalGov Services: Core — manual setup guide

**LocalGov Services: Core** (`localgov_services`) is the foundation of the **LocalGov
Drupal** service model — the way councils organise content around *services* like
"Bins and recycling" or "Parking", each with a landing page, sections beneath it, and
many detail pages that all share one navigation tree.

As its own description says, the core module **"won't do anything on its own."** It
provides the shared groundwork — it installs the top‑level and second‑level service
node types, a dedicated **`localgov-services-menu`**, and Pathauto patterns so
service URLs automatically mirror the service hierarchy — and then you enable the
**submodules** for the parts of the model you need. This keeps the feature modular:
turn on landing pages, sublanding pages, ordinary service pages, shared navigation
and status updates independently.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the core
   module, and choose the submodules that make up the service model.

This module has **no configuration page**. You use it by enabling the right
submodules and then creating service content; URLs and menus are configured for you
through the Pathauto patterns and the services menu it installs.

## Where it lives in the admin menu

The core module adds no settings screen. Once you enable its submodules you work
from the usual places:

- Create service content at **Content → Add content** (Landing page, Sub‑landing
  page, Page, Status — depending on which submodules are enabled).
- The shared **Services** menu is at **Structure → Menus →
  localgov-services-menu**.
- Service URL patterns live in Pathauto at **Configuration → Search and metadata →
  URL aliases → Patterns**.

## How to use it

1. Enable the core module and the submodules you need (see
   [Installation](installation/index.md)):
   - **Landing page** — the top‑level page for each service.
   - **Sub‑landing page** — second‑level pages for large services.
   - **Page** — ordinary content pages within a service.
   - **Navigation** — the navigation tree shared across a service's pages (and for
     linking external pages into the tree).
   - **Status** — status updates attached to a service landing page, for "bin
     collections delayed"‑style notices.
2. Create a **Landing page** for a service, then add sub‑landing and content pages
   beneath it. The hierarchy and the services menu give residents consistent
   navigation, and URLs mirror the structure automatically.

Note that service **search** comes from the separate **LocalGov Search** module — if
you want services to be searchable, enable that too. LocalGov Services is part of the
LocalGov Drupal distribution and expects it to be present.
