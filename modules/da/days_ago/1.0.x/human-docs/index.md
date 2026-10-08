# Days Ago — manual setup guide

**Days Ago** (`days_ago`) provides a **"days ago" field formatter** for datetime
and timestamp fields. Instead of printing an absolute date, it renders the value
as a relative time — for example "3 days ago" — which reads more naturally in
listings, activity feeds, and "last updated" lines.

It is a purely presentational module: it changes how a date field is *displayed*,
not the value stored in the database and not who can see it. It has no content or
access role, no dependencies beyond Drupal core, and no permissions.

The module works as soon as it is enabled — you simply pick the **Days ago**
format on a date field's display settings. There is no central settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You choose the **Days ago**
formatter per view mode on the field's *Manage display* tab.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage display** (or the equivalent *Manage display* screen for
any entity type): find your date or timestamp field, set its **Format** to **Days
ago**, and save.
