# Licenses — manual setup guide

**Licenses** (`licenses`) gives you an at‑a‑glance overview of **all the software
licences in use across your Drupal project** — the licences that apply to core,
contrib, and custom modules and themes, and to Composer‑installed dependencies.
It's a reporting and auditing tool, aimed squarely at **software‑licence
compliance**: when you need to know, and document, which licences your site is
built on, this collects that information into one place.

The module currently reports on:

- **Composer‑installed dependencies** (the packages in your `vendor` tree).
- **Core, contrib, and custom modules.**
- **Core, contrib, and custom themes.**
- **npm or Yarn packages** installed in themes (listed, though without the actual
  licence at present).

The information is administrative — it's an overview for site maintainers and
whoever handles compliance — and it is gated by the module's own permission. The
module has no content‑editing or access‑control role beyond providing this report.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** for this module — once enabled and the permission is
granted, you simply read the overview page it provides. There is nothing to
configure.

## How to use it

1. Enable the module.
2. Grant the module's licence‑information permission (under **People →
   Permissions**) to the roles that need to review licence data — typically a site
   administrator or compliance role.
3. Open the Licenses overview page from the admin area to see the detailed
   breakdown of licences across your dependencies, modules, and themes. Use it
   whenever you need to audit or document the site's licence footprint.
