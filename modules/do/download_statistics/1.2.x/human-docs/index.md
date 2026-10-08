# Download Statistics — manual setup guide

**Download Statistics** (`download_statistics`) logs how often the files on your
site are downloaded, so you can see which documents and assets are most popular. It
extends the idea of Drupal's core Statistics module to files, bringing back the
kind of file‑download tracking that Drupal 7 sites got from the old Download Count
module.

It gives you a customizable **"Popular file downloads" block** showing the most
downloaded files today and of all time, plus the files downloaded most recently —
you choose how many of each to display, and you can place the block in any region.
It also provides **extensive Views support**, with view fields for total file
downloads, downloads today, and the most recent download timestamp, so you can
build your own reports or show download counts right on a node page.

As with Download Count, the **private‑files rule is fundamental**: downloads can
only be counted for files stored in a **private** directory. Public files are sent
straight to the browser by the web server, bypassing Drupal, which makes counting
impossible. So the key setup step is to set your file upload fields to the
**Private files** destination (and to have a private directory configured in
`settings.php`).

It depends on core **Node**, **Field**, and **File**, is configured at
`/admin/config/system/download-statistics`, provides its own permissions, and runs
on Drupal 10.3, 11, and 12. It is minimally maintained (maintenance fixes only) but
is security‑advisory covered.

> **Privacy note.** As with any analytics that logs requests, be mindful of what
> is stored per download — avoid logging unnecessary personal data, and consider a
> privacy/retention policy for the recorded statistics.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your file fields to private,
   enable/disable counting, choose the display formatters, place the block, and set
   permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Download Statistics**
(`/admin/config/system/download-statistics`). This is where you enable or disable
download counting and where you can clear the recorded download data.
