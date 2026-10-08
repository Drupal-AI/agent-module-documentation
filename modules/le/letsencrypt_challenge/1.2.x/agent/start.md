<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Let's Encrypt Challenge (letsencrypt_challenge) — agent index

Serves the ACME **HTTP-01** validation response from Drupal so a TLS certificate can be
issued/renewed on a host where you cannot drop the challenge file into the docroot yourself
(PaaS, read-only image, docroot rebuilt on deploy). An admin pastes the key-authorization value
into a form; two anonymous `/.well-known/acme-challenge` routes echo it back to the ACME
validation server.

No dependencies. Core `^8 || ^9 || ^10 || ^11`. Newest release on this branch is **1.2.0-beta1**
(no stable is tagged on 1.2.x). Configure route: `letsencrypt_challenge.challenge_form`
(`/admin/config/letsencrypt_challenge/challenge`). No config object and no config schema — the
value is stored in **state**. No Drush commands, no plugins, no public services.

- **Set the challenge value; the form, routes, state key, request-time flow** → [configure/challenge.md](configure/challenge.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission: `administer letsencrypt challenge` (gates the admin form only).
- State key: `letsencrypt_challenge.challenge` (default `''`), read/written via `\Drupal::state()`.
- Serving routes (both `methods: [GET]`, `_access: 'TRUE'`, `_disable_route_normalizer: 'TRUE'`):
  - `letsencrypt_challenge.challenge_controller_content` → `/.well-known/acme-challenge`
  - `letsencrypt_challenge.challenge_controller_content_key` → `/.well-known/acme-challenge/{key}`
- Controller `\Drupal\letsencrypt_challenge\Controller\ChallengeController::content()` (service arg
  `state`) returns a `CacheableResponse` whose body is the state value. It takes no arguments, so
  the `{key}` path segment is not read and both routes return the same single stored value.
- `hook_uninstall()` deletes the state key; `hook_help()` handles `help.page.letsencrypt_challenge`.
