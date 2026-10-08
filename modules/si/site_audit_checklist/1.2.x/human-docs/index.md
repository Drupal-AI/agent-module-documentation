# Site Audit Checklist — manual setup guide

**Site Audit Checklist** (`site_audit_checklist`) gives site builders and developers a
simple, customizable checklist for tracking the tasks that need doing before a site
goes live. It is the digital version of the pre-launch list every team keeps — things
like configuring caching, setting up redirects, and checking accessibility — kept in
one dashboard so nothing important is quietly forgotten on launch day.

The checklist is rendered as an admin **dashboard** where you can see each task and its
status, update tasks one at a time as you complete them, and export the whole list to
**CSV** for a record or for sharing with stakeholders. The default set of tasks ships
with the module (defined in a YAML file), and because it is YAML you can customize the
list to match your own team's launch process.

The module works the moment you enable it — the default checklist is ready to use with
no configuration. It has no dependencies and contacts no external services; everything
lives in the admin area. Access is split cleanly into two permissions: one to view the
dashboard and one to change tasks or export. Note that this project is **not covered by
Drupal's security advisory policy**, which is worth weighing for a production install.

This guide is written for a **human** using the module through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The dashboard is at **`/admin/config/development/site-audit`**. Viewing it requires the
**`view site audit checklist`** permission; updating individual tasks (at
`/admin/config/development/site-audit/update/{task_id}`) and exporting to CSV (at
`/admin/config/development/site-audit/export/csv`) require the
**`administer site audit checklist`** permission. There are no anonymous-facing pages —
everything sits inside the admin area.

## How to use it

Enable the module, then open the dashboard to see the default tasks. Work through them,
marking each task's status as you go, and export to CSV whenever you want a snapshot of
launch readiness. To tailor the tasks to your own process, edit the checklist YAML that
ships with the module (`site_audit_checklist.checklist.yml`). Uninstalling the module
removes the dashboard and its stored task state.
