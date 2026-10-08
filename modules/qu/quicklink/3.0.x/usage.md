<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quicklink integrates Google's Quicklink JavaScript library into Drupal so that in-viewport links are prefetched during browser idle time, making the next page navigation feel instant.

---

The module registers the Quicklink UMD library (from `/libraries/quicklink/dist/quicklink.umd.js` if present, otherwise a CDN fallback on unpkg) and attaches it on every page via `hook_preprocess_html()`. A single config object, `quicklink.settings`, drives everything: what to ignore (admin paths, AJAX links, hashes, file-extension links, arbitrary URL substrings, CSS selectors), optional overrides (a parent CSS selector to scope prefetching, an allowed-domains list, a prefetch-only path list), when to load the library (anonymous-only, disable during PHP sessions, per-content-type opt-out), throttle options (total request limit, concurrency limit, idle-wait timeout, viewport delay), and a debug mode. The settings form at `admin/config/development/performance/quicklink` is organised into vertical tabs matching those groups. At runtime the module builds a list of URL patterns and selectors to ignore, decides whether to load the library at all (e.g. it bails for authenticated users when "anonymous only" is on, and always ignores `user/logout`), and passes the resulting options to the browser as `drupalSettings.quicklink`. Prefetching only alters perceived performance; it does not change what pages render.

---

- Prefetch in-viewport links during idle time so the next click loads near-instantly.
- Speed up navigation on a content-heavy site for anonymous visitors only.
- Turn on prefetching site-wide without writing any JavaScript.
- Exclude administrative paths (`/admin`, `/edit`) from prefetch to avoid wasted requests.
- Stop AJAX-triggering links from being prefetched (recommended default).
- Ignore links containing a hash (`#`) so anchor links are not prefetched repeatedly.
- Ignore links ending in a file extension (e.g. `.pdf`, `.zip`) so downloads are not fetched.
- Add custom URL substrings to a per-line ignore list (e.g. `/cart`, `/checkout`).
- Ignore links matching a CSS selector such as `.footer a`.
- Scope prefetching to one region by overriding the parent selector (e.g. `.main-content`).
- Allow prefetching from additional domains via an allowed-domains list.
- Restrict prefetching to a specific set of paths with the prefetch-only list.
- Disable prefetching for authenticated users to keep private/session pages out of the picture.
- Disable prefetching whenever a PHP session is active (e.g. Drupal Commerce carts).
- Opt specific content types out of loading the library entirely.
- Throttle the total number of prefetch requests per page load.
- Limit prefetch concurrency to avoid saturating the network on mobile.
- Tune the idle-wait timeout before prefetching begins.
- Add a viewport delay so links must dwell in view before being prefetched.
- Turn on debug mode to log to the console exactly what Quicklink is and isn't prefetching.
- Ship the whole configuration as exported config (`quicklink.settings.yml`) for deployment.
- Host the Quicklink library locally under `/libraries/quicklink` instead of the CDN.
- Keep the logout link from ever being prefetched (built-in, always ignored).
- Improve Core Web Vitals / perceived latency without server-side changes.
