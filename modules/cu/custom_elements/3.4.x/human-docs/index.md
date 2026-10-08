# Custom Elements — manual setup guide

**Custom Elements** (`custom_elements`) is a framework for rendering Drupal data —
entities, fields, and nested structures — as **custom‑element markup** such as
`<my-teaser title="…">` instead of fully themed HTML. A front end built from web
components (or a framework like Vue or React) then consumes that structure and
decides how it looks, while Drupal keeps deciding *what* appears and in what order.

This is a deliberate middle path between two extremes. *Fully coupled* means Twig
templates and a front end that can't be reused elsewhere. *Fully decoupled* means
the front end fetches JSON and owns all rendering — losing Drupal's preview, layout,
and editorial context. Custom Elements keeps Drupal's **render pipeline, caching,
and access checks** intact while emitting one semantic element per component, so the
front‑end team keeps its component model. This is the approach the **Thunder**
distribution took, which is why one of the submodules carries its name.

The one thing to settle *before* committing to this architecture is the **contract
between the two sides**: element names and attribute names become an API. Renaming
one is a breaking change for the front end, so version the contract, document it, and
decide who owns changes to it. That governance question sinks more of these projects
than any technical limitation.

Custom Elements ships three optional submodules: **Custom Elements UI**
(`custom_elements_ui`) adds a UI to configure custom‑element output per entity view
mode (3.x only), **Custom Elements Thunder** (`custom_elements_thunder`) provides an
example setup for Thunder paragraphs, and **Custom Elements Extra Formatters**
(`custom_elements_extra_formatters`) adds further field formatters. It targets Drupal
10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the settings form and where the
   per‑view‑mode mapping UI lives.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → System → Custom Elements**
(`/admin/config/system/custom-elements`), behind the **Administer site
configuration** permission. The richer per‑entity, per‑view‑mode output mapping is
provided by the **Custom Elements UI** submodule (3.x only).
