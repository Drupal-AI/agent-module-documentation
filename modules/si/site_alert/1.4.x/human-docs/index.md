# Site Alert — manual setup guide

**Site Alert** (`site_alert`) lets administrators show a site‑wide alert banner
to every visitor — a maintenance notice, a downtime warning, or a general
announcement like "New feature launched". You can run several alerts at once,
each with a **low / medium / high** severity that the theme styles differently,
and you can optionally schedule an alert to appear and expire on set dates.

The banner is rendered through a **Site Alert** block that you place in a theme
region. Its key trick is that it stays fresh via **AJAX**: the block polls the
server on a timer, so a scheduled alert still appears (and disappears) on time
even on a fully page‑cached site. The alert region is wrapped in an
`aria-live="polite"` container, so screen readers announce it accessibly.

Each alert is stored as a small content entity with a label, an active flag, a
severity, the message, and an optional start/end schedule. The module depends on
two core modules, **Datetime Range** (`datetime_range`) and **Options**
(`options`), which Drupal enables for you. It has no submodules, provides four
permissions and a set of Drush commands, and works on Drupal 8 through 11.
Enabling the module gives you the management UI, but nothing shows to visitors
until you create an alert **and** place the block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the `GetAlerts`
service and entity API — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create alerts, place the block, set
   its refresh timeout, and (optionally) manage alerts from the command line.

## Where it lives in the admin menu

Alerts are managed at **Configuration → System → Site Alerts**
(`/admin/config/system/site-alerts`). The banner itself is a block you place
under **Structure → Block layout**.

## How to use it

Create one or more alerts on the Site Alerts admin page (message, severity, and
an optional schedule), then place the **Site Alert** block in a region. Active
alerts within their scheduled window appear to all visitors. See
[Configuration](configuration/index.md) for the details, including the block's
refresh timeout and the Drush commands for scripting alerts from a deploy
pipeline.
