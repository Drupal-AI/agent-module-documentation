<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Crawler fetches data from websites via cURL, crawling links (typically from an entity field) in a batch process to extract or store content.

---

Pulling content or metadata from external URLs — crawling links to fetch their content — is sometimes needed for aggregation or enrichment. Simple Crawler fetches website data via cURL in a batch process, crawling links (from an entity field). The security-relevant consideration is server-side request forgery and outbound-request safety: the module makes the Drupal server fetch URLs, and if those URLs come from user-controlled content (an entity field a non-admin can set), a submitter could steer the server to internal services — a classic SSRF. The crawl is a batch process (typically admin-triggered), which limits who initiates it, but the URLs crawled should still be validated/allow-listed if they originate from untrusted content. Additionally confirm the cURL requests use TLS verification (do not disable certificate checks) and handle failures. Use it for controlled crawling of trusted/allow-listed URLs; treat URLs from untrusted fields as an SSRF risk.

---

- Crawl website data via cURL.
- Fetch content from links.
- Aggregate external content.
- Crawl links from a field.
- Run a crawl batch.
- Guard against SSRF.
- Allow-list crawled URLs.
- Validate URLs from untrusted fields.
- Use TLS verification.
- Confirm the URL source.
- Handle crawl failures.
- Treat user-set URLs as SSRF risk.
- Enrich content from URLs.
- Restrict who triggers crawls.
- Fetch page data.
- Crawl trusted sources only.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.