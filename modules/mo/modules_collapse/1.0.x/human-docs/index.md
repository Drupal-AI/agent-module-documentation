# Modules Collapse — manual setup guide

**Modules Collapse** (`modules_collapse`) is a lightweight convenience module that
makes the package groups on the **Extend** page (`/admin/modules`) **collapsed by
default**. On a site with many modules, the Extend page is a long scroll; collapsing
each package group up front turns it into a tidy, scannable list you expand only where
you need to.

This behaviour is built into the Admin Menu project, but if you use the **Navbar**
module instead you lose it. Modules Collapse simply puts that functionality back, with
no dependencies and nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is no settings form — the module works the moment you enable it.

## Where it lives in the admin menu

Modules Collapse adds no admin page of its own. Once enabled, go to **Extend**
(`/admin/modules`) and the package groups will appear collapsed by default; click a
group heading to expand it.
