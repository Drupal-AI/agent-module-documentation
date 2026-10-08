# Prepend Breadcrumbs — manual setup guide

**Prepend Breadcrumbs** (`prepend_breadcrumbs`) adds one or more fixed items to the
**front** of every page's breadcrumb trail. If you want a consistent navigation
root — a "Home" link, or a section landing page — to lead the breadcrumbs
site-wide, this module supplies those leading items so the rest of the trail builds
on a stable, predictable base.

It builds on the **Menu Breadcrumb** module, which generates the breadcrumb trail
from the menu structure; Prepend Breadcrumbs simply prepends your configured
leading items to whatever that produces. You configure those leading breadcrumbs
(with support for two languages) from a settings form, and they then appear at the
start of the trail on every page, helping both wayfinding and SEO consistency.

This project was spun off from the older *cms_breadcrumbs* project and renamed;
`prepend_breadcrumbs` is the name to use going forward.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Menu Breadcrumb dependency, and enable the module.
2. [Configuration](configuration/index.md) — set the leading breadcrumb items.

## Where it lives in the admin menu

The settings form lives at **Configuration → User interface → Prepend
Breadcrumbs**, where you define the leading breadcrumb items that get prepended to
the trail.
