# Markdown Index — manual setup guide

**Markdown Index** (`markdown_index`) gives site administrators a report that lists
all the Markdown (`.md`) files scattered across your site's folders and lets you
read any one of them right in the browser. It is a handy reference tool for finding
a module's `README`, reviewing contrib documentation, or checking what Markdown
docs ship on your site — all without needing shell access.

You choose which folders it scans on a small settings form: the project root,
`modules/contrib`, `modules/custom`, and (optionally) `vendor`. It then builds a
sorted list of the `.md` files it finds and shows it as a **report** under
**Reports**, where you pick a file from a dropdown to view its contents.

The module is deliberately scoped for safety. Both its pages are behind
restricted‑access admin permissions, the folders it can scan are fixed to those
four locations, and you select a file by its position in the discovered list (a
numeric index) rather than by typing a path — so there is no way to request an
arbitrary file through path traversal. Even so, the report deliberately exposes
on‑disk file contents to whoever holds the report permission, so grant it only to
trusted maintainers. It supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which folders to scan, then
   read the report.

## Where it lives in the admin menu

- **Settings:** **Configuration → System → Markdown Index Settings**
  (`/admin/config/system/markdown-index`).
- **Report:** **Reports → Markdown Index Report**
  (`/admin/reports/markdown-index`).
