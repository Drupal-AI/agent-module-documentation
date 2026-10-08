# Date Augmenter API — manual setup guide

**Date Augmenter API** (`date_augmenter`) is a developer-facing plugin system for
enriching how date fields are displayed. On its own it adds no visible feature —
it provides the shared "plumbing" that small **augmenter** plugins (from other
modules) plug into to add things like an "Add to Calendar" button, a link around
a date, related content, or AP-style formatting. Site builders then enable and
order those augmenters per date-formatter instance.

The best-known consumer is the contrib **Smart Date** module: when Smart Date's
date formatter is augmenter-aware, Date Augmenter injects an "Enabled Date
Augmenters" checkbox list, a drag-and-drop ordering table, and per-augmenter
settings into that formatter's settings form on *Manage display*. Your choices
are saved alongside the formatter as third-party settings, and at display time the
enabled augmenters run in weight order to enhance the rendered date — the stored
date value itself is never touched.

Because this module is an API, installing it by itself does nothing you can see.
You install it as a dependency of the modules that actually provide augmenters or
augmenter-aware formatters, or because you are a developer building one of those.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including how to write an
augmenter plugin and how the plugin manager and config work — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the modules that provide augmenters).

## How to use it

Date Augmenter has **no settings page of its own**. You interact with it in two
ways:

- **As a site builder:** install this module together with an augmenter-aware
  date formatter (such as Smart Date) and one or more augmenter plugins (Add to
  Calendar, Link, Content, AP Style — each shipped in its own contrib module).
  Then, on the entity's **Manage display** page, open the date field's formatter
  settings: you will see the list of available augmenters, a weight table to
  order them, and each augmenter's own settings. Tick the ones you want, drag to
  order them, and save.
- **As a developer:** make a date formatter augmenter-aware by adding a
  `supportsDateAugmenter()` method, or write your own augmenter plugin. The
  [`agent/`](../agent/plugins/create-augmenter.md) docs cover both.

## Where it lives in the admin menu

Nowhere on its own — there is no configuration route, no settings form, and no
permissions. The augmenter controls appear inside the **formatter settings** of an
augmenter-aware date field on **Manage display** (for a content type,
`/admin/structure/types/manage/<type>/display`), not as a standalone page.
