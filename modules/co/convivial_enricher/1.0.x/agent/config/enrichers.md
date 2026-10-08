<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enricher config entity, admin UI, and the endpoint→cookie flow

## Install / enable

`drush en convivial_enricher` (pulls in `convivial_core`). Enable one integration submodule
(ActiveCampaign / Mailchimp / Recombee) or rely on the `dummy` datasource for testing. Configure at
**`/admin/config/convivial/enricher`** (menu item *Convivial Enricher* under Convivial Core's admin
menu, `convivial_enricher.links.menu.yml`). All admin routes require permission
**`administer enricher`** (`restrict access: true` — "most powerful permission", grant to trusted
roles only).

## The `enricher` config entity

`src/Entity/Enricher.php` — `@ConfigEntityType(id = "enricher")`, config prefix `enricher`,
`admin_permission = "administer enricher"`. `entity_keys`: id = `name`, label = `label`, uuid.
`config_export`: `name`, `label`, `status`, `description`, `endpoint_path`, `datasources`.

- Implements `EntityWithPluginCollectionInterface`; `getDatasources()` returns an
  `EnricherDatasourcePluginCollection` (lazy, weight-sorted). `addEnricherDatasource()` /
  `deleteEnricherDatasource()` mutate that collection by generated uuid.
- `postSave()` calls `\Drupal::service('router.builder')->rebuild()` — **saving or enabling an
  enricher regenerates the endpoint route** (route builder injected via a `\Drupal::service`
  pseudo-factory because config entities can't take constructor DI).
- Handlers: `list_builder` = `EnricherListBuilder`; forms add=`EnricherAddForm`,
  edit=`EnricherEditForm`, delete=core `EntityDeleteForm`.

Schema `convivial_enricher.enricher.*` (config/schema): `name`, `label`, `endpoint_path`,
`description`, and `datasources` — a sequence of mappings `{uuid, id, weight, settings}` where
`settings` uses the dynamic type `convivial_enricher.datasource.[%parent.id]`.

## Admin routes (`convivial_enricher.routing.yml`)

| Route | Path | Handler |
| --- | --- | --- |
| `entity.enricher.collection` | `/admin/config/convivial/enricher` | `_entity_list: enricher` |
| `entity.enricher.add_form` | `…/add` | `_entity_form: enricher.add` |
| `entity.enricher.edit_form` | `…/manage/{enricher}` | `_entity_form: enricher.edit` |
| `entity.enricher.delete_form` | `…/manage/{enricher}/delete` | `_entity_form: enricher.delete` |
| `convivial_enricher.datasource_add_form` | `…/manage/{enricher}/add/{enricher_datasource}` | `Form\EnricherDatasourceAddForm` |
| `convivial_enricher.datasource_edit_form` | `…/manage/{enricher}/datasources/{enricher_datasource}` | `Form\EnricherDatasourceEditForm` |
| `convivial_enricher.datasource_delete` | `…/datasources/{enricher_datasource}/delete` | `Form\EnricherDatasourceDeleteForm` |

Every requirement is `_permission: 'administer enricher'`. The datasource forms
(`EnricherDatasourceFormBase` + Add/Edit/Delete) embed the plugin's own
`buildConfigurationForm()`/`submitConfigurationForm()` and persist the result into the enricher
entity's `datasources` array.

## The generated runtime endpoint

Not declared in routing.yml — built at cache-rebuild time by
`EventSubscriber\EnricherEndpointRouteSubscriber::alterRoutes()`:

- For every **enabled** enricher (`status = 1`), adds route id `enricher_endpoint.endpoint.<id>`
  with path `/{endpoint_path}/{data}`, controller
  `\Drupal\convivial_enricher\Controller\EnricherController::build`, defaults
  `enricher_id = <id>`, `data = 'request_keys'`, requirement **`_access: TRUE`** (public), options
  `nocache: TRUE`.

Request handling:

1. `PathProcessor\InboundPathProcessor::processInbound()` (tagged `path_processor_inbound`,
   priority 10000) loads enabled enrichers and calls each datasource's
   `processIncomingPath(&$path, $endpoint_path)`. Path-rewriting datasources (ActiveCampaign,
   Mailchimp) turn a human URL `/{endpoint}/{token}/{return/to/path}` into
   `/{endpoint}/data:<base64_encode("return_to={return_to}&token={token}")>` so Drupal's router
   can match a single `{data}` slug. `dummy` and Recombee leave the path unchanged.
2. `EnricherController::build($enricher_id, $data)` → `EnricherHelper::processIncomingData($data,
   $enricher_id)`.
3. `EnricherHelper` (`src/EnricherHelper.php`): `dataToArray()` does
   `parse_str(base64_decode(preg_replace('/^data:/','',$data)), $keys)`. If `return_to` is present
   and non-empty, it builds `new RedirectResponse($return_to)` with status **307**
   (`HTTP_TEMPORARY_REDIRECT`), loads the enricher, and for each datasource calls
   `fetchAndProcessData($token)` (token = decoded `token` key). Every returned value that is a
   `Symfony\Component\HttpFoundation\Cookie` is attached via `$response->headers->setCookie()`.
   Empty/missing `return_to` → `NotFoundHttpException` (404).

## Cookies

Datasources build cookies through `EnricherDatasourceBase::createCookie($name, $value, $expire)`
→ `Cookie::create('convivial_enricher_' . $name, $value, $expire, '/', NULL, FALSE, FALSE, FALSE,
NULL)` (path `/`, default domain, and the remaining flags left at their `Cookie::create` positional
values). These cookies carry the allow-listed enrichment values for client-side profile tools
(e.g. Basil) to consume. Default expiry `+1 day`.

## Operating notes

- A datasource that throws during fetch is caught and `logger->warning()`-logged under channel
  `convivial_enricher`; the visitor still gets redirected (possibly with no/partial cookies).
  Troubleshoot from *Reports → Recent log messages*.
- Known interaction: using this with the Redirect module can cause a redirect loop
  (drupal.org redirect issue #3037259) — noted in the README.
