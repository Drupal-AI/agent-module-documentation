# Bootstrap Quicktabs — manual setup guide

**Bootstrap Quicktabs** (`bootstrap_quicktabs`) adds two Bootstrap‑styled display
options to the **Quicktabs** module: a **Bootstrap tabs** renderer (tabs or
pills) and a **Bootstrap accordion** renderer (collapsible panels). Quicktabs
lets site builders group blocks, nodes, views, and other content into a single
tabbed widget; this module gives that widget Bootstrap markup so it matches the
rest of a Bootstrap‑based theme instead of the default jQuery UI tab styling.

Under the hood it plugs two tab‑renderer plugins into Quicktabs. The tabs
renderer offers a small options form — tab style (tabs or pills), tab position
(top, left, right, bottom, justified, or stacked), and an optional fade effect —
and produces Bootstrap `nav`/`nav-tabs`/`nav-pills` markup. The accordion
renderer turns each tab into a Bootstrap collapsible panel. Both support the
usual Quicktabs features: Ajax tab loading, "hide empty tabs", and a configurable
default/active tab.

There is **no settings page of its own** — all configuration happens inside the
Quicktabs instance edit form, where you pick one of these renderers. The module
ships a small CSS library and was written against **Bootstrap 3** markup, so it
expects a Bootstrap‑based theme to supply the actual tab/collapse JavaScript and
styling.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Quicktabs is required).
2. [Configuration](configuration/index.md) — the two renderers and their options,
   set inside a Quicktabs instance.

## Where it lives in the admin menu

The module has no admin page of its own. You use it when building or editing a
Quicktabs instance at **Structure → Quicktabs**
(`/admin/structure/quicktabs`), by choosing **bootstrap tabs** or **bootstrap
accordion** as the instance's renderer.
