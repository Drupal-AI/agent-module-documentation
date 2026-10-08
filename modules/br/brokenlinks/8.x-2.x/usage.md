<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SEO Broken Links scans formatted-text fields and repairs broken links via a shortener service.

---

SEO Broken Links provides a queue worker that scans entities' formatted-text fields for broken links and repairs them, historically using Google's URL Shortener service. It's aimed at keeping content link-healthy for SEO and user experience.

Because it rewrites content fields based on an external service, review its configuration and be aware the Google Shortener service it references is deprecated — validate behaviour before running against production content. Supports Drupal 10.2+ and 11.

---

- Scan formatted-text fields for broken links.
- Repair broken links.
- Run as a queue worker.
- Improve SEO link health.
- Enhance user experience.
- Use a URL shortener service.
- Rewrite content fields.
- Review configuration before running.
- Note the Google Shortener is deprecated.
- Validate behaviour on production.
- Support Drupal 10.2+ and 11.
- Keep content link-healthy.
- Process entities in the background.
- Fix links automatically.
- Target formatted text.
- Act as an SEO tool.
- Queue link-fixing work.
- Maintain outbound links.
