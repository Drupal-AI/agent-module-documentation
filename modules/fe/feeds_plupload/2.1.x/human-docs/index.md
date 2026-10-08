# Feeds Plupload — manual setup guide

**Feeds Plupload** (`feeds_plupload`) adds a *fetcher* plugin to the
[Feeds](https://www.drupal.org/project/feeds) module that uses the
[Plupload](https://www.drupal.org/project/plupload) library for drag-and-drop file
uploads. Where the standard Feeds upload fetcher uses a plain file field, this
fetcher gives you Plupload's chunked, drag-and-drop uploader — which is much
friendlier when the file you're importing is large.

Once installed, it appears as **File upload with Plupload** in the fetcher list
when you configure a Feed type. You pick it in place of the default fetcher, and
from then on people creating a feed of that type upload their source file through
the Plupload widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Feeds and Plupload.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. You select the fetcher on each Feed type, as described below.

## Where it lives in the admin menu

Feeds Plupload adds no admin page of its own. You use it from a Feed type at
**Structure → Feed types** (`/admin/structure/feeds`), where it appears in the
**Fetcher** list.

## How to use it

1. Install and enable the module together with Feeds and Plupload (see
   [Installation](installation/index.md)).
2. Confirm Plupload is set up correctly at **Reports → Status report**
   (`/admin/reports/status`) — it should report the Plupload library as installed.
3. Go to **Structure → Feed types** and add a new Feed type, or edit an existing
   one.
4. Change the Feed type's fetcher to **File upload with Plupload**.
5. Set the parser and processor on the same Feed type as usual, then create a feed
   of that type. When you add or edit the feed you'll get the Plupload
   drag-and-drop uploader for the source file.
