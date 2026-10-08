<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multiaccess lets a "source" Drupal site issue one-time login links into "destination" Drupal sites using encrypted server-to-server messages, giving a lightweight cross-site single-sign-on without a full API.

---

The module targets groups of related Drupal sites that should behave as one to the end user. A source site (where the user has an account) holds control of destination sites: given a role mapping between the sites, the source can request a one-time login link (ULI) that logs the user into the destination, creating the account and assigning mapped roles if it does not yet exist. It deliberately has no admin UI, stores nothing in the database and does not use Configuration Manager — all configuration (site UUIDs, URLs, RSA key pairs, role mappings) lives in unversioned local settings files and is driven with Drush (`multiaccess_new_integration()`, `multiaccess_selftest()`, `multiaccess_list()`, and `integrationDestinationFactory()->fromDestinationUuid(...)->uli(...)`). The optional `multiaccess_uli_ui` submodule adds a "Remote sites" tab (`/user/{user}/multiaccess`) and a redirect route (`/multiaccess/redirect/{uuid}`) so users can jump to destinations.

Security posture (recorded finding — Danger 1): the module exposes anonymous API routes `/api/multiaccess/v1/login-link` and `/api/multiaccess/v1/ping` (both `_access: 'TRUE'`, `no_cache`). The login-link endpoint authenticates the caller by whether an inbound payload is decryptable with `openssl_private_decrypt` (RSA), rather than by verifying a signature. Security therefore rests entirely on the destination's "public" key being kept secret between the paired sites, and there is no replay protection on the decryptable message. Note too that in branch 2.x/3.x the `multiaccess_uli_ui` redirect flow deliberately dropped the timestamp+token check that 1.x used, on the design assumption that all sites in the group are equally trusted. Operators must keep every key and settings file out of version control (the README stresses this) and treat any destination as fully controllable by its source. This finding is already recorded; it is documented here only for context.

---

- Provide lightweight cross-site SSO between related Drupal sites
- Issue a one-time login link from a source site into a destination site
- Auto-create the destination account on first login if missing
- Map source-site roles to destination-site roles
- Configure integrations entirely via unversioned settings.php files
- Register a new destination with `multiaccess_new_integration()` (Drush)
- Verify a configuration end-to-end with `multiaccess_selftest()`
- List configured destinations and their UUIDs with `multiaccess_list()`
- Fetch a ULI programmatically via `integrationDestinationFactory()->fromDestinationUuid()->uli()`
- Add a "Remote sites" account tab with the `multiaccess_uli_ui` submodule
- Redirect users to a destination via `/multiaccess/redirect/{uuid}?destination=/path`
- Combine with r4032login on the destination to auto-login on access-denied
- Send a user to a specific destination path after login
- Keep RSA key pairs and integration settings out of version control
- Run the module across multisite or reverse-proxied Docker setups
- Use separate public/internal URLs when developing locally
- Health-check connectivity with the `/api/multiaccess/v1/ping` endpoint
- Restrict a destination to source-controlled login only
- Pair exactly two sites (source, destination) per integration
- Fix already-logged-in "Access denied" with ULI Custom Workflow
- Avoid same-URL/different-port pairings that log users out
- Treat each source site as having full control of its destinations
