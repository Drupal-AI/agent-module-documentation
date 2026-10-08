<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO Audit — agent index

Performs **SEO audits by crawling** the site and reporting issues (missing titles/descriptions, heading
structure). Uses `queue_ui` for background processing. Config at `seo_audit.settings`. Version **1.0.1**.
Core `^10||^11`.

Crawls pages (server-side requests; admin-configured target) — restrict who triggers audits; schedule to
manage load. Reads pages to report (no content change; no access role).
