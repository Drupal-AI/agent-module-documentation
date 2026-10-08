<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provide a JWKS URI for verifying Islandora's JWT tokens.

---

Islandora JWKS provides a JWKS (JSON Web Key Set) URI for Islandora's JWT tokens — publishing the PUBLIC keys used to verify Islandora-issued JWTs at a standard `/.well-known`-style endpoint, so external services (microservices, gateways) can validate those tokens.

A JWKS endpoint exposes public keys only (by design); the private signing key stays server-side (managed by the JWT module). Depends on `islandora` and `jwt`; supports Drupal 10 and 11.

---

- Publish a JWKS URI.
- Expose public JWT verification keys.
- Let services validate Islandora JWTs.
- Serve a standard key-set endpoint.
- Keep the private key server-side.
- Expose public keys only.
- Depend on `islandora` and `jwt`.
- Support Drupal 10 and 11.
- Configure the endpoint.
- Aid microservices.
- Handle JWKS.
- Verify tokens
- Support Drupal.
- Support Drupal.
- Support Drupal.
