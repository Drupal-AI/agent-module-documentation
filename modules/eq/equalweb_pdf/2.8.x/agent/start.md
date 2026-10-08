<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EqualWeb PDF Accessibility (equalweb_pdf) — agent index

**Scans every PDF on the site against PDF/UA, scores & reports them, and optionally remediates files automatically via EqualWeb.**

- **Version:** 2.8.x
- **Core:** ^10.3 || ^11
- **Package:** Accessibility
- **Configure:** `equalweb_pdf.admin` (`/admin/reports/equalweb-pdf`)
- **Permissions:** `administer equalweb pdf`, `view own/any equalweb pdf files`, `check`, `remediate`, `replace equalweb pdf files`
- **Routes:** admin page + `/equalweb-pdf/ajax/{action}` (POST) + `/equalweb-pdf/download/{fid}` (GET, CSRF) + `/equalweb-pdf/report/{year}` (GET, `_csrf_token: TRUE`) — all under the OR permission list; `/equalweb-pdf/verify` (GET, `_access: 'TRUE'`).
- **Key classes:** `AjaxController` (all EqualWeb traffic, server-side), `Access` (per-action/permission + file-scope helper), `EqualWebClient`, `VerifyController`, `PdfStore`, `Classification`, `FileManager`.
- **Security:** The one `_access: 'TRUE'` route (`/equalweb-pdf/verify`) only returns a one-time, time-limited registration nonce from state (else 404), `Cache-Control: no-store` — no user data, no state change, no server-side fetch, so it cannot forge verification or cause SSRF. The single AJAX route is intentionally gated at the weakest (view) permission and then re-authorizes each action in `handle()` via `ACTION_PERMS` after CSRF validation. `downloadFile` validates CSRF and re-checks `Access::canSee($file)`, 404-ing (no oracle) otherwise; `fid`/`file` load through Drupal `File` entities (no path input). API keys stay server-side. Reviewed sound.

See [configure/access.md](configure/access.md).
