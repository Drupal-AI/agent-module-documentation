<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Script SRI attaches `integrity` and `crossorigin` attributes to externally hosted `<script>` files that are already declared in your site's module/theme `libraries.yml`, so the browser refuses to run a file whose contents have changed.

---

Every externally loaded script is a standing grant of execution rights to whoever controls that URL: a CDN compromise, a hijacked host, a DNS takeover, or a maintainer republishing a new build under the same path all make the browser run code the site never reviewed. **Subresource Integrity** is the platform answer — attach the expected hash and the browser compares before executing, refusing on mismatch. This module is small and specific about *how* it does that. It does **not** let you type in arbitrary script URLs and it does **not** fetch any script server-side to compute a hash. Instead its form at `/admin/config/system/sri-configuration` (behind the `administer external_script_sri` permission, `restrict access: true`) scans every installed module and theme's `*.libraries.yml`, lists the `js` entries whose path is **external** (`https://`, `http://`, or protocol-relative `//`) in a read-only table, and asks the administrator to paste an SRI hash (generate it yourself, e.g. at `srihash.org`), pick a `crossorigin` value (`anonymous` or `use-credentials`), and optionally tick **Mark as Sensitive**. A single `hook_library_info_alter()` then injects `attributes.integrity` and `attributes.crossorigin` onto the matching library so Drupal renders `<script … integrity="…" crossorigin="…">`. Two things decide whether it helps or breaks the site. First, **`crossorigin` is mandatory for SRI to function at all** — the browser needs a CORS-mode fetch to inspect the response and the host must send permissive CORS headers, or the script fails to load rather than merely failing verification. Second, **a hash pins one exact file**: when upstream ships an update the script stops loading until the hash is refreshed, so pin versioned URLs and treat a hash change as a deliberate review step. One counter-intuitive quirk to remember: ticking **Mark as Sensitive** *suppresses* SRI for that row (the alter hook skips sensitive entries), so a "sensitive" script is left without an integrity attribute — the checkbox is an exclude toggle, not extra protection. Because it only decorates scripts already declared by other extensions, it cannot add SRI to scripts hard-coded in a template or attached inline; those must be moved into a `libraries.yml` entry first. Released version 1.0.1, core `^9.5 || ^10 || ^11`, package Security, no dependencies, no Drush, no config schema.

---

- Add `integrity` hashes to CDN-hosted scripts declared by contrib or theme libraries.
- Protect against a CDN or third-party host compromise serving altered JS.
- Meet a security-audit or penetration-test requirement for SRI on external assets.
- Verify a third-party script has not changed before the browser executes it.
- Add `crossorigin` attributes to external JS for correct CORS-mode loading.
- Harden a site that pulls JavaScript libraries from external URLs.
- Detect (by failed load) an unexpected upstream library update.
- Support a Content Security Policy / supply-chain-hardening programme.
- Pin a specific, versioned library file so silent upstream changes are blocked.
- Reduce supply-chain risk from externally hosted dependencies.
- Satisfy a compliance control requiring integrity verification of remote scripts.
- Protect scripts loaded on a payment or login page from tampering.
- Add SRI without editing any theme template or writing custom code.
- Manage integrity hashes for several external scripts from one admin table.
- Enumerate which external scripts the installed modules/themes actually load.
- Deliberately exclude a fragile/dynamic CDN script from SRI via "Mark as Sensitive".
- Apply SRI centrally instead of per-module patches to `libraries.yml`.
- Turn a hash update into a required review checkpoint when a vendor ships a new build.
- Document and centralize the crossorigin policy for each external library.
- Roll SRI out across a multisite by exporting the module's config.
