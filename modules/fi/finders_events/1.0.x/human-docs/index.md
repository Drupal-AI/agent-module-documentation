# Finders Events — manual setup guide

**Finders Events** (`finders_events`) extends the [Finders](https://www.drupal.org/project/finders)
framework with an **Events** finder type. Where the base Finders module lets editors
build searchable, filterable listing channels, this module adds a channel type
purpose-built for events: entries can carry **recurring dates** (via the Date Recur
module), and channels can present their entries as both **calendar** and **listing**
views. The result is a find-and-filter experience where visitors can search and
browse events on your site.

It builds directly on Finders, so the general pattern is the same — a channel that
lists its entries, indexed with Search API and displayed through Views — with the
extra event-specific handling for recurring dates and calendars layered on top. It
depends on the **Finders**, **Date Recur**, and **Calendar View** modules, and it
requires **Drupal 11.3+**. Like Finders, it is at an alpha stage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Finders /
   Date Recur / Calendar View dependencies with Composer, and enable it.

Finders Events has **no single settings form**. It adds an event Finder type that
editors use through the Finders workflow, described in "How to use it" below.

## How to use it

Finders Events plugs into the base Finders workflow, so start by getting Finders
itself set up (see the [Finders guide](../../../finders/1.0.x/human-docs/index.md)).
Then, with this module enabled:

1. Create a **Finder** channel using the **Events** finder type this module
   provides.
2. Its event entries can hold **recurring dates** (powered by Date Recur), so a
   single event can repeat on a schedule rather than needing one entry per
   occurrence.
3. Present the channel as a **calendar** and/or a **listing**, letting visitors
   browse upcoming events by date or search and filter them.

The module provides its own permissions — assign them under **People →
Permissions** to control who can create and manage event channels.
