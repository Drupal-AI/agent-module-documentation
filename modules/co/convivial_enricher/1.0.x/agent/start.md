<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Enricher (convivial_enricher) — agent index

Progressive profiling: publishes a public endpoint path that, when hit with a token, fetches a
visitor's contact data from an external service and writes it into browser cookies (prefixed
`convivial_enricher_`), then redirects to a `return_to` URL. Package `Convivial`. Depends on
`convivial_core`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.0-alpha10.

- **The `enricher` config entity, its admin routes/permission, and the endpoint→cookie request flow** →
  [config/enrichers.md](config/enrichers.md)
- **The `EnricherDatasource` plugin type, base class, and the `dummy` datasource** →
  [plugins/datasources.md](plugins/datasources.md)
- Submodules (own doc trees):
  [ActiveCampaign](../../modules/convivial_enricher_active_campaign/1.0.x/agent/start.md),
  [Mailchimp](../../modules/convivial_enricher_mailchimp/1.0.x/agent/start.md),
  [Recombee](../../modules/convivial_enricher_recombee/1.0.x/agent/start.md).

## What it provides (from source)

- **Config entity** `enricher` (`src/Entity/Enricher.php`, `@ConfigEntityType`, config prefix
  `enricher`, `admin_permission = "administer enricher"`). Exports `name`, `label`, `status`,
  `description`, `endpoint_path`, `datasources`. Implements `EntityWithPluginCollectionInterface`;
  `postSave()` calls `router.builder->rebuild()` so a new endpoint path becomes a live route.
- **Permission** `administer enricher` (`restrict access: true`) — gates every admin route.
- **Plugin type** `EnricherDatasource` — manager `plugin.manager.enricher.datasource`
  (`EnricherDatasourceManager`, namespace `Plugin/EnricherDatasource`, attribute
  `Drupal\convivial_enricher\Attribute\EnricherDatasource`, legacy annotation of the same name,
  alter hook `convivial_enricher_datasource_info`). Base `EnricherDatasourceBase`.
- **Services** (`convivial_enricher.services.yml`): `convivial_enricher.route_subscriber`
  (`EventSubscriber\EnricherEndpointRouteSubscriber` — builds the endpoint route per enabled
  enricher), `convivial_enricher.path_processor` (`PathProcessor\InboundPathProcessor`, priority
  10000 — lets datasources rewrite the inbound URL), `convivial_enricher.helper` (`EnricherHelper`
  — decodes the data param, runs datasources, sets cookies, returns the redirect), and the hook
  service `Hook\ConvivialEnricherHooks` (help text only).
- **Controller** `Controller\EnricherController::build($enricher_id, $data)` → delegates to
  `EnricherHelper::processIncomingData()`.
- **Ships** one datasource plugin: `dummy` (`Plugin/EnricherDatasource/DummyEnricherDatasource`).

## Admin routes (`convivial_enricher.routing.yml`, all `_permission: administer enricher`)

- `entity.enricher.collection` — `/admin/config/convivial/enricher` (list; `configure` route).
- `entity.enricher.add_form` / `edit_form` / `delete_form` under `/admin/config/convivial/enricher…`.
- `convivial_enricher.datasource_add_form` / `datasource_edit_form` / `datasource_delete` —
  manage a datasource instance on an enricher (`Form\EnricherDatasource*Form`).

## The runtime endpoint (generated, not in routing.yml)

- `EnricherEndpointRouteSubscriber::alterRoutes()` adds, per **enabled** enricher, a route
  `/{endpoint_path}/{data}` (id `enricher_endpoint.endpoint.<id>`) with **`_access: TRUE`** and
  default `data = 'request_keys'`, pointing at `EnricherController::build`.
- `InboundPathProcessor::processInbound()` loads enabled enrichers and calls each datasource's
  `processIncomingPath(&$path, $endpoint_path)` — e.g. ActiveCampaign/Mailchimp rewrite
  `/{endpoint}/{token}/{return/to}` into `/{endpoint}/data:<base64(return_to=…&token=…)>`.
- `EnricherHelper::processIncomingData()` base64-decodes the `data:` param with
  `parse_str(base64_decode(...))`, and **only if `return_to` is non-empty** builds a 307
  `RedirectResponse($return_to)`, calls each `datasource->fetchAndProcessData($token)`, attaches
  every returned `Cookie` to the response, and returns it. Empty `return_to` → 404.

## Config schema (`config/schema/convivial_enricher.schema.yml`)

`convivial_enricher.enricher.*` (config_entity: name, label, endpoint_path, description,
`datasources` sequence of {uuid,id,weight,settings}), plus per-plugin
`convivial_enricher.datasource.[id]` mappings (`dummy` → `dummy_title`).

No Drush. No update hooks. `hook_help` is the only functional hook.
