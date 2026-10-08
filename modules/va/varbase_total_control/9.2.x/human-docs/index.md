# Varbase Total Control Dashboard — manual setup guide

**Varbase Total Control Dashboard** (`varbase_total_control`) gives your site a
ready‑made administration home page — a single dashboard landing page packed with
useful widgets so administrators and editors have their common tasks in one place.
It's built on top of the [Total Control Admin
Dashboard](https://www.drupal.org/project/total_control) module, together with
Panels/Page Manager and the Charts module.

Out of the box the dashboard is a two‑column Page Manager page populated with four
custom blocks: a **user info** panel (a summary of the logged‑in account),
**Quick Links** (handy admin destinations), **Create New Content** (one‑click
shortcuts to create the content types you choose), and **My Site Overview**
(counts of nodes by content type, with optional comment and spam counts). It also
includes a Views block of recent content and can render charts through the Charts
integration.

It's designed to shine as part of the Varbase distribution, but it works
standalone too. Access to the dashboard is gated by the **Have total control**
permission (which comes from the Total Control module), and the module ships a
recipe that grants that permission to the usual editorial roles so you don't have
to wire it up by hand.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its Total
   Control and Charts dependencies) and enable it.
2. [Configuration](configuration/index.md) — reach the dashboard, grant access,
   and customize the widgets.

## Where it lives in the admin menu

The dashboard is a Page Manager page named `total_control_dashboard`. It has no
settings form of its own; you customize it by editing the Page Manager page at
**Structure → Pages** (`/admin/structure/page_manager`) and by configuring each
block instance's settings. Access is controlled through **People → Permissions**
(the *Have total control* permission).

## How to use it

After installing, grant the **Have total control** permission to the roles that
should see the dashboard (or apply the shipped recipe to do this for the standard
editorial roles), then visit the dashboard page. From there you can tailor which
content types appear in the "Create New Content" and "My Site Overview" panels,
rearrange the panes, and add your own. See
[Configuration](configuration/index.md) for the walkthrough.
