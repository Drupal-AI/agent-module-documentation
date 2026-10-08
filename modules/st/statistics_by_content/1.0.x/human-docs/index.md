# Statistics by content type — manual setup guide

**Statistics by content type** (`statistics_by_content`) lets you limit Drupal
core's Statistics view-counting to only the content types you care about. Out of
the box, core Statistics attaches its little counter JavaScript to *every* full
node page, so every content type accrues view counts. This module removes that
JavaScript from the bundles you have **not** selected, so only your chosen content
types get counted.

The problem it solves is noise. If you only care about how often Articles are
viewed, there is no reason to count views on basic pages, landing pages, or
utility node types — those just clutter your popular-content reports and generate
extra counter AJAX requests. With this module you pick the content types that
should be tracked and leave the rest alone.

It is a small, focused module. It depends only on core's Statistics module, adds
no reports or data of its own (it never writes or exposes statistics — it only
removes an attached library from render output), and it needs one bit of
configuration to be useful: the list of content types to keep counting. It only
affects full-page node views, not teasers or previews.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer command,
   and enabling the module.
2. [Configuration](configuration/index.md) — choosing which content types are
   tracked.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Statistics → By content
type** (`/admin/config/system/statistics/by-content-type`, route
`statistics_by_content.settings`), and it is gated by the core **Administer
statistics** permission.
