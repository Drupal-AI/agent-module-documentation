<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Umami Analytics injects the Umami tracker script into every page so a site can be measured by Umami — a self-hosted, cookieless, privacy-focused alternative to Google Analytics.

---

The module is a thin glue layer: it does not host or analyse anything itself, it just adds one `<script>` tag pointing at your Umami instance. On the settings form (`/admin/config/services/umami-analytics`, permission `administer umami analytics`) you supply two required values — the **Umami script URL** (`src`, e.g. `https://umami.example.com/script.js`) and the **website ID** (`website_id`, the UUID Umami assigns to the site) — and the tracker is emitted via `hook_page_attachments`. Nothing is injected until both are set. Two loading strategies are offered: **Deferred** (`script_mode: onload`, the default for new installs) builds the tag with an inline `window.addEventListener('load', …)` bootstrap that appends the script only after page load, keeping analytics out of the critical rendering path; **Async** (`script_mode: async_defer`) emits a plain `async defer` script tag directly. Both encode the configured `src`, `website_id` and optional `data-domains` safely (JSON hex-encoding for the inline path, attribute escaping for the async path). Visibility is scoped three ways: by **domain** (single vs. a comma-separated multi-domain list, emitted as `data-domains`), by **request path** (a path list with `*` wildcards and `<front>`, in include-only or exclude mode; the default excludes admin/batch/node-edit/user paths), and by **user role** (track only selected roles, or every role except selected). Note the module is still beta — several advertised knobs are inert: the `local_cache` local-JS-caching feature, its cron daily-sync, and the `do_not_track`/`auto_track`/`cache`/`host_url` config keys exist in schema but are not wired into the emitted tag (the settings-form sections for them are dead code after an early `return`).

---

- Track a Drupal site with a self-hosted Umami instance instead of Google Analytics.
- Add cookieless, privacy-focused web analytics.
- Inject the Umami tracker script on every page automatically.
- Configure the Umami script URL (`src`) and website ID once in the admin UI.
- Choose deferred (post-load) or async script loading to protect page-speed scores.
- Exclude admin and editing pages from tracking (the shipped default).
- Track only specific pages using path patterns with `*` wildcards and `<front>`.
- Track every page except a listed set (include/exclude request-path modes).
- Restrict tracking to specific user roles (e.g. only anonymous visitors).
- Exclude specific roles from tracking (e.g. don't count logged-in editors/admins).
- Track a single domain or a set of related domains via `data-domains`.
- Keep analytics data inside your own infrastructure (self-hosted Umami).
- Reduce third-party script weight versus heavier analytics suites.
- Gate all configuration behind the restricted `administer umami analytics` permission.
- Set tracking config in code with `drush config:set umami_analytics.settings …`.
- Support a GDPR/privacy-conscious analytics choice (subject to your own data-protection assessment).
- Avoid this module if you need Umami event/goal tracking, local JS caching, or Do-Not-Track honouring — those are not yet implemented (beta).
- Do not confuse with Drupal core's **Umami** demo install profile — unrelated, name collision only.
