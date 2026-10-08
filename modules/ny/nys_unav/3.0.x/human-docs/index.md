# NYS Universal Navigation — manual setup guide

**NYS Universal Navigation** (`nys_unav`) makes it easy to display the **New York
State Universal Navigation** — the standardized header and footer bars that every
official New York State website is required to show, surrounding all other content.
The bars are delivered as iFrames (from NYS‑hosted assets), and this module handles
embedding them on a Drupal site.

By default the module **automatically inserts** the Universal Navigation at the top
and the Universal footer at the bottom of every page, outside your page's HTML.
If you need more control over placement, it also provides two **blocks** — **NYS
uNav Header** and **NYS uNav Footer** — that you can position through your theme, and
it exposes two functions you can call from theme templates.

This is a **site‑structure / branding** integration with no access‑control role; it
displays required government navigation and nothing more. A settings form lets you
control how the navigation is applied. It works across Drupal 8.8 through 11.

> **Usage restriction.** This module was built for New York State agencies and
> official NYS websites, to comply with ITS mandate policy NYS‑S05‑001. For use on
> other sites, contact the NYS Office of Information Technology Services WebNY team
> (webnysupport@its.ny.gov) for guidance and authorization.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and how to place the
   header/footer blocks.

## Where it lives in the admin menu

The module's settings form is at route `nys_unav.form`. If you choose to place the
navigation manually rather than let it auto‑insert, the **NYS uNav Header** and
**NYS uNav Footer** blocks are placed from **Structure → Block layout**
(`/admin/structure/block`). See [Configuration](configuration/index.md).
