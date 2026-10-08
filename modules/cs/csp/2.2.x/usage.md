Content Security Policy builds and emits `Content-Security-Policy` (and `Content-Security-Policy-Report-Only`) HTTP response headers for a Drupal site, hardening it against cross-site scripting and data-injection attacks without hand-editing headers.

---

Browsers enforce a Content Security Policy by only loading scripts, styles, images, frames, and other resources from origins the policy explicitly allows. This module gives site builders a settings form (Admin → Configuration → System → Content Security Policy) to configure two independent policies — a lenient **Report-Only** policy for testing and a stricter **Enforce** policy — each with per-directive source lists (`script-src`, `style-src`, `img-src`, `frame-ancestors`, and many more). It automatically discovers the external hosts required by Drupal's asset libraries and adds them to the relevant directives, so most core and contrib assets work out of the box. It can emit cryptographic **nonces** and **hashes** so inline scripts/styles are allowed without resorting to `unsafe-inline`, supports **Trusted Types** and `upgrade-insecure-requests`, and offers pluggable **reporting handlers** (none, a custom report URI, or the report-uri.com service). Developers extend policies at runtime through the `CspEvents::POLICY_ALTER` event (or `hook_csp_policy_alter` for themes), and manipulate the policy through the fluent `Csp` value object and `PolicyHelper` service. All configuration is standard Drupal config, so it is exportable and deployable across environments.

---

- Add a site-wide `Content-Security-Policy` header to mitigate XSS.
- Run a `Content-Security-Policy-Report-Only` policy first to find violations before enforcing.
- Restrict scripts to `'self'` so third-party/injected scripts are blocked.
- Whitelist a specific CDN or analytics host in `script-src`/`connect-src`.
- Lock down `object-src` to `'none'` to block Flash/legacy plugins.
- Prevent clickjacking by setting `frame-ancestors 'self'`.
- Constrain where forms can submit with `form-action`.
- Allow inline scripts safely using auto-generated nonces instead of `unsafe-inline`.
- Add a hash for a known inline script/style block via `PolicyHelper::appendHash()`.
- Automatically permit hosts required by Drupal libraries (Google Fonts, maps, etc.).
- Force all resource loads over HTTPS with `upgrade-insecure-requests`.
- Enable Trusted Types to harden DOM-XSS sinks.
- Send violation reports to report-uri.com using the bundled reporting handler.
- Send violation reports to a custom endpoint URI.
- Deploy identical CSP configuration across dev/stage/prod as exported config.
- Alter the policy per-response from a custom module via the `POLICY_ALTER` event.
- Append an image host from a theme with `hook_csp_policy_alter()`.
- Add `img-src data:` to allow inline data-URI images.
- Configure `style-src` for a decoupled or heavily themed front end.
- Set `worker-src`/`child-src` for sites using web workers or embedded frames.
- Apply the `sandbox` directive to restrict embedded content capabilities.
- Use `report-sample` flags to include offending code snippets in reports.
- Gate CSP administration behind the `administer csp configuration` permission.
- Programmatically build a header string with the `Csp` value object in custom code.
- Provide per-directive fallbacks (e.g. `script-src-elem` falling back to `script-src`).
- Satisfy security-audit or compliance requirements for HTTP security headers.
