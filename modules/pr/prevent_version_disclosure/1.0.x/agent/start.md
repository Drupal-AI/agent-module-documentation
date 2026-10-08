<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent Version Disclosure — agent index

Single-purpose hardening module: rewrites the `?v=<version>` query on **JavaScript** asset
URLs to an opaque salted HMAC hash so page source doesn't reveal JS/library/core versions.
**No configuration, no permissions, no settings, no Drush, no config schema.** Install and it
works. Requires the `league/commonmark` library (used only to render the README on the help
page). Core `^10 || ^11`.

## How it works (`prevent_version_disclosure.module`)

- `hook_js_alter()` — for each JS asset with a real `version` (not empty, not `-1`):
  `$item['version'] = substr(Crypt::hmacBase64($version . $salt, 'prevent_version_disclosure' . $salt), 0, 8);`
- **Salt**: 128 random bytes from `random_bytes(128)`, generated once and stored in State as
  `prevent_version_disclosure_salt`. Deterministic per site (stable cache-busting) but
  non-guessable across sites. Delete that state key to rotate all hashes.
- `hook_help()` — renders `README.md` via `league/commonmark` (`html_input: strip`,
  `allow_unsafe_links: false`). No other behavior.

## Coverage / limits (it's partial hardening, by design)

Only JavaScript versions are hashed. It does **NOT** cover: CSS asset `?v=` versions, the
`<meta name="Generator">` tag, the `X-Generator` HTTP header, other response headers, or
version strings baked into library code. Combine with *remove_generator* and
*remove_http_headers* for those. The maintainer frames this as minor security-by-obscurity /
defense-in-depth.

No solution docs beyond this index — there is no config, plugin, hook, API, or theming surface
to document.
