<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WWW Authenticate adds a configurable HTTP Basic Authentication gate in front of the whole site (or selected paths), with multiple credentials plus IP, path, role, and time-based rules.
---
A kernel `REQUEST` subscriber (`WwwAuthenticateSubscriber`) runs on the main request and asks `WwwAuthenticateService::isAuthRequired()` whether the current request must pass the basic-auth prompt. That method layers bypasses in order: module-enabled flag, maintenance-only mode, CLI/Drush/cron bypass, an optional REST/JSON:API bypass, IP allowlist (skip) / denylist (force), Drupal role bypass for logged-in users, a time window, and finally path include/exclude rules (the settings and log pages are always excluded so admins can't lock themselves out). When required, credentials are read from `PHP_AUTH_USER`/`PHP_AUTH_PW` or a parsed `Authorization: Basic` header and checked by `validateCredentials()` against the configured username/password pairs; failure returns a 401 with a `WWW-Authenticate` header. Attempts are optionally logged to a `www_authenticate_log` table (IP, username, path, user-agent), trimmed to a max size.

This is a **defence-in-depth shield layered on top of** Drupal's own authentication — it does not replace or weaken Drupal login; bypassing it still leaves core access control intact. Notable posture points to be aware of: credential pairs are stored in plaintext config and compared with `===` (not `hash_equals`, so the compare is not constant-time — a minor timing side-channel for a shared shield secret); the optional `bypass_api` setting treats any request whose `Accept` header contains `application/json` (as well as `/api/`, `/rest/`, `/jsonapi/` paths) as exempt, which is a broad bypass of the shield if enabled; IP allowlisting can be spoofed if the site trusts client-supplied forwarded headers. Admin routes are permission-gated (`administer www_authenticate`, `view www_authenticate log`, both `restrict access: true`).

Typical setup: enable the module, add one or more credential pairs and any IP/path/role/time rules at `/admin/config/system/www-authenticate`, then review attempts at `/admin/reports/www-authenticate-log`.
---
- Password-protect a staging or pre-launch site with HTTP basic auth.
- Configure multiple username/password pairs for different teams.
- Allowlist office/VPN IPs to skip the auth prompt.
- Denylist specific IPs to always force authentication.
- Protect only selected paths (include mode) or all-but-listed (exclude mode).
- Let logged-in users with a bypass role skip the prompt.
- Restrict access to certain days/hours with the time window.
- Enable the shield only while the site is in maintenance mode.
- Bypass the shield for CLI, Drush, and cron requests.
- Optionally exempt REST/JSON:API requests from the shield.
- Customise the realm and 401 message shown to visitors.
- Log authentication attempts with IP, path, and user-agent.
- Cap and auto-trim the attempt log to a max row count.
- Review failed/successful attempts on the log report page.
- Ensure the settings/log pages stay reachable to admins.
- Add a quick access shield without touching webserver config.
- Combine IP + path rules to protect an admin section only.
- Avoid the `bypass_api` Accept-JSON exemption on sensitive sites.
- Grant `view www_authenticate log` to auditors only.
- Rotate shield credentials from the settings form.
