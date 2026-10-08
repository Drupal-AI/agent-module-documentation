<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Soapbox PDF (page_to_pdf) — agent index

**PDF generator** — produces PDF versions of page content (downloadable reports/articles/printable pages).
Version **1.0.2**. Core `^9.0||^10.0||^11`.

Uses server-side PDF rendering — keep the tooling patched; if the rendered URL is user-influenced, guard
against SSRF. A PDF reflects content the requester can see; no access role beyond that.
