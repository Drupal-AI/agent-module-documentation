<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
API Sync is a Salesforce-Suite-style framework that synchronizes Drupal entities to and from a remote REST / OData API (built for Microsoft Navision / Business Central).

---

API Sync (`apisync`) is the base module of a seven-submodule suite that connects Drupal to an external OData v4 REST service. The base provides the OData client (`ODataClient`, service `apisync.odata_client`), a pluggable authentication layer (the `apisync_auth` config entity plus the `ApiSyncAuthProvider` plugin type and its manager `plugin.manager.apisync.auth_providers`), global settings (`apisync.settings`: instance/metadata URLs, cache lifetimes, push/pull queue limits, standalone mode), and `odata:*` Drush commands. Authentication is supplied by submodules — `apisync_basicauth` (HTTP Basic) or `apisync_oauth` (OAuth2 client-credentials via the `oauth2_client` module). Mapping (`apisync_mapping`) defines `apisync_mapping` config entities and `apisync_mapped_object` content entities that tie a Drupal entity/bundle to a remote object type through field-mapping plugins; `apisync_mapping_ui` adds the admin UI; `apisync_pull` imports remote records into Drupal (cron or standalone endpoint, queue workers) and `apisync_push` exports Drupal entity CRUD to the remote (real-time or async queue). `apisync_logger` centralizes suite log events to the `apisync` logger channel. It is a developer/integrator framework: you enable an auth provider, set the instance URL, create an authorization config, define mappings and field maps, then let cron or standalone endpoints move data. Data exchanged may be PII; the external credentials and endpoint URL are administrator-configured (gate them behind the `administer apisync` / `authorize apisync` permissions, which are restricted).

---

- Synchronize Drupal content entities with a Microsoft Navision / Business Central OData API.
- Integrate Drupal with any conformant REST / OData v4 service.
- Query remote objects from Drupal via `ODataClient::query()` / `queryAll()` / `queryMore()`.
- Read, create, update, and delete remote records (`objectRead`/`objectCreate`/`objectUpdate`/`objectDelete`).
- Authenticate to the API with HTTP Basic auth (`apisync_basicauth`).
- Authenticate to the API with OAuth2 client-credentials (`apisync_oauth` + `oauth2_client`).
- Configure the instance URL, metadata (`$metadata`) URL, and cache lifetimes centrally.
- Map a Drupal entity type + bundle to a remote object type (`apisync_mapping`).
- Track each synced entity with a revisioned `apisync_mapped_object` record.
- Define per-field maps with pluggable field types (properties, constant, token, related IDs, related properties).
- Pull remote records into Drupal on cron, honoring a trigger date and a custom WHERE clause.
- Pull a single remote record on demand by API Sync ID.
- Push Drupal entity inserts/updates/deletes to the remote in real time.
- Queue push operations asynchronously per mapping and process them on cron.
- Run queue processing through standalone HTTP endpoints (cron-key protected) instead of cron.
- Prune mapped-object revisions and purge stale mappings via Drush.
- List remote object types and describe their fields via `drush odata:list-objects` / `odata:describe-fields`.
- Run ad-hoc OData queries via `drush odata:query-object`.
- Whitelist which remote entity types / entity sets are available on the API.
- Centralize error / warning / notice logging for the whole suite (`apisync_logger`).
- Manage mappings, mapped objects, and authorization providers through an admin UI (`apisync_mapping_ui`).
- Extend the suite with custom auth providers, field-mapping plugins, or push-queue processors.
- Respond to sync lifecycle events (pull/push allowed, params, query) via the event system.
