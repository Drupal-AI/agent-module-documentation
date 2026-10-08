<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Harvest API (dkan_harvest)

`dkan_harvest` aggregates datasets from other portals: you register a **harvest plan** whose
`extract.uri` points at a remote (or `file://`) `data.json`, then run it to pull, transform and load
those datasets into the local metastore (like "an RSS reader for datasets"). Harvest plans and runs
are stored as entities (`harvest_plan`, `harvest_run`, `harvest_hash`). All API routes set
`_auth: ['basic_auth','cookie']`.

Controller: `Drupal\dkan_harvest\WebServiceApi`. Service: `dkan.harvest.service`
(`Drupal\dkan_harvest\HarvestService`). Extract/transform/load classes live under `src/ETL/…`
(`ETL\Extract\DataJson` performs the fetch via a Guzzle client, or `file_get_contents` for `file://`).

## Routes and access

| Route | Method · Path | Controller · Permission |
| --- | --- | --- |
| `dkan.harvest.1.harvest` | GET `/api/1/harvest` | OpenAPI spec · `access content` |
| `dkan.harvest.api.plans` | GET `/api/1/harvest/plans` | `index` · `harvest_api_index` |
| `dkan.harvest.api.plans.post` | POST `/api/1/harvest/plans` | `register` · `harvest_api_register` |
| `dkan.harvest.api.plans_id` | GET `/api/1/harvest/plans/{identifier}` | `getPlan` · `harvest_api_index` |
| `dkan.harvest.api.plans_id.delete` | DELETE `/api/1/harvest/plans/{identifier}` | `deregister` · `harvest_api_run` |
| `dkan.harvest.api.runs` | GET `/api/1/harvest/runs` | `info` · `harvest_api_info` |
| `dkan.harvest.api.runs.post` | POST `/api/1/harvest/runs` | `run` · `harvest_api_run` |
| `dkan.harvest.api.runs.delete` | DELETE `/api/1/harvest/runs` | `revert` · `harvest_api_run` |
| `dkan.harvest.api.runs_id` | GET `/api/1/harvest/runs/{identifier}` | `infoRun` · `harvest_api_info` |

Every management verb requires a dedicated harvest permission — there is no anonymous or
`access content` path to register or run a harvest. Register body is a full harvest-plan JSON object;
run body is `{"plan_id": "<id>"}`; `info`/`infoRun`/`revert` take `?plan=<id>`. Responses include
`Access-Control-Allow-Origin: *`.

## Behaviour notes

- Registering a plan only stores it; `run` triggers the actual server-side fetch of `extract.uri`.
  Because the URI is operator-supplied and the fetch is server-side, treat the
  `harvest_api_register` / `harvest_api_run` permissions as trusted/administrative and grant them only
  to operators you trust with the site's outbound network position.
- `runHarvest` returns a per-run result (created/updated/unchanged/errored counts); `revertHarvest`
  removes datasets a plan created; orphaned datasets are moved to the `orphaned` moderation state.
- Dashboard UI: `/admin/dkan/datastore/status` (`dkan.harvest.dashboard`). Harvest-run/plan entity
  permissions (`create/view/edit/delete harvest_plan`, `view/delete harvest_run`,
  `administer harvest_plan`/`administer harvest_run`) gate the entity/UI layer.
- Drush: `dkan_harvest` provides `HarvestCommands` (list/register/run/revert/info) as an alternative
  to the API.
