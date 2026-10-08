# Plugin Report — manual setup guide

**Plugin Report** (`plugin_report`) gives Drupal developers a built‑in **Reports
page** — and a set of Drush commands — for introspecting every
`DefaultPluginManager` registered in the container and all the plugins each one
exposes. Instead of grepping through source files to understand which plugin types
exist and what they provide, you browse the plugin system live from the admin UI or
the terminal.

In the admin UI it offers three views. A **plugin managers list** shows all
`DefaultPluginManager` services, sortable by service ID, provider, alter hook,
subdirectory, discovery mechanism, plugin interface, and class. Clicking a manager
opens its **plugins list**, and clicking a plugin opens a **plugin detail** page
with the full definition, default configuration, element info, and every PHP
interface the plugin implements. A client‑side filter narrows any table in real
time without reloading the page.

For terminal work it ships Drush commands — `plugin-report:managers`,
`plugin-report:plugins {manager}`, and `plugin-report:plugin {manager} {plugin}` —
that output as table, JSON, YAML, or CSV, with filtering by any field.

It is a developer/debugging tool. Access is gated by core's **Access site reports**
permission — grant it only to roles that should see this introspection. (The
maintainer notes the module was built with AI assistance and reviewed and tested by
a human who takes responsibility for the code.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. It
is a read‑only report, described in "Where it lives in the admin menu" below.

## Where it lives in the admin menu

Once enabled, the report sits at **Administration → Reports → Plugins**
(`/admin/reports`, then the *Plugins* entry). Any user with the **Access site
reports** permission can open it.

## How to use it

1. Go to **Administration → Reports → Plugins**.
2. Browse the list of plugin managers; use the client‑side filter box to narrow it.
3. Click a manager's **Service ID** to see the plugins it provides.
4. Click a plugin's **ID** to see its full definition, default configuration, and
   implemented interfaces.

Prefer the command line? Run `drush plugin-report:managers`,
`drush plugin-report:plugins {manager}`, or
`drush plugin-report:plugin {manager} {plugin}`, adding `--format=json` (or `yaml`,
`csv`) as needed.
