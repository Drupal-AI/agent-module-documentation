# Preserve Changed Timestamp UI — manual setup guide

**Preserve Changed Timestamp UI** (`preserve_changed_ui`) adds a checkbox to the
node edit form that lets an editor save a change **without** updating the node's
`changed` ("Last saved") timestamp. It is the fix for a familiar annoyance: a
one-character typo correction pushing an article back to the top of every "recently
updated" listing.

The `changed` field quietly drives a lot: "latest updates" views sort on it,
sitemaps publish it as `lastmod`, feeds order by it, search indexers use it to
decide what to re-crawl, and caches key on it. So a trivial edit can have
consequences out of all proportion to the actual change. This module surfaces that
as an explicit editorial choice — tick the box for a minor fix and the timestamp
stays put; leave it unticked and the save behaves normally.

Two permissions govern the module, and **both are marked as restricted access** on
purpose:

- **`administer preserve_changed_ui configuration`** controls who can reach the
  settings form.
- **`preserve_changed_ui allow preserve changed time`** controls who actually sees
  and can use the checkbox.

That second restriction matters: suppressing `changed` effectively hides an edit
from every listing, feed, sitemap `lastmod`, and re-index decision that trusts that
field. It is close to "edit without leaving a trace," so grant it only to editors
you trust to make that judgement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **If you need an API instead of a UI**, the separate
> [Preserve Changed](https://www.drupal.org/project/preserve_changed) module offers
> the same behaviour programmatically. This module is the UI-driven alternative and
> is currently at a beta release.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the default behaviour and choose
   where the checkbox appears.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Preserve Changed Timestamp
UI** (`/admin/config/system/preserve-changed-ui`), the
`preserve_changed_ui.settings_form` route. The checkbox itself appears at the
bottom of the node edit form for users who hold the "allow preserve changed time"
permission.
