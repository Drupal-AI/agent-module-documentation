<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop submodules

The base `flowdrop` module is small (dashboard, plugin-type definitions, bundle
signing/verification, secret registry). The capability lives in ~18 submodules. All are
`core_version_requirement: ^11.3`, package `FlowDrop`, on-disk version 2.5.0.

| Submodule | Lifecycle | Role |
|---|---|---|
| **flowdrop_ui_components** | stable | Foundational SDC (Single Directory Components) for the dashboard/editor UI. No deps. Base module depends on it. (Canvas-conflict caveat — see start.md.) |
| **flowdrop_node_type** | stable | `flowdrop_node_type` + `port_shape` config entities; node metadata REST API; visual-types/confirmation-policy config. |
| **flowdrop_node_category** | stable | `flowdrop_node_category` config entity (palette sections) + categories API. |
| **flowdrop_node_processor** | stable | The 40+ built-in `FlowDropNodeProcessor` plugins (data, gateways, entity, HTTP, text/markdown, AI/tools). See plugins/node-processors.md. |
| **flowdrop_workflow** | stable | `flowdrop_workflow` config entity — store/version/manage workflow definitions; workflow REST API (CRUD/import/export/schema); editor + doctor; Drush bundle commands. |
| **flowdrop_workflow_executor** | stable | Run a workflow (sync/async), incl. from within another workflow; `POST .../workflow/{id}/run`. |
| **flowdrop_orchestration** | stable | The `Orchestrator` plugin type, contracts, confirmation-gate + interrupt DTOs, helper services. The execution abstraction. |
| **flowdrop_orchestration_connector** | stable | Bridges FlowDrop to the **Orchestration** contrib module — an `orchestration.invoke` event type + poll subscriber so external automation platforms can invoke workflows. |
| **flowdrop_runtime** | stable | Execution engine: queue-based processing, real-time monitoring, workflow snapshots, execute/secrets admin surface; ships the synchronous + asynchronous orchestrators. |
| **flowdrop_pipeline** | stable | `flowdrop_pipeline`(+type) content entity — a run's status and its jobs; pipeline REST API; rerun/generate/clear jobs; Drush pipeline-trace. |
| **flowdrop_job** | stable | `flowdrop_job`(+type) content entity — one node execution (status/input/output/timing); job REST API; Views. |
| **flowdrop_session** | stable | `flowdrop_session` + `flowdrop_session_message` content entities and services for interactive/conversational runs; session-turn API. |
| **flowdrop_memory** | stable | Scoped, pluggable memory (static/cached/entity-backed `memory_record`); overrides the execution ledger for tool at-most-once semantics. |
| **flowdrop_stategraph** | stable | Checkpointed, resumable orchestrator with reducers + human-in-the-loop; `state_checkpoint` entity, approval gates; test/debug UI. |
| **flowdrop_interrupt** | stable | Human-in-the-loop: `flowdrop_interrupt` entity, inbox, resolve/cancel APIs, pipeline cancel/pause/resume signals, basic-auth machine callback. |
| **flowdrop_trigger** | stable | `flowdrop_trigger_config` entity + `FlowDropEventType` plugins: run workflows on entity/user/form events and cron; trigger REST API; Drush trigger-test. |
| **flowdrop_chat** | **experimental** | LLM chat endpoints for **AI-assisted workflow building** in the editor. Depends on `flowdrop_ai_provider`, memory, workflow executor. Gated on `use flowdrop_chat`. |
| **flowdrop_playground** | stable | Interactive playground: manually run/test workflows through a chat-style UI; playground session/message APIs. |

## Notable dependency facts

- `flowdrop_chat` requires `flowdrop_ai_provider:flowdrop_ai_provider` (a separate project that
  bridges the AI / AI Agents modules and overrides `flowdrop.chat_reasoner`). It is the only
  submodule marked `experimental`.
- `flowdrop_orchestration_connector` requires `drupal:orchestration` (the Orchestration contrib
  module) — that module provides the authenticated external-platform transport; the connector only
  bridges to FlowDrop's trigger system.
- Content-entity submodules (`flowdrop_job`, `flowdrop_pipeline`, `flowdrop_session`) pull in
  `options`, `text`, `user`, `views`.
