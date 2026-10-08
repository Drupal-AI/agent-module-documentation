# Countdown — manual setup guide

**Countdown** (`countdown`) provides a block that counts down to — or up from — a
chosen moment, showing days, hours, minutes, and seconds. Point it at a future date
and it shows time remaining ("3 days until launch"); point it at a past date and it
counts up instead ("42 days since we started"). You can configure the display to
show only days, days plus hours, or the full days‑hours‑minutes‑seconds breakdown.

The whole module is essentially one block plugin plus its assets. That has a few
pleasant consequences. Its configuration lives in the **block instance**, so a
placed countdown is exported and imported with the rest of your site
configuration, and you can run **several countdowns at once** — each with its own
target and display. The timer itself runs in JavaScript in the visitor's browser,
so it reflects the visitor's own clock rather than the server's, and it never needs
cache‑busting as time passes.

Its only dependency is core's **Block** module, and it supports a wide core range —
Drupal 8.8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place a Countdown block, set its
   target date, and choose the display format.

## Where it lives in the admin menu

Countdown has no admin settings section of its own. Everything is configured on the
block instance, which you place from **Structure → Block layout**
(`/admin/structure/block`). Where the countdown appears is decided by the block's
own visibility conditions.
