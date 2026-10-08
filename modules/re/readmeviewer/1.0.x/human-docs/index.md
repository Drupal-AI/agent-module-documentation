# README Viewer — manual setup guide

**README Viewer** (`readmeviewer`) gives you a convenient, in-site interface for
reading the README files of your installed modules and themes — so you can stop
hunting through the file system or module directories to find documentation. It
adds a **README Files** tab on the **Extend** page (`/admin/modules`), alongside
the usual Extend and Uninstall tabs, and brings all your module and theme
documentation together in one place.

It automatically discovers README files across contrib, custom, and core modules
and themes, and supports `README.md`, `README.txt`, and plain `README` files.
There is a live search box for filtering by name, type, or status; clear
indicators of which modules are enabled or disabled; and README files open in
convenient AJAX modal dialogs. If the `league/commonmark` library is available,
Markdown READMEs are rendered with proper formatting. Scan results are cached for
performance, with a manual refresh option.

It works out of the box with no configuration — just enable it and use the tab.

> **Note.** This project's security advisory coverage is **not covered** on
> drupal.org. README Viewer surfaces developer-facing documentation, so it is best
> to restrict access to administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — README Viewer works out of the box.

## Where it lives in the admin menu

Once enabled, README Viewer adds a **README Files** tab to the **Extend** page at
**`/admin/modules`**, next to the existing Extend and Uninstall tabs.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Extend** (`/admin/modules`) and click the **README Files** tab.
3. Use the search box to filter by module/theme name, type, or enabled/disabled
   status.
4. Click a module or theme to open its README in a modal dialog. If
   `league/commonmark` is installed, Markdown READMEs render with full formatting.
5. Use the manual refresh option if you have added or changed modules and want the
   cached scan updated.
