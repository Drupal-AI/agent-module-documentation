<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Serve environment-specific robots.txt (disallow-all off production).

---

Robots Rerouter dynamically serves a robots.txt based on environment — on non-production environments it returns a disallow-all policy (keeping staging/dev out of search indexes), while on the configured production domain it delivers the standard robots.txt. This prevents accidental indexing of non-production sites. Supports Drupal 9, 10, and 11.

---

- Serve environment-specific robots.txt.
- Disallow-all on non-production.
- Serve the real robots.txt on production.
- Prevent staging indexing.
- Detect the production domain.
- Protect against accidental indexing.
- Support Drupal 9, 10, and 11.
- Configure the production domain.
- Aid SEO hygiene.
- Handle robots.txt.
- Gate crawlers.
- Block dev indexing
- Support Drupal.
- Support Drupal.
- Support Drupal.
