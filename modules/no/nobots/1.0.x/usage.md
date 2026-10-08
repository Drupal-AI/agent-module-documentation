<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
No Bots blocks well-behaved search-engine robots from crawling, indexing, or archiving a site by adding an `X-Robots-Tag: noindex,nofollow,noarchive` HTTP header to responses.

---

The module is a single response event subscriber (`FinishResponseSubscriber`, subscribed to `KernelEvents::RESPONSE`). On every response it checks two switches — the `nobots` key in `Settings` (settings.php) and the `nobots` state value — and, if either is truthy, appends the `X-Robots-Tag: noindex,nofollow,noarchive` header (added without replacing existing headers). Enabling the module alone does nothing; you must flip one of those switches.

The intended pattern is environment-based blocking: set `$settings['nobots'] = TRUE;` in settings.php for non-production environments, or toggle at runtime with `drush state:set nobots 1`. This keeps staging, dev, and per-branch environments out of search indexes without editing robots.txt or templates. There are no routes, permissions, forms, or user input involved; it only emits a response header. Note this relies on crawlers honouring the header (it does not hard-block access), and because it can hide a whole site from search engines, the state/settings switch should be managed carefully so production is never accidentally de-indexed.

---

- Add `X-Robots-Tag: noindex,nofollow,noarchive` to all responses when enabled
- Keep staging/dev environments out of search-engine indexes
- Block indexing per environment via `$settings['nobots'] = TRUE;`
- Toggle blocking at runtime with `drush state:set nobots 1`
- Re-enable indexing with `drush state:set nobots 0`
- Condition blocking on `getenv('ENV')` in settings.php
- Prevent archiving (noarchive) of non-production content
- Prevent link-following (nofollow) by compliant crawlers
- De-index a site during a pre-launch/maintenance phase
- Apply the header site-wide without editing robots.txt
- Apply the header without theme or template changes
- Manage indexing centrally through Drupal state
- Drive the toggle from deployment scripts per environment
- Ensure production stays indexable by leaving both switches off
- Layer with robots.txt/metatag for defence in depth
- Audit whether an environment is blocked by inspecting the response header
- Avoid accidental indexing of copied database environments
- Toggle without a cache rebuild (state-based switch)
- Keep the block invisible to end users (header only)
- Roll back quickly if a site is unintentionally de-indexed
