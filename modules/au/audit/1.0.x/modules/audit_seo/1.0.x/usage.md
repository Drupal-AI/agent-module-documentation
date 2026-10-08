Audit analyzer that scores a site's SEO configuration: essential modules, URL patterns, image alt fields and robots.txt.

---

audit_seo registers the `seo` AuditAnalyzer plugin (SeoAnalyzer). It checks for essential SEO modules (metatag, pathauto, simple_sitemap, redirect), scores URL-pattern coverage from pathauto per entity type, reviews image fields for alt-text configuration, and parses the site's `robots.txt` (read from fixed docroot paths). Per-check ignore flags let an admin suppress modules they deliberately do not use (e.g. `ignore_metatag`, `ignore_pathauto_node`, `ignore_simple_sitemap`). Scored issue sections are complemented by informational status overviews.

---

- Audit whether essential SEO modules (metatag, pathauto, simple_sitemap, redirect) are installed.
- Suppress checks for modules you intentionally don't use via the `ignore_*` flags.
- Score URL-alias pattern coverage per entity type from pathauto configuration.
- Detect content types/entities missing clean URL patterns.
- Review image fields for missing/optional alt-text configuration (accessibility + SEO).
- Parse and analyze the site's robots.txt for sitemap directives and blocking rules.
- Ignore pathauto checks per entity type (node, taxonomy_term, user, media).
- Confirm a sitemap is exposed via simple_sitemap or robots.txt.
- Include SEO readiness in a pre-launch or takeover audit.
- Produce a weighted SEO score feeding the overall Project Score.
- Run headless via `drush audit:run seo --format=json`.
- Track SEO posture across a portfolio via DruScan.
- Get remediation guidance (which module to install / config to set) per issue.
- Provide marketing/SEO stakeholders a scored report without site-builder access.
- Flag metatag configuration gaps on key content types.
