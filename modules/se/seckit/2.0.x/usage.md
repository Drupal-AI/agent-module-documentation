Security Kit (SecKit) hardens a Drupal site against common web attacks by adding and configuring HTTP security response headers — Content Security Policy, HSTS, clickjacking protection, referrer policy, and more.

---

SecKit gives site builders a single admin form to turn on a broad set of browser-enforced security protections without writing code. It builds and sends security response headers on every page via an event subscriber: a full Content Security Policy (CSP) builder (per-directive sources, report-only mode, report URI, upgrade-insecure-requests), HTTP Strict Transport Security (HSTS, with subdomains/preload), clickjacking defenses (`X-Frame-Options` plus an optional JavaScript+CSS+noscript technique), a configurable `Referrer-Policy`, `Expect-CT`, a `Feature-Policy`/Permissions-Policy string, `From-Origin`, disabling of form autocomplete, and legacy `X-XSS-Protection`. It also offers an Origin-based CSRF/HTTP-referrer check with an allowlist. CSP violations can be POSTed back to a built-in reporting endpoint (`/report-csp-violation`) that logs them. Everything is stored in the `seckit.settings` config object (exportable/deployable) and gated by the `administer seckit` permission. It has no public API or plugins — it is purely configuration that shapes outgoing headers, making it a fast, low-risk baseline hardening layer for most sites.

---

- Add a Content Security Policy to restrict where scripts/styles/images load from.
- Run CSP in report-only mode first to find violations before enforcing.
- Collect CSP violation reports at the built-in `/report-csp-violation` endpoint.
- Set per-directive CSP sources (`script-src`, `img-src`, `connect-src`, ...).
- Add `upgrade-insecure-requests` to force HTTPS sub-resources.
- Enable HSTS to force browsers to use HTTPS.
- Apply HSTS to all subdomains and opt into the preload list.
- Prevent clickjacking with `X-Frame-Options: SAMEORIGIN` (or DENY/ALLOW-FROM).
- Use the JS+CSS+noscript anti-framing technique as a fallback.
- Set a `Referrer-Policy` to control referrer leakage.
- Enable `Expect-CT` for certificate transparency enforcement.
- Send a `Feature-Policy`/Permissions-Policy to limit browser features.
- Restrict cross-origin resource use with a `From-Origin` header.
- Turn off form autocomplete for sensitive forms.
- Add a legacy `X-XSS-Protection` header for old browsers.
- Enable an Origin-header based CSRF protection check.
- Allowlist trusted origins for the CSRF/referrer check.
- Deploy a consistent security-header policy across environments as config.
- Meet a security-audit requirement for standard hardening headers.
- Mitigate mixed-content issues via CSP directives.
- Limit which domains can frame your site to stop UI-redress attacks.
- Reduce XSS impact by disallowing inline scripts via CSP.
- Restrict the reporting of violations to a custom report URI.
- Provide a security baseline without editing server/webserver config.
- Gate all these settings behind the `administer seckit` permission.
