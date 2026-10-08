<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Checkpost

Config object `checkpost.settings` at `/admin/config/development/checkpost`:
- `enabled` — master switch. When false, the middleware passes all requests through.
- `pages` — path patterns always allowed (matched against alias and internal path, case-insensitive).
- `headers` — list of `{name, value}`; a request is allowed if the header is present (empty value) or matches the value.
- `ips` — allowed client IPs (binary-searched, so the stored list is expected sorted).
- `cidrs` — allowed CIDR ranges (`cidrCheck` via `ip2long` masking).

Flow (`CheckpostMiddleware::handle`): if not enabled → pass; else allow on first matching page, header, IP, or CIDR; otherwise return `403 Access Denied`.
