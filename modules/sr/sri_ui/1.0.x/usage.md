<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Subresource Integrity UI lets an administrator add `integrity`, `crossorigin`, `async` and cache-busting query strings to externally hosted JS/CSS from a settings screen, so the browser verifies each CDN file against a pinned SHA-256 hash before running it.

---

An externally hosted script is a standing grant of execution rights to whoever controls that URL — a CDN compromise, a hijacked host, a DNS takeover, or a maintainer republishing a different build under the same path all end with the browser running code nobody reviewed. Subresource Integrity is the platform answer: attach the expected hash and the browser refuses on mismatch. Install with `composer require drupal/sri_ui` and enable it (`ddev drush en sri_ui`); the module adds **no dependencies** and needs no libraries. Configure at **`/admin/config/services/sri`** (permission `administer site configuration`): the feature is **off by default**, so first tick **Enable custom SRI integrity attributes**, then add one entry per external asset — its **full URL** (matching exactly the URL Drupal emits for that library/script), the `integrity` checksum (paste one from https://www.srihash.org/ or leave blank to have it generated on the next refresh), and — importantly — a **`crossorigin`** value such as `anonymous`, because without a CORS-mode fetch the hashed file *fails to load* rather than merely failing to verify. Optional per-entry flags add an `async` attribute, a `query_string` cache-buster, and **Auto hash refresh on page request** (throttled by the *Timeout for next refresh* seconds value). The module also regenerates hashes from the source file on **cron** and via the Drush command **`ddev drush update-assets-hash256`**, downloading each configured URL and recomputing `sha256-…`. After saving, **rebuild caches** (`ddev drush cr`) so the new attributes reach the front end. Note SRI only helps assets Drupal declares as `type: external`; locally hosted or aggregated assets are unaffected, and each listed URL must match byte-for-byte or the attributes are silently not applied.

---

- Add integrity hashes to CDN-hosted libraries.
- Protect against a CDN or upstream host compromise.
- Add a `crossorigin` attribute to an external script.
- Meet a security-audit or pen-test SRI requirement.
- Verify a third-party library before it executes.
- Harden a site that loads external assets.
- Detect an unexpected upstream library change.
- Support a content-security / supply-chain programme.
- Pin a library to a known, reviewed build.
- Reduce third-party supply-chain risk.
- Add SRI without patching a module's `libraries.yml`.
- Generate a hash automatically from the asset URL.
- Refresh hashes on cron or via Drush.
- Append a cache-busting query string to an external asset.
- Add an `async` attribute to a third-party script.
- Centrally manage external-asset attributes from one screen.
- Protect the scripts on a payment or checkout page.
- Document a site's external script dependencies.
- Block execution of a tampered CDN file.
- Support a regulated site's integrity controls.
- Review third-party library updates deliberately (hash mismatch flags them).
