<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Strip ignored GET parameters to improve cacheability.

---

Request Cleanup is a stack middleware that cleans up the incoming request — stripping configured/ignored GET query parameters (by key or regex, e.g. tracking params like `utm_*`, `fbclid`) before Drupal processes the request, so those variations don't fragment the page cache and cache hit-rates improve. Supports Drupal 10 and 11.

---

- Strip ignored GET parameters.
- Match by key or regex.
- Remove tracking params.
- Improve cacheability.
- Avoid cache fragmentation.
- Run as stack middleware.
- Support Drupal 10 and 11.
- Configure ignored keys.
- Aid performance.
- Handle request cleanup.
- Normalise requests.
- Boost cache hits
- Support Drupal.
- Support Drupal.
- Support Drupal.
