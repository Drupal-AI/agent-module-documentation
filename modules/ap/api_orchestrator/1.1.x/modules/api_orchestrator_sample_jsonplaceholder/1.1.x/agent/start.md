<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Sample: JSONPlaceholder (api_orchestrator_sample_jsonplaceholder) — agent index

Zero-config REST demo integration. Depends on `api_orchestrator`, `api_orchestrator_integration_samples`, `api_orchestrator_mirror`. Config-only (no PHP `src/`).

## Provides
- One `api_orchestrator_service` (`jsonplaceholder`, base URL jsonplaceholder.typicode.com) and five REST `api_orchestrator_endpoint` entities (e.g. `jp_list_posts`) installed via `config/install`.
- `hook_install` prints a getting-started message; `hook_uninstall` deletes the sample endpoints (queried by `service_id = jsonplaceholder`) and the service.

Try it: `drush api-orchestrator:request jp_list_posts`, then view the request at `/admin/config/services/api-orchestrator/request`. Pair with an `api_mirror` to display the posts.
