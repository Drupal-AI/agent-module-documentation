<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge mechanism — AzurePurger, queuing, manual purge

## Plugins

- **`AzurePurger`** (`src/Plugin/Purge/Purger/AzurePurger.php`, id `azurecdn`) extends
  `PurgerBase`. Annotation: `types = {"path", "wildcardpath"}`, `multi_instance = FALSE`.
  `create()` injects `config.factory` (reads `azure_cdn_purge.settings`) and
  `logger.factory->get('azurecdn')`. `routeTypeToMethod()` maps both types → `invalidate`.
- **`PathQueuer`** (id `path_queuer`) and **`AzureProcessor`** (id `azure_processor`) are empty
  `QueuerBase` / `ProcessorBase` subclasses, both `enable_by_default = true`.

## invalidate() → purgeChunk()

`invalidate(array $invalidations)`:
- returns early if empty;
- `array_chunk($invalidations, chunk_size)`;
- for each chunk after the first, `sleep($chunk_delay)`, then `purgeChunk($chunk)`.

`purgeChunk(array &$invalidations)` (private):
1. Sets each invalidation to `PROCESSING`; builds `$targets_to_purge[]` = `'/' . $invalidation->getExpression()`.
2. Only acts when `$invalidations[0]->getPluginId() == 'path'` (wildcard-typed chunks fall through
   to success without an HTTP call).
3. Reads the Azure params from config.
4. **Token exchange** — `POST https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token` with
   `form_params`: `client_id`, `scope`, `client_secret`, `grant_type=client_credentials`, via
   `\Drupal::httpClient()` (Guzzle, default TLS verification on). Reads `access_token` from the
   decoded JSON.
5. **Purge call** — `POST https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group_name}/providers/Microsoft.Cdn/profiles/{profile_name}/{endpoint_type}/{endpoint_name}/purge?api-version={api_version}`
   with JSON body `{"contentPaths": [...]}` and header `Authorization: Bearer {access_token}`.
6. On success sets every invalidation `SUCCEEDED`. Any `\Exception` sets every invalidation
   `FAILED` and logs `$e->getMessage()` once (`logger->error`).

`hasRuntimeMeasurement()` returns TRUE (Purge measures capacity).

## Debug logging

When config `devel` is TRUE, `purgeChunk()` calls `logger->debug(json_encode($response_auth))`
(the full token-exchange response) and `logger->debug($response)` (the purge response body). Debug
mode is off by default; enable it only transiently for troubleshooting and disable it afterward.

## Automatic queuing on node update

`azure_cdn_purge_node_update(EntityInterface $node)` (`.module`, `hook_node_update`):
- `path_alias.manager` → alias for `/node/{id}`, `ltrim('/')`;
- builds a `path` invalidation via `purge.invalidation.factory`;
- `purge.queue->add(path_queuer, [invalidation])`.

So a node save enqueues its alias; the queued item is invalidated by whichever Purge **processor**
runs (Cron processor, or the module's `azure_processor` when invoked). Only `hook_node_update` is
implemented — creates/deletes and non-node entities are not auto-queued.

## Manual purge form

`AzureCdnPurgeForm` (`src/Form/AzureCdnPurgeForm.php`, route `azure_cdn_purge.purge_form` at
`/admin/config/services/azure/purge`, permission `administer azure cdn purge`, form id
`azure_cdn_purge_settings`):
- textarea `paths`, one path per line, wildcards supported;
- `submitForm()` splits on `\n`; a line containing `*` → `wildcardpath` invalidation, else `path`,
  each `ltrim($item, '\/')`;
- `purge.purgers->invalidate($processor, $invalidations)` where `$processor =
  purge.processors->get('azure_processor')`; shows a success message.
- Note: a submit exception is swallowed (empty `catch`), so a failed manual purge can still show
  no error to the operator; wildcard-only submissions produce no Azure HTTP call (see step 2 above).

## Operating notes

- Requires the Azure app registration to hold **Contributor** on the CDN/Front Door profile.
- Front Door: set `endpoint_type = afdEndpoints` and provide the Front Door endpoint/profile names.
- Tune `chunk_size` / `chunk_delay` to stay under Azure purge rate limits.
