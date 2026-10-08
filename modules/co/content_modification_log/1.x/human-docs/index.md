# Content Modification Log — manual setup guide

**Content Modification Log** (`content_modification_log`) keeps an exportable,
date-filterable log of content changes: which entity was modified, who made the
change, and when. It's an audit tool, aimed at compliance and editorial oversight
— the kind of record you want when someone asks "who changed this page, and when?"
and impressions aren't good enough.

The log displays information about each modified entity, the user who performed
the modification, and a timestamp, and it can be filtered by date range and
exported for offline review or record-keeping. The module has no third-party
dependencies — it works with Drupal core alone — and supports Drupal 9, 10, and
11.

Two things are worth keeping in mind because of *what* this data is. The log
itself is a record of editorial activity — who did what — so it is sensitive:
restrict who can read and export it. And an export is a concentrated copy of that
record, so treat exported log files as sensitive data too, keep the feature
admin-gated, and decide on a retention approach rather than letting the log grow
and travel indefinitely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This project is not covered by Drupal's security advisory policy.
> Because the log records who changed what, keep access to it and its exports
> restricted to trusted administrators.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated settings form to walk through — the module records
modifications automatically once enabled, and you read and export the log from its
admin report, described in "How to use it" below.

## Where it lives in the admin menu

Once enabled, the module records content modifications automatically. You review
the log through its admin report page, where you can filter entries by date and
export them. Access should be limited to trusted administrators.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). From that point
   on, content modifications are recorded automatically — there's nothing to turn
   on per content type.
2. Open the modification log report from the administration area. Each row shows
   the modified entity, the user who changed it, and a timestamp.
3. Use the **date filter** to narrow the log to a period you care about.
4. **Export** the filtered log when you need an offline record. Store the export
   securely — it is a sensitive record of editorial activity.
