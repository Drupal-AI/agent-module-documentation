<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent Version Disclosure replaces the human-readable `?v=<version>` query string on JavaScript asset URLs with an opaque salted HMAC hash, so page source no longer reveals library/core JS versions. There is no configuration.

---

The module has a single behavior: `hook_js_alter()` iterates every JavaScript asset in the
build and, for any asset with a real `version` (not empty and not `-1`), replaces it with the
first 8 characters of a `Crypt::hmacBase64()` of the version plus a per-site salt. The salt is
128 random bytes generated once with `random_bytes(128)` and stored in State
(`prevent_version_disclosure_salt`), so the hashes are stable for a site but not guessable
across sites. The result is deterministic per version+salt, which preserves cache-busting
(the query string still changes when a library's version changes) while hiding the actual
version number — e.g. `jquery.min.js?v=3.7.1` becomes `jquery.min.js?v=d5t4a2hC`. This matters
most on pages where Drupal's JS aggregation is off, such as `install.php` and `update.php`,
where raw `?v=` version strings would otherwise be visible in source. The only other code is
`hook_help()`, which renders the module's README through `league/commonmark`. This is a "defense
in depth" / anti-fingerprinting measure; the project itself describes it as minor
security-by-obscurity.

**Coverage note (hardening, not a vulnerability):** it only rewrites **JavaScript** asset
versions. It does **not** touch CSS asset `?v=` query strings, the `<meta name="Generator">`
tag, the `X-Generator` HTTP header, `Expires`/other headers, or version info embedded inside
JS/library code itself. Pair it with modules like *Remove Generator Meta Tags* and *Remove
HTTP Headers* (both referenced in its README) to cover those vectors.

---

- Hide jQuery/core/library JS version numbers from page source for anti-fingerprinting.
- Reduce "version disclosure" findings in automated security scanner reports.
- Mask JS asset versions on `install.php` and `update.php`, where aggregation doesn't apply.
- Add a defense-in-depth hardening layer without any configuration.
- Keep cache-busting behavior while obscuring the underlying version string.
- Produce site-specific, non-guessable version hashes via a random per-site salt.
- Harden a public-facing site against casual reconnaissance of installed JS libraries.
- Combine with Remove Generator Meta Tags to also hide the Drupal generator meta tag.
- Combine with Remove HTTP Headers to also strip the X-Generator / Server version headers.
- Satisfy a compliance/pentest checklist item requiring suppressed asset version strings.
- Deploy on staging/production where scanners flag `?v=` version query parameters.
- Avoid revealing when a specific vulnerable library version is (or isn't) patched.
- Leave development environments readable by simply not enabling the module there.
- Rotate the obscured hashes site-wide by deleting the stored salt state value.
- Set-and-forget hardening: no admin form to configure, monitor, or keep in sync.
- Reduce the information a targeted attacker can gather about your JS dependency stack.
