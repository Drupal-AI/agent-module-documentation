# Page Not Found Files Report — manual setup guide

**Page Not Found Files Report** (`page_not_found_files_reports`) scans your site's
pages for **broken image URLs** — image references that return a 404 — and lists
them in an admin report under **Reports**, so editors can track down and fix
missing images. The report can cover the pages found through your site's
`sitemap.xml`, or a specific configured page.

Under the hood it makes HTTP requests to check whether each referenced image URL
resolves, so it needs the **PHP XML extension** on the server and, for a full‑site
report, a `sitemap.xml` at your site root. It is a content‑maintenance and
reporting tool — it has no content‑editing or access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, meet
   the PHP and sitemap prerequisites, and enable it.

There is **no dedicated settings page**; you run and read the report from the
**Reports** menu, described in "How to use it" below.

## Where it lives in the admin menu

The broken‑image report is generated under the **Reports** menu
(`/admin/reports`). Open it there to see the list of 404 image files found across
your pages.

## How to use it

1. Make sure the prerequisites are in place — the **PHP XML extension** installed
   on the server, and (for a full‑site report) a valid **`sitemap.xml`** at your
   site root.
2. Go to **Reports** (`/admin/reports`) and open the Page Not Found Files report.
3. Review the list of image URLs that returned 404, and fix the underlying content
   or files.

> **Tip:** If the report does not work against a local site or an unsecured URL,
> try it against a proper HTTPS‑secured URL — the checks are more reliable there.
