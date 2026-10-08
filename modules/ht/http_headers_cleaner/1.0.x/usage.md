<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP-Headers cleaner removes configured HTTP response headers and meta tags, for reducing information disclosure / fingerprinting.

---

HTTP-Headers cleaner strips configured HTTP response headers and HTML meta tags from responses — a
hardening tool for removing information-disclosure/fingerprinting signals such as `X-Generator`,
generator meta tags, or other headers that reveal the stack. A response subscriber removes headers
matching admin-configured patterns, and a meta cleaner removes matching meta tags. It provides its own
permissions and lives in the Security package.

Use it to reduce fingerprinting surface (version/generator disclosure) as part of a hardening baseline.
It only **removes** headers/tags per configuration — it does not add security headers. Two things to
keep in mind: configure it to remove only informational headers (removing security headers like CSP or
X-Frame-Options would weaken the site, so don't target those), and pair it with a module that *adds*
security headers (e.g. Seckit) if you need those — this module is the "reduce disclosure" half, not the
"add protections" half.

---

- Remove information-disclosure HTTP headers.
- Strip generator/version headers.
- Remove fingerprinting meta tags.
- Reduce stack disclosure.
- Configure header-removal patterns.
- Remove X-Generator and similar.
- Harden against fingerprinting.
- Provide its own permissions.
- Remove matching meta tags.
- Only remove, not add, headers.
- Avoid removing security headers.
- Pair with a security-header module.
- Reduce fingerprinting surface.
- Clean response headers.
- Configure which headers to strip.
- Remove server/tech signals.
- Part of a hardening baseline.
- Not target CSP/X-Frame-Options.
- Strip meta generator tags.
- Reduce information disclosure.
