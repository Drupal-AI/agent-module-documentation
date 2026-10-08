# Gin Toolbar Local Tasks — manual setup guide

**Gin Toolbar Local Tasks** (`gin_toolbar_local_tasks`) moves a page's **local
tasks** — the row of tabs such as *View / Edit / Delete* or *Manage fields /
Manage display* — up into the **toolbar**, so editorial actions live in one
consistent place instead of sitting inline on the page. It's a small
quality‑of‑life tweak for the admin/editor experience, especially on sites using
the Gin admin theme.

Despite the name, this **2.x release no longer depends on Gin Toolbar**. When the
module was first written it was thought Gin Toolbar was required, but in practice
it only needs core's **Toolbar** module. If you're coming from the 1.x release
(which did carry the Gin Toolbar dependency), read the project's release notes for
the upgrade steps.

There is nothing to configure — enable the module and the local tasks relocate
into the toolbar automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. It
takes effect as soon as it is enabled.

## Where it lives in the admin menu

The module adds no admin page of its own. Its effect is visible on every admin
page that has local‑task tabs: those tabs now appear in the toolbar rather than
inline on the page.
