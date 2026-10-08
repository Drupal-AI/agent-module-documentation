# Plugins and Services — manual setup guide

**Plugins and Services** (`plugins_and_services`) is an in‑admin API browser for
developers. It adds two pages to the Reports section: one that lists **all plugins
by plugin manager**, and one that lists **all services** in your Drupal
installation. For each class it shows the class information, its functions, and all
the corresponding documentation comments — so you can explore the available
classes, methods, and their docs without leaving the site or digging through source
files.

It also adds a small **"What does it do?"** helper: for a given plugin or service,
it runs a Google search and returns information about what that plugin or service
does — a quick way to orient yourself when you meet an unfamiliar class.

It is a developer reference and discovery tool. It has no content role of its own,
and its pages live under Reports.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. It
is a read‑only browser, described in "Where it lives in the admin menu" below.

## Where it lives in the admin menu

Once enabled, the two browser pages appear under **Administration → Reports**
(`/admin/reports`) — one listing plugins by plugin manager, the other listing
services. Viewing them requires the report/permission the module provides, so grant
it to the roles that should see this introspection.

## How to use it

1. Go to **Administration → Reports** and open the **Plugins** or **Services**
   browser page.
2. Browse the classes; for each you can see its functions and their documentation
   comments.
3. When you meet an unfamiliar plugin or service, use the **"What does it do?"**
   helper to look it up.
