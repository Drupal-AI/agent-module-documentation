# ComputerMinds tools — manual setup guide

**ComputerMinds tools** (`cm_tools`) is a small grab-bag of unrelated conveniences
written by the [ComputerMinds](https://www.computerminds.co.uk/) agency. Rather than
one feature, it bundles several independent tools — you enable the module and use
only the pieces you need; the rest stay dormant.

What's in the box:

- **Uptime monitoring endpoint** — a stable, secret URL
  (`/cm_tools/monitoring/{token}`) that external monitors like UptimeRobot,
  StatusCake or NewRelic can poll. It skips the page cache and returns a constant
  marker plus the current server time, so a successful poll proves the site really
  booted. It even answers while the site is in maintenance mode. After enabling the
  module, the full URL (with its secret token) is shown to you on the status report
  at **Reports → Status report** (`/admin/reports/status`).
- **Paragraphs table** — a field formatter and a matching form widget that display
  and edit a Paragraphs field as a compact table (one column per field) instead of
  the usual stacked cards. Requires the **Paragraphs** module. Set them on the
  field's **Manage display** / **Manage form display** as "Paragraphs table - CM
  Tools".
- **Page level validation** — a Webform handler that shows a whole-form error
  message, controlled by the Webform **Conditions** tab, optionally limited to
  chosen wizard pages. Requires the **Webform** module. Add it under a webform's
  **Settings → Handlers**.
- **Developer helpers** — a session-based cache context and PHP helper classes for
  array manipulation and locale translations, used from custom code.
- **Update report sort** — automatically sorts the available-updates report so
  security updates float to the top; nothing to configure.

It has **no permissions and no settings form of its own**, and it depends on no
other module out of the box (the Paragraphs and Webform features only activate if
those modules are installed). It runs on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Using each tool

- **Monitoring**: enable the module, then read the monitoring URL off the status
  report and paste it into your external uptime service. There's nothing else to
  set up — the secret token is generated automatically.
- **Paragraphs table**: on the entity that has the Paragraphs field, go to **Manage
  form display** and choose the "Paragraphs table - CM Tools" widget (pick the form
  display mode whose fields become columns), and/or **Manage display** and choose
  the matching formatter (pick the view mode whose fields become columns). Works
  best when the field allows a single paragraph type.
- **Page level validation**: on a webform, **Settings → Handlers → Add handler →
  Page level validation**, enter the message, then use the handler's **Conditions**
  tab to control when the error appears.

There is **no single configuration page** — each tool is used where it belongs
(status report, field display settings, webform handlers, or code).
