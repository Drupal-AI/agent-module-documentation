# Sitewide Alert — manual setup guide

**Sitewide Alert** (`sitewide_alert`) puts a dismissible announcement banner at
the top of every page of your site — the kind of message you use for a
maintenance window, an outage notice, a holiday-closing note, or a timed
promotion. Each alert is a normal content entity, so you create, schedule,
style, and target alerts through ordinary add/edit forms in the admin UI without
writing any code.

Alerts are fieldable, revisionable, and translatable. Every alert has an
administrative name, a rich-text message, an **Active** (published) flag, a
style (color/severity), an optional **dismissible** flag, optional scheduling (a
start and end date/time), and optional page-visibility rules so you can show a
banner only on certain paths — or everywhere except certain paths. Because the
banner is loaded on the client from a small JSON endpoint (`/sitewide_alert/load`),
it appears even on fully page-cached sites and can refresh without a full reload.
A server-side-render option is available if you need the banner to work without
JavaScript.

Visitors can dismiss an alert without logging in — the dismissal is remembered
per browser in localStorage. If you make an important edit to an alert that
people have already dismissed, an "Ignore dismissals before" timestamp forces it
to reappear. Two optional submodules extend delivery: **Sitewide Alert Block**
renders alerts inside a placeable block instead of pinning them to the top of the
page, and the experimental **Sitewide Alert Domain** scopes alerts to specific
domains on a multi-domain install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the global settings form (styles,
   refresh interval, admin-page display and more), plus how to create individual
   alerts and the permissions that gate them.

## Where it lives in the admin menu

Individual alerts are managed as content: **Content → Sitewide alerts**
(`/admin/content/sitewide_alert`), with an add form at
`/admin/content/sitewide_alert/add`. The global settings that apply to all
alerts sit at **Configuration → Sitewide Alerts**
(`/admin/config/sitewide_alerts`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Grant the **view published sitewide alert entities** permission to the roles
   that should see banners — including anonymous, if that's your audience.
3. Go to **Content → Sitewide alerts → Add**, write your message, choose a
   style, tick **Active**, and (optionally) turn on **dismissible**, a schedule,
   or page targeting.
4. Save. The banner appears at the top of the pages you targeted.

Prefer the command line? You can create, enable, disable, and delete alerts
entirely with Drush — handy for automated or scheduled announcements. See the
Drush section in [Configuration](configuration/index.md).
