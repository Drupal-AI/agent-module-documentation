# Theming Tools — manual setup guide

**Theming Tools** (`theming_tools`) is a suite of test pages for people who build
and maintain **admin themes**. Each of its many small submodules exercises one UI
component or form pattern — buttons, dialogs, tables, pagers, tabs, form widgets,
messages, draggable tables, and so on — so you can render them all in whatever
theme is active and spot rendering regressions visually. None of the test pages
are tied to a specific theme, so the suite works equally well against Claro, Admin,
Olivero, Stark, or any contrib or custom admin theme; the whole point is to surface
cross-theme differences.

It gives you a **dashboard** at `/admin/modules/theming-tools` that lists every test
submodule with enable/disable and bulk operations, plus a "Theming Tools" group
that is auto-injected into the admin navigation menu — every enabled test page shows
up there automatically, sorted alphabetically. Submodules simply tagged as test
pages are auto-discovered, so there is nothing to wire up by hand. It also ships
three fixture themes for exercising the Appearance page (including one deliberately
incompatible theme, to test that code path).

**This module is for local development and regression testing only — do not install
it on a public site.** By design, several of its submodules open admin routes to
anonymous users, ship fixture content types and test data, or disable render
caching. Keep it to development environments, and gate access to trusted developers.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and turn on the test submodules you want.

## Where it lives in the admin menu

The dashboard is at **Extend → Theming Tools** (`/admin/modules/theming-tools`).
From there you enable and disable individual test submodules. Every enabled test
page also appears under a "Theming Tools" group in the admin navigation menu.

## How to use it

Enable the base module, then enable whichever test submodules cover the components
you care about (for example `button`, `dialog`, `table`, `tabledrag`, `dropbutton`,
`textform`, `textarea`) — or enable everything at once from the dashboard. Switch
your active admin theme, walk through the test pages, and compare how each component
renders. A few submodules depend on the Contact contrib module; enable that too if
you use them.
