<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Extras (apigee_extras) — agent index

Umbrella project extending the **Apigee Edge** integration (Google API management / developer portal).
Package `Apigee`. Depends on **`apigee_edge`**. Core `^10.3 || ^11.1`. License GPL-2.0-or-later.
Version **1.0.0-beta1**.

## What it actually is

- The base module ships **only** `apigee_extras.info.yml` + `composer.json` + `README.md` (empty body).
  **No** `src/`, no `.module`, no routing, no permissions, no services, no `config/` — it provides no
  runtime behaviour by itself. Its sole job is to require Apigee Edge and to package the two submodules.
- All functionality lives in the two optional submodules below; enable them independently.

## Submodules

- **Apigee Extras Views** (`apigee_extras_views`) — registers an `apigee_app` Views base table with a
  field handler and a query plugin that load developer apps from Apigee Edge storage. →
  [modules/apigee_extras_views/1.0.x/agent/start.md](../modules/apigee_extras_views/1.0.x/agent/start.md)
- **Apigee Extras Bootstrap** (`apigee_extras_bootstrap`) — one `hook_preprocess_status_property()` that
  turns the Apigee status element into a Bootstrap 5 badge. →
  [modules/apigee_extras_bootstrap/1.0.x/agent/start.md](../modules/apigee_extras_bootstrap/1.0.x/agent/start.md)

## Docs

- Project structure & how the pieces fit → [architecture/overview.md](architecture/overview.md)
