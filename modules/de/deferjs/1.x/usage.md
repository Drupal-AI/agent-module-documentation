<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeferJs adds the `defer` attribute to your site's script tags (using the bundled shinsenter/defer.js library) to reduce render-blocking JavaScript and Total Blocking Time.

---

Install it like any module (`ddev drush en deferjs -y` or via **Extend**), then open **Configuration → Development → Performance → DeferJs** at `/admin/config/development/performance/deferjs` (the modules-page *Configure* link is broken, so go to the path directly) and tick **Enable deferjs** — the module does nothing until you save this form, since it ships no default configuration. Once enabled it inlines the tiny defer.js library in the page head on every page and marks Drupal-managed script tags with `defer`. Use **Exclude Pages** (one path alias per line) and **Exclude JS files** (one asset path per line) to keep specific pages or scripts loading normally, and use **Enabled Content Types** to switch deferral off for chosen node types — note that field behaves as an exclude list, so checking a content type turns deferral **off** for that type. Matching is exact (no wildcards) and lines are split on Windows-style line breaks. Always retest interactive features after enabling, because scripts that assume synchronous load order can break when deferred. Requires only Drupal core (9, 10, or 11) and access to the *administer site configuration* permission.

---

- Reduce render-blocking JavaScript site-wide.
- Improve Total Blocking Time / Core Web Vitals.
- Add `defer` to Drupal-managed script tags automatically.
- Speed up initial page render.
- Enable or disable deferral from one settings form.
- Keep specific pages loading JS normally via Exclude Pages.
- Keep specific script files loading normally via Exclude JS files.
- Turn deferral off for chosen content types.
- Inline the lightweight shinsenter/defer.js library in the head.
- Run on Drupal 9, 10, or 11 with no extra dependencies.
- Restrict configuration to site administrators.
- Test interactive features after enabling deferral.
- Exclude admin or editorial pages from deferral.
- Exclude third-party scripts that need synchronous load.
- Tune performance without writing code.
- Roll out gradually by excluding sensitive pages first.
- Verify theme JavaScript still initialises correctly.
- Save the form to flush caches and apply changes.
- Pair with image lazy-loading and caching modules.
- Confirm behaviour on a staging site before production.
- Re-check configuration after core or theme upgrades.
