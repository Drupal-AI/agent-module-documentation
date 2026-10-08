# Copyright Block — manual setup guide

**Copyright Block** (`copyright_block`) gives you a block that shows a copyright
notice with an automatically maintained year range. You set a **start year** and
a **separator**, and the block appends the current year on its own — so a footer
line like "© 2015 – 2026 Company" stays correct forever, rolling over on
January 1 with no manual edits and no hardcoded year in your templates.

The clever bit is a small token, `[copyright_statement:dates]`, that you place
inside the block's text. It expands to just the start year when the site launched
this year, or to `start<separator>current` (for example `2015 – 2026`) once the
current year is later. Because the message body is a rich‑text field, you can wrap
that token in a longer legal sentence, add links, and style it however you like.

There is **no separate settings page** for this module. You configure everything
per block when you place it, with optional site‑wide defaults for the separator
and text stored in configuration. You can place several copyright blocks in
different regions, each with its own text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The block has no admin settings route. You place and configure it from
**Structure → Block layout** (`/admin/structure/block`) like any other block.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and, in the region you want (usually the
   footer), click **Place block** and choose **Copyright block**.
3. Fill in the block form:
   - **Start year** — a number from 1900 to the current year; the first year of
     the range (required).
   - **Separator** — the text printed between the start and current year, for
     example `-`, `–`, `to`, or `/` (required; default `-`).
   - **Copyright statement text** — the message body, edited with a rich‑text
     format. A token browser link is shown so you can insert
     `[copyright_statement:dates]`. **Keep that token in the text** — it is what
     renders the year(s).
4. Save. The block renders the notice, and the "to" year automatically tracks
   today's year.

### Site‑wide defaults

New block instances default the start year to the current year and pull the
separator and text from the `copyright_block.settings` configuration object (out
of the box: separator `-`, text "Copyright", format `basic_html`). You can adjust
those defaults with Drush, for example:

```bash
drush config:set copyright_block.settings separator ' – ' -y
```
