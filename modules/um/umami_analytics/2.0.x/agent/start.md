<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# umami_analytics — agent start

Injects the **Umami** web-analytics tracker `<script>` on every page. Self-hosted, cookieless
alternative to Google Analytics. No dependencies. Core `^10 || ^11`. **Release 2.0.0-beta4 — beta.**

## How it works
- All injection is in `hook_page_attachments()` (`umami_analytics.module`). It emits **nothing**
  until both `src` (Umami script URL) and `website_id` are set in config.
- Two loading modes (config `script_mode`):
  - `onload` (default new installs) — an inline `<script>` with `#value`; values wrapped in
    `Json::encode()` and appended via `window.addEventListener('load', …)` after page load.
  - `async_defer` — a plain `<script async defer src=… data-website-id=…>` built from `#attributes`.
- Visibility gate: `umami_analytics.visibility` service (`VisiblityTracker`) checks request path
  (`getVisibilityPages`) and user role (`getVisibilityRoles`) before injecting.
- `data-domains` is added only when `domain_mode == 1` (multi-domain).

## Config / where to change things
- Settings form `/admin/config/services/umami-analytics` (route
  `umami_analytics.admin_settings_form`, form `SettingsForm`, permission
  **`administer umami analytics`**, `restrict access: true`). → [config/settings.md](config/settings.md)
- Config object `umami_analytics.settings` (schema `config/schema/umami_analytics.schema.yml`).

## Beta caveats (read before recommending a feature)
- `JavascriptLocalCache` (local JS caching / daily cron sync) is **stubbed**: `hook_cron()` returns
  immediately (`@TODO`), and the form's Advanced/`local_cache` section is unreachable dead code
  after an early `return parent::buildForm()`. `fetchJavascript()` therefore always returns the
  remote `src` unchanged.
- Config keys `host_url`, `auto_track`, `do_not_track`, `cache` exist in schema/defaults but are
  **not** rendered into the emitted script — no Umami tracker-configuration options are wired up.
- No automated tests.
- Unrelated to Drupal core's **Umami** demo install profile (name collision).

## Security
- Config gated by a restricted permission; form is a `ConfigFormBase` (CSRF-protected).
- Both injection paths encode admin-entered values safely (JSON hex-encode / attribute escaping);
  no XSS via `src`/`website_id`/`domains`. Nothing sensitive is disclosed.
