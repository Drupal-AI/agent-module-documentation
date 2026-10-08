<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Enricher Recombee (convivial_enricher_recombee) — agent index

Submodule of [Convivial Enricher](../../../../1.0.x/agent/start.md). Adds the `recombee_user_merge`
EnricherDatasource plugin that merges a visitor's anonymous Recombee user into their identified
user id (via the Recombee PHP SDK) when they are recognised via the enricher token. Package
`Convivial`. Depends on `convivial_enricher` and contrib `recombee`. Core `^10.2 || ^11 || ^12`.
GPL-2.0-or-later. Version 1.0.0-alpha10.

- **The datasource plugin, settings, and the user-merge logic** →
  [plugins/recombee.md](plugins/recombee.md)

## What it provides (from source)

- **Plugin** `RecombeeEnricherDatasource` (id `recombee_user_merge`, subdir
  `Plugin/EnricherDatasource`), extends the parent's `EnricherDatasourceBase`. DI adds
  `request_stack`; logger channel `convivial_enricher_recombee`.
- Uses the **Recombee PHP SDK** (`Recombee\RecommApi\Client`, `Requests\MergeUsers`) provided by
  the contrib `recombee` module. Client constructed inline from the configured account id + token.
- **Hook service** `Hook\ConvivialEnricherRecombeeHooks` — help text only.
- **Schema** `convivial_enricher.datasource.recombee_user_merge`: `recombee_account`,
  `recombee_token`, `recombee_cookie`, `recombee_clientid_prefix` (all string).

No permissions, no routes, no Drush. Plugs into the parent's `enricher` entity and public endpoint.
`processIncomingPath()` is a no-op (leaves the path unchanged).

## Request path (summary)

`fetchAndProcessData($token)` reads the Recombee user id from the cookie named by
`recombee_cookie`, computes `target = recombee_clientid_prefix . $token`, and — if `token` and the
cookie user exist, they differ, and the cookie user isn't already prefixed — sends
`MergeUsers($target, $cookieUser, ['cascadeCreate' => TRUE])`. On success writes cookie
`convivial_enricher_ConvivialEnricherClientId = $target` (1 year). Recombee `ApiException`s are
`logger->error()`-logged. Details in the plugin doc.
