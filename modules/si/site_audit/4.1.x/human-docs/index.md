# Site Audit — manual setup guide

**Site Audit** (`site_audit`) is a static site-analysis platform for Drupal. It
runs a suite of best-practice checks against your site and produces a report — with
concrete, actionable recommendations — that you can read as an admin page or
generate from the command line in text, HTML, JSON, or Markdown. It's a favourite
tool for site reviews, client hand-offs, and pre-launch audits.

The analysis is organised into **reports** (called checklists) made up of
individual **checks**. Thirteen reports ship out of the box — covering best
practices, blocks, cache, codebase, content, cron, database, extensions, security,
status, users, views, and watchdog/log volume — with around sixty checks in total.
Each check scores PASS, WARN, FAIL, or INFO, and a report rolls those up into a
percentage. The analysis is **static and non-intrusive**: it inspects
configuration and the database, it does not hammer the running site with requests.

You run it either from **Drush** (`drush audit`, `drush audit-all`,
`drush audit-list`) — the most common way, and the only way to get JSON/Markdown
output or to redirect a report to a file — or from an **admin page** at
`/admin/reports/site-audit`. A small settings form lets you limit which reports the
admin page runs. Site Audit is also extensible: other modules can add their own
reports and checks, and two optional submodules let you save reports over time or
send them to a remote server on a schedule.

This guide is written for a **human** clicking through the admin UI and terminal.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the optional submodules.
2. [Configuration](configuration/index.md) — running the audit (Drush and the admin
   page), the settings form, and how scoring works.

## Where it lives in the admin menu

The report page sits under **Reports → Site Audit**
(`/admin/reports/site-audit`), and its settings are on the **Settings** tab there
(`/admin/reports/site-audit/settings`). Both require the **Administer site
configuration** permission. Note that the module's info file has no "configure"
link, so reach the settings via that Settings tab.
