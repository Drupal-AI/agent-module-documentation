<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remove Meta Info manages and removes meta information from the page head and HTTP response headers, for reducing information disclosure.

---

Remove Meta Info manages and removes meta information from the HTML `<head>` and HTTP response headers —
letting administrators strip meta tags/headers they don't want emitted (generator tags, version info, and
other head/header metadata). Like other hardening tools, its main use is reducing information disclosure/
fingerprinting.

Use it to trim unwanted meta tags and headers from output. Two considerations: (1) it is a
hardening/fingerprint-reduction tool — reducing disclosure is defense-in-depth, not a substitute for
keeping software patched; and (2) be careful not to remove meta tags/headers that serve a purpose
(SEO/canonical tags, security headers like CSP/X-Frame-Options) — target only the informational ones you
intend to drop. It has no content-access role. Configure which meta info to remove.

---

- Remove meta info from head/headers.
- Strip generator/version meta.
- Reduce information disclosure.
- Remove unwanted meta tags.
- Trim HTTP response headers.
- Configure what to remove.
- Harden against fingerprinting.
- Not a substitute for patching.
- Avoid removing SEO/security tags.
- Not target CSP/X-Frame-Options.
- Have no content-access role.
- Drop informational meta.
- Manage head metadata.
- Reduce fingerprint surface.
- Remove head/header info.
- Configure meta removal.
- Strip version disclosure.
- Trim output metadata.
- Target informational tags only.
- Reduce disclosure.
