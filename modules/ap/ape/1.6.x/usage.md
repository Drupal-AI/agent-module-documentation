<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Page Expiration (APE) gives finer control over the `Cache-Control: max-age` header that external caches (Varnish, CDNs, reverse proxies) use, letting you set different page cache lifetimes by path and by HTTP response code instead of one global value.

---

APE replaces Drupal's single "page cache maximum age" with per-scenario lifetimes stored in the `ape.settings` config object, configured at *Configuration → Development → Performance → APE* (`/admin/config/development/performance/ape`, route `ape.admin`, permission `administer ape`). It keeps using core's global `system.performance` `cache.page.max_age` as the default, then layers overrides on top. An **alternative** lifetime (`lifetime.alternatives`) applies to a configurable list of paths (`alternatives`) — e.g. make the homepage expire every 5 minutes while the rest of the site lasts an hour — matched with core's `request_path` condition plugin. Separate lifetimes apply to redirects and errors: `lifetime.301`, `lifetime.302`, `lifetime.404` (a 403 is always forced to `max-age=0`). A list of **excluded** paths (`exclusions`) is enforced by a page-cache response policy (`ExcludePages`) that denies caching entirely for those pages. The work happens in an event subscriber (`ApeSubscriber`, on the kernel RESPONSE event at priority -1024) that computes the max age and writes `Cache-Control: public, max-age=N` on cacheable responses (or `no-cache, must-revalidate` when the response isn't cacheable or the age is 0). Integrations can override the computed value: set it early with `ape_cache_set()` (used by Rules integration), or adjust the final number via the `hook_ape_cache_alter($max_age, $original_max_age)` alter hook. The module also hides the now-redundant max-age selector on the core Performance form and points admins to APE instead. A bundled `ape_test` submodule adds redirect/landing endpoints purely for testing.

---

- Cache the homepage for 5 minutes while the rest of the site is cached for an hour, via an alternative path lifetime.
- Give a set of frequently-updated pages (news, dashboards) a shorter cache lifetime than the site default.
- Set a long cache lifetime for 301 redirects so permanent redirects are cached by Varnish/CDN.
- Cache 302 redirects for a controlled, shorter duration.
- Control how long 404 Not Found responses are cached to reduce backend hits from bad URLs.
- Ensure 403 Access Denied responses are never cached (APE forces max-age 0).
- Exclude sensitive or highly-dynamic paths (e.g. `/cart`, `/user/*`) from page caching entirely.
- Tune Varnish/CDN TTLs per URL without editing VCL, using Drupal config only.
- Keep a marketing landing page fresh with a short alternative lifetime while other pages stay long-lived.
- Centralise all Cache-Control max-age decisions in one admin form.
- Programmatically force a specific max-age for a request with `ape_cache_set()` (e.g. from custom code or Rules).
- Adjust the final computed max-age in code with `hook_ape_cache_alter()` for complex rules.
- Apply different cache lifetimes to different sections of a site by listing paths with wildcards.
- Reduce origin load by caching error pages briefly instead of not at all.
- Provide editors a way to mark specific pages as never-cached via the exclusion list.
- Export cache-lifetime policy as config (`ape.settings`) and deploy it across environments.
- Replace scattered custom `Cache-Control` header code with a single maintained module.
- Set an aggressive default page expiration while carving out exceptions for a few dynamic pages.
- Cache redirect-heavy campaign URLs (301/302) appropriately for a CDN.
- Prevent a login or checkout path from ever being stored by an external cache.
- Test cache-header behaviour with the ape_test endpoints (`/ape_redirect_301`, `/ape_alternative`, `/ape_exclude`).
- Combine with Rules integration to set expiration dynamically based on business logic.
