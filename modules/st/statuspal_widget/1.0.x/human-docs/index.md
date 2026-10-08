# Statuspal widget — manual setup guide

**Statuspal widget** (`statuspal_widget`) shows your service's ongoing incidents
from [Statuspal](https://statuspal.io/) — a status-page SaaS — in a small pop-up
right on your Drupal site, so visitors can see the current operational status
without leaving the page. It reads Statuspal's summary endpoint and shows separate
messages for an active incident, a maintenance in progress, and any upcoming
maintenance.

The module provides **two blocks** that work together, and you need to place both:
a **button** block that toggles the messages open and shows a counter of ongoing
incidents (and whether the user has read them yet), and a **message container**
block that holds the messages themselves. Read/unread state is remembered per
visitor in the browser's `sessionStorage`.

Some basic styling ships with it, but you will likely want to override it in your
theme to match your site. There is also a handy **development mode** setting:
switch it on and the widget replaces the live Statuspal data with bundled static
test data (with all incidents marked unread), so you can build and style it without
needing real incidents. It has no dependencies beyond Drupal core and supports
Drupal 9.5, 10, and 11 (this is version 1.0.0-alpha5).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command and enabling the
   module.
2. [Configuration](configuration/index.md) — the settings form, placing the two
   blocks, and development mode.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Statuspal → Widget
settings** (`/admin/config/services/statuspal/widgetsettings`). The two blocks are
placed through **Structure → Block layout** like any other block.
