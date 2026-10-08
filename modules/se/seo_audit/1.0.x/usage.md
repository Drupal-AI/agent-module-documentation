<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SEO Audit performs SEO audits by crawling sites and reporting SEO issues, using a queue for processing.

---

SEO Audit performs SEO audits by crawling the site — fetching pages and analyzing them for SEO issues
(missing titles/descriptions, heading structure, etc.) and reporting the findings. It uses Queue UI for
queued/background processing of the crawl. It is configured at `seo_audit.settings`.

Use it to audit a site's on-page SEO. Because it crawls pages (making server-side HTTP requests), note:
the crawl target is admin-configured (typically the site itself), and crawling generates load, so schedule
it appropriately and restrict who can trigger audits. It is an SEO/administration analysis tool that reads
site pages to report; it does not change content and has no access-control role. Configure the audit scope
and run it.

---

- Audit on-page SEO by crawling.
- Report SEO issues.
- Find missing titles/descriptions.
- Analyze heading structure.
- Use Queue UI for processing.
- Configure at seo_audit.settings.
- Crawl the site (server-side requests).
- Restrict who can trigger audits.
- Schedule crawls to manage load.
- Not change content.
- Have no access-control role.
- Report audit findings.
- Analyze pages for SEO.
- Queue the crawl.
- Configure the audit scope.
- Improve on-page SEO.
- Run SEO audits.
- Crawl admin-configured targets.
- Report SEO problems.
- Audit site SEO.
