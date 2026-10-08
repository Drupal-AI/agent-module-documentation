# PDF Manager — manual setup guide

**PDF Manager** (`pdf_manager`) is an administrator's tool for taking stock of all
the PDF files on your site and managing them from one screen. Over time PDFs pile
up in two places — as managed file entities in the database, and as loose files
sitting on disk — and there is usually no easy way to see the whole picture. PDF
Manager scans **both** sources, removes duplicates, and shows you a single
inventory with the total count and combined size of your document library.

From that one screen you can **bulk‑download** selected PDFs as a single ZIP
archive, **export** the scan results to a CSV file, **clear** the cached scan on
demand, and **replace** an existing PDF with a new upload (matched against a CSV
mapping you provide). Large downloads run through Drupal's batch system so they
don't time out.

Every action is locked behind a single restricted permission,
**administer pdf manager**, so the tool is strictly admin‑only. Grant that
permission only to people you trust — the bulk‑download can pull loose files by
their server path, so it should be treated as a powerful administrative capability
and kept to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the admin management screen, the
   permission, and what each action does.

## Where it lives in the admin menu

PDF Manager lives under **Content**, not the settings tree. After enabling it,
open **Content → PDF Manager** or navigate directly to
`/admin/content/pdf-manager` (route `pdf_manager.admin`). That is where you scan,
download, export, and replace PDFs — see [Configuration](configuration/index.md).
