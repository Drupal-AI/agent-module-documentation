# Configure Security Kit

![Security Kit settings form](../../../../../../../screenshots/seckit/2.0.x/settings.png)

One form `SecKitSettingsForm` at `/admin/config/system/seckit` (route `seckit.settings`,
permission `administer seckit`). Headers are emitted by `SecKitEventSubscriber` on each
response. Config object: `seckit.settings`. Groups and keys:

## `seckit_xss` (Cross-site scripting)
- `csp.checkbox` — enable Content Security Policy.
- `csp.report-only` — send `Content-Security-Policy-Report-Only` instead of enforcing.
- `csp.default-src` / `script-src` / `object-src` / `style-src` / `img-src` / `media-src` /
  `frame-src` / `frame-ancestors` / `child-src` / `font-src` / `connect-src` — per-directive sources.
- `csp.report-uri` — where violation reports are POSTed (default `/report-csp-violation`,
  handled by `SeckitExportController::export`, route `seckit.report`).
- `csp.upgrade-req` — add `upgrade-insecure-requests`. `csp.policy-uri`, `vendor-prefix`.
- `x_xss.select` — legacy `X-XSS-Protection` mode.

## `seckit_csrf`
- `origin` — enable Origin/HTTP-referrer based CSRF check. `origin_whitelist` — allowed origins.

## `seckit_clickjacking`
- `x_frame` — `X-Frame-Options` value (SAMEORIGIN/DENY/ALLOW-FROM/disabled).
- `x_frame_allow_from`, `js_css_noscript` (JS+CSS+noscript technique), `noscript_message`.

## `seckit_ssl`
- `hsts`, `hsts_subdomains`, `hsts_max_age`, `hsts_preload` — HTTP Strict Transport Security.

## `seckit_ct` (Expect-CT)
- `expect_ct`, `max_age`, `report_uri`, `enforce`.

## `seckit_fp` (Feature/Permissions policy)
- `feature_policy`, `feature_policy_policy` (the policy string).

## `seckit_various`
- `from_origin`, `from_origin_destination`, `referrer_policy`, `referrer_policy_policy`,
  `disable_autocomplete`.

All are plain config — export via `drush config:export` to deploy the policy across environments.
