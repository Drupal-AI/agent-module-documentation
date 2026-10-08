<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `recombee_user_merge` datasource

`modules/convivial_enricher_recombee/src/Plugin/EnricherDatasource/RecombeeEnricherDatasource.php`.
Id `recombee_user_merge`, label *"Recombee user merge"*. Extends the parent's
`EnricherDatasourceBase`; DI adds `request_stack`; logger channel `convivial_enricher_recombee`.

## Settings (`buildConfigurationForm()`)

- `recombee_account` (required) — Recombee database "API Identifier".
- `recombee_token` (required) — Recombee private token.
- `recombee_cookie` (required, default `RecombeeUserId`) — the browser cookie the contrib Recombee
  module sets with the anonymous Recombee user id.
- `recombee_clientid_prefix` (required, default `ac_`) — prefix used to build the identified
  target user id.

Schema `convivial_enricher.datasource.recombee_user_merge` (all string).

## `fetchAndProcessData($token)`

1. `getClient()` lazily builds `new Recombee\RecommApi\Client($recombee_account, $recombee_token,
   ['serviceName' => 'drupal-convivial-enricher-recombee'])`.
2. Reads the source id from the request cookie:
   `requestStack->getCurrentRequest()->cookies->get($recombee_cookie)`.
3. `target_user_id = recombee_clientid_prefix . $token`.
4. Guard: proceeds only if `$token` and the cookie user are both set, `target != cookieUser`, and
   `strpos(cookieUser, prefix) === FALSE` (i.e. the cookie user isn't already an identified id).
5. `client->send(new MergeUsers($target_user_id, $recombee_userid, ['cascadeCreate' => TRUE]))` —
   merges the anonymous Recombee user into the identified one (creating the target if missing).
6. On success: `createCookie('ConvivialEnricherClientId', $target_user_id, '+1 year')` → cookie
   `convivial_enricher_ConvivialEnricherClientId`.
7. `Recombee\RecommApi\Exceptions\ApiException` is caught; if the decoded message has a `message`,
   it is `logger->error()`-logged with the status code. Returns the (possibly empty) cookie array.

## Notes

- TLS/transport are handled inside the Recombee SDK (default HTTPS); this class sets no transport
  options and disables no verification.
- The Recombee private token is stored in the enricher config entity's datasource settings (as
  strings), like the other datasources' credentials.
- `processIncomingPath()` returns the path unchanged — this datasource does not reshape the inbound
  URL; it relies on another datasource (or a `data:` URL) to supply the token.
