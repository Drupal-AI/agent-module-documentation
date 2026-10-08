<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Well-Known Paths lets an administrator define `/.well-known/` URLs and their response bodies from the Drupal UI, storing them as configuration instead of dropping static files into the docroot where the next deployment might clean them away.

---

The `.well-known` prefix (RFC 8615) is where the web keeps machine-readable metadata: `security.txt`, `apple-app-site-association` and `assetlinks.json` for mobile deep-link association, `change-password` hints, `openid-configuration`, and various domain-ownership proofs. Serving these normally means a static file in the docroot, which is awkward on a Composer-managed or managed-hosting site (Acquia, Pantheon, etc.) where the docroot is rebuilt on deploy and hand-placed files are fragile. This module makes each one configuration: a settings form at `/admin/config/development/well-known` (gated by `administer site configuration`) holds a list of `name`/`value` pairs in `wellknown.settings:paths`; a route subscriber (`WellKnownRouteSubscriber`) reads that config and registers a dynamic, anonymous route `/.well-known/<name>` for each, and `WellKnownController::response()` returns the stored value as the body. Because the definitions live in config, they export with `drush cex` and deploy like any other configuration and stay identical across environments. There is no plugin system and no bundled providers — every path is one you enter by hand. Note the release is 1.0.0-alpha2 (alpha), the responses default to a `text/html` content type, and the schema/default-config files sit in non-standard directories (`schema/`, `install/`) that core does not auto-discover.

---

- Serve a security.txt (RFC 9116) file for a vulnerability-disclosure contact.
- Publish an apple-app-site-association file for iOS Universal Links.
- Serve assetlinks.json for Android App Links / deep-link verification.
- Prove domain ownership to a third-party service via a well-known token URL.
- Add a `/.well-known/` path without shell or filesystem access to the docroot.
- Keep well-known files intact through every deployment.
- Manage well-known response content as exportable configuration.
- Export and import well-known paths with `drush cex` / `drush cim`.
- Change a domain-verification token without a code deploy.
- Serve a `change-password` well-known redirect for password managers.
- Publish a machine-readable point of contact or policy file.
- Serve `openid-configuration` or similar metadata at a fixed path.
- Satisfy an SSL/TLS certificate authority's HTTP-based domain validation.
- Add a `/.well-known/` path required by a payment or wallet provider.
- Meet an app store's association-file requirement from the Drupal UI.
- Keep well-known responses identical across dev, stage, and production.
- Avoid docroot clutter and lost files on a Composer-built site.
- Add or remove several well-known paths at once from one admin table.
- Return a fixed plaintext response at any custom `/.well-known/<name>`.
- Run domain verification on managed hosting where file access is restricted.
- Provide a well-known path for a bug-bounty or disclosure programme.
- Inspect all defined paths in one place with `drush cget wellknown.settings`.
