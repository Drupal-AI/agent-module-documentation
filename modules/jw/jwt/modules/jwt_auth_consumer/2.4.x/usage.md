<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JWT Authentication Consumer turns the base JWT module's generic auth provider into a working login: it resolves and loads the Drupal user named by a validated token's `drupal.uid` / `drupal.uuid` / `drupal.name` claim.

---

This submodule is the piece that makes `Authorization: Bearer <jwt>` actually authenticate a request. The base `jwt` module verifies a token's signature and fires the `VALIDATE` and `VALID` events but ships no logic to say *who* the token belongs to. `jwt_auth_consumer` registers a single event subscriber (`JwtAuthConsumerSubscriber`, service `jwt_auth_consumer.subscriber`) on both events. On `VALIDATE` it looks in the token payload for a nested `drupal.uid`, then `drupal.uuid`, then `drupal.name` claim (first populated wins), loads the matching user, and invalidates the token if no user is found or the user is blocked; it also back-fills the `drupal.uid` claim to streamline the later step. On `VALID` it loads that same user and sets it as the authenticated account. It has no configuration, no permissions, no routes and no schema — enabling it is the entire setup. It pairs with `jwt_auth_issuer` (which stamps the `drupal.uid` claim when minting tokens) but will authenticate any correctly-signed token carrying one of the three identity claims, regardless of how it was produced.

---

- Authenticate REST/JSON:API requests that present a signed JWT with a `drupal.uid` claim.
- Turn on Bearer-token login for a decoupled front-end without writing an event subscriber.
- Resolve the acting user from a token's `drupal.name` (username) claim.
- Resolve the acting user from a token's `drupal.uuid` claim across environments where uids differ.
- Reject tokens whose identity claim points at a non-existent account.
- Reject tokens for a user account that has been blocked.
- Complete the round trip with `jwt_auth_issuer` so a token minted at `/jwt/token` authenticates later requests.
- Accept tokens minted by `jwt_oauth_ccf` (which also stamps `drupal.uid`) for machine-to-machine calls.
- Authenticate a Views REST export display that has the `jwt_auth` authentication option enabled.
- Provide the standard uid/uuid/name claim contract to any external issuer that signs with the site key.
- Back-fill the `drupal.uid` claim automatically when only a uuid or name was supplied.
- Keep authentication stateless — no session, resolved fresh from the claim on each request.
- Combine with the base module's page-cache request policy so authenticated responses are never cached.
- Serve as a reference implementation of subscribing to `JwtAuthEvents::VALIDATE` and `::VALID`.
- Authenticate service accounts identified by uid for scheduled integrations.
- Debug failed logins by enabling `$settings['jwt.debug_log']` and checking why a claim did not resolve.
