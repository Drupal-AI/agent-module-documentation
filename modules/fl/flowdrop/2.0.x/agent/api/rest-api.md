<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop HTTP/REST API

FlowDrop exposes a JSON API under `/api/flowdrop/*` (and `/api/flowdrop-runtime/*`,
`/flowdrop/api/*`) consumed by the editor front-end and by API clients. `flowdrop.api_exception_
subscriber` keeps these routes' errors machine-readable JSON. **Every route is permission-gated;
all mutating (POST/PUT/PATCH/DELETE) routes additionally require `_csrf_request_header_token`.**
There are no anonymous / `_access: TRUE` endpoints.

Convention: `_permission: 'a+b+c'` is **OR** (any one grants); Drupal ANDs `_permission` with any
`_custom_access` (per-entity ownership check) declared on the route.

## Workflows (`flowdrop_workflow`)

| Method / path | Permission (OR-set) |
|---|---|
| GET `/api/flowdrop/workflows`, `/workflows/{id}`, `/workflows/{id}/export` | `view`+`edit`+`administer flowdrop_workflow`+`administer flowdrop` |
| POST `/api/flowdrop/workflows` (create) | `create flowdrop_workflow`+`administer flowdrop_workflow`+`administer flowdrop` + CSRF |
| PUT `/api/flowdrop/workflows/{id}` | `edit flowdrop_workflow`+… + CSRF |
| DELETE `/api/flowdrop/workflows/{id}` | `delete flowdrop_workflow`+… + CSRF |
| POST `/api/flowdrop/workflows/import` | `import flowdrop_workflow`+… + CSRF (signature-verified) |
| GET `/api/flowdrop/workflows/{id}/schema` | `access workflow schemas` (grant to API consumers without full admin) |

## Run / execute

| Method / path | Permission |
|---|---|
| POST `/api/flowdrop/workflow/{flowdrop_workflow}/run` (executor) | `execute flowdrop_workflow`+`administer flowdrop_workflow`+`administer flowdrop` + CSRF |
| POST `/api/flowdrop/session/{flowdrop_session}/turn` (session) | `execute session workflow`+`administer flowdrop` **AND** `flowdrop_session.update` + CSRF |
| POST `/api/flowdrop/playground/sessions/{id}/messages` (drive) | `_custom_access accessDriveSession` (view + execute capability) + CSRF |

## Pipelines / jobs (`flowdrop_pipeline`, `flowdrop_job`)

Read endpoints gated `view own/any flowdrop_pipeline`+`administer flowdrop` (job-scoped ones add
`view any flowdrop_job` and a `_custom_access` per-pipeline check):
`/api/flowdrop/pipeline/{id}`, `/status`, `/jobs`, `/job-status`, `/logs`,
`/api/flowdrop/workflow/{id}/pipelines`, `/api/flowdrop/job/{id}`. Pipeline signals live at
`/flowdrop/api/pipelines/{id}/cancel|pause|resume` (POST, `_custom_access` owner-or-permission +
CSRF).

## Editor metadata (`flowdrop_node_type`, `flowdrop_node_category`)

GET only, gated `view flowdrop_node_type`+`administer flowdrop` (or the category equivalent):
`/api/flowdrop/nodes`, `/nodes/{category}`, `/nodes/{node_type_id}/metadata`, `/port-config`,
`/api/flowdrop/categories`.

## Interrupts (`flowdrop_interrupt`)

`/api/flowdrop/interrupts` (list), `/interrupts/{id}` (GET/POST resolve), `/{id}/cancel`,
session/pipeline interrupt lists — gated by the view/resolve/cancel own|any interrupt permissions;
mutations require CSRF. **Callback** `/interrupts/{id}/callback` (POST) is the basic-auth,
CSRF-exempt machine path gated on `resolve flowdrop interrupts via callback` (see
runtime/execution.md).

## Triggers (`flowdrop_trigger`)

`/api/flowdrop/triggers` CRUD (`_format: json`): create/update/delete/reset-state require
`administer flowdrop triggers` (**restrict**) + CSRF; get/list/schema/event-types/history require
`view flowdrop triggers`.

## Chat (`flowdrop_chat`) & Playground (`flowdrop_playground`)

- Chat: `/api/flowdrop/workflows/{workflow_id}/chat/messages` (POST/GET/DELETE) gated on
  `use flowdrop_chat`; POST/DELETE require CSRF. (This is the in-editor AI assistant that helps
  build workflows.)
- Playground sessions/messages under `/api/flowdrop/playground/...` and
  `/api/flowdrop/workflows/{id}/playground/sessions` — gated by session view/create permissions and
  `_custom_access` handlers; drive operations (send/stop/reset) require the execute capability +
  CSRF.

## Snapshots (`flowdrop_runtime`)

`/api/flowdrop-runtime/snapshot[s][/{execution_id}]` — GET gated `view own/any
flowdrop_workflow_snapshot`+`access flowdrop runtime api`+`administer flowdrop`; save/delete require
the admin/delete permissions + CSRF.

## Security summary for API reviewers

No route is anonymous or weak-permission-gated for a mutating/execution action. Execution is a
distinct capability from view (the "execute-vs-view split"). CSRF header tokens protect all
cookie-authenticated mutations; the one CSRF-exempt route is basic-auth-only + a dedicated
restricted permission + an unguessable UUID. This is a carefully-gated surface.
