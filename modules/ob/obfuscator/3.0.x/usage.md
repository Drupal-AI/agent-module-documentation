<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Obfuscator hides information that can expose vulnerabilities — removing the Drupal version from HTML and HTTP headers, asset version strings, and (via .htaccess) disabling TRACE/TRACK.

---

Obfuscator is a hardening module that reduces information disclosure/fingerprinting: it removes the
Drupal version from HTML meta and HTTP response headers, strips asset version query strings from HTML, and
(via .htaccess guidance) disables the HTTP TRACE and TRACK methods. The goal is to make it harder for an
attacker to fingerprint the Drupal version and target known-version vulnerabilities. It is configured at
`obfuscator.admin_settings`.

Use it as a defense-in-depth hardening measure to shrink the fingerprinting surface. **Important framing:
this is security-through-obscurity — a marginal defense, not a real protection.** It does not fix any
vulnerability; it only makes version detection slightly harder (and version can often still be inferred
other ways). The essential control remains keeping Drupal and modules patched. Treat Obfuscator as a minor
hardening add-on layered on top of actual security maintenance, not a substitute for it.

---

- Remove the Drupal version from HTML.
- Remove version from HTTP headers.
- Strip asset version strings.
- Disable TRACE/TRACK via .htaccess.
- Reduce fingerprinting surface.
- Configure at obfuscator.admin_settings.
- Harden against version detection.
- Apply defense-in-depth.
- Understand it is security-through-obscurity.
- Not treat it as real protection.
- Keep Drupal/modules patched (essential).
- Not fix vulnerabilities with it.
- Layer on top of security maintenance.
- Reduce information disclosure.
- Obscure the Drupal version.
- Hide fingerprints.
- Make targeting harder.
- Add a minor hardening measure.
- Complement patching.
- Shrink the fingerprint surface.
