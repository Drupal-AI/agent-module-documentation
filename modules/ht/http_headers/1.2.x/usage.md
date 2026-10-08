<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Headers lets you configure HTTP response headers.

---

HTTP Headers lets you **configure HTTP response headers site-wide** — adding/managing security and policy
headers such as Content-Security-Policy, Strict-Transport-Security (HSTS), X-Frame-Options, Referrer-Policy and
Permissions-Policy on outgoing responses. It provides its own permissions.

Use it to harden your site's HTTP headers. This is a **security-positive** hardening tool: correct headers
mitigate clickjacking, mixed content, some XSS, and enforce HTTPS. Two cautions: configuring headers is a
privileged action (gate the permission to trusted admins, since a bad header — e.g. an over-broad CSP — can
weaken protection or break the site), and test changes (especially CSP/HSTS) before enforcing. It has no
access-control role beyond its permission. Configure the response headers.

---

- Configure HTTP response headers.
- Add CSP/HSTS/X-Frame-Options/etc.
- Harden security headers.
- Provide its own permissions.
- Mitigate clickjacking/mixed content.
- Enforce HTTPS via HSTS.
- BE security-positive.
- Gate configuration to trusted admins.
- Test CSP/HSTS before enforcing.
- Have no access-control role beyond permission.
- Configure the headers.
- Handle HTTP headers.
- Set headers.
- Configure the policy.
- Add headers.
- Handle the response.
- Set security headers.
- Harden headers.
- Restrict the permission.
- Provide HTTP-header configuration.
