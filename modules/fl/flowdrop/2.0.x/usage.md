<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop is a visual, code-free workflow orchestration module for Drupal: a workflow is a config-entity graph of typed nodes — AI models, data transforms, HTTP calls, entity queries, branches, triggers — assembled in a drag-and-drop editor and run by a pluggable engine that records every run as a pipeline of jobs. Requires Drupal `^11.3` and PHP `>=8.3`; ships ~18 submodules and behaves as a subsystem, not a single module.

---

The category is familiar from n8n, Zapier and Node-RED, and the argument for hosting it inside Drupal rather than beside it is data gravity: a workflow that reads entities, calls a model, writes the result back and notifies someone never leaves the site, crosses an auth boundary or replicates the content model elsewhere. A workflow is a `flowdrop_workflow` config entity holding nodes and typed-port edges, so it exports to YAML and deploys with `drush cex/cim`. Nodes are `FlowDropNodeProcessor` plugins (65+ built in via `flowdrop_node_processor`: data/dataframe ops, gateways and loops, entity query/save, HTTP request, text/markdown, and AI prompting/tool-calling); site builders add pre-configured variants as `flowdrop_node_type` config entities grouped by `flowdrop_node_category`. Execution runs through an `Orchestrator` plugin (`flowdrop_orchestration`) — synchronous, asynchronous (queue), or the checkpointed StateGraph — driven by `flowdrop_runtime`, producing a `flowdrop_pipeline` with one `flowdrop_job` per node for a full audit trail. Conversational and long-running flows get `flowdrop_session` + `flowdrop_session_message`, scoped pluggable `flowdrop_memory`, and human-in-the-loop pauses via `flowdrop_interrupt`. `flowdrop_trigger` fires workflows on entity/user/form/cron events, and `flowdrop_orchestration_connector` exposes them to external automation platforms through the Orchestration module. `flowdrop_chat` and `flowdrop_playground` are interactive surfaces; `flowdrop_workflow_executor` and the `/api/flowdrop/workflow/{id}/run` endpoint launch runs; `flowdrop_ui_components` supplies the SDC visual language. The security posture is unusually careful for contrib: workflow authorship is `restrict access` and documented as equivalent to broad site access (a workflow can call models, make HTTP requests and mutate content); the HTTP node carries a real SSRF guard (scheme allow-list, private/reserved-IP rejection, DNS pinning via `CURLOPT_RESOLVE`, and per-hop redirect re-validation); mutating API routes require a CSRF header token; secrets resolve at runtime through the Key module and are scrubbed from persisted job data; and bundles are Ed25519-signed and imported only from `flowdrop_trusted_publisher` keys an admin has explicitly trusted. Two caveats: it is Drupal `^11.3` current-edge only, and its `flowdrop_ui_components` SDC components have been observed to trip an assertion fatal in the Canvas module's component discovery when both are installed.

---

- Build an automation workflow visually in a drag-and-drop editor.
- Chain an AI/LLM model into a multi-step data pipeline.
- Call an external HTTP API from inside a workflow (with SSRF-guarded requests).
- Query and save Drupal entities as workflow steps.
- Transform, map and reshape data between nodes.
- Branch a workflow on a boolean/switch condition.
- Loop or repeat over a collection of items.
- Run a workflow synchronously, asynchronously (queue), or as a checkpointed StateGraph.
- Track every run as a pipeline with one inspectable job per node.
- Pause a workflow for a human confirmation, choice, form or free-text input.
- Answer a paused workflow from a machine caller over a signed callback endpoint.
- Trigger a workflow automatically on entity create/update/delete or user login/logout.
- Schedule a workflow on a cron expression.
- Expose a workflow to an external automation platform (n8n/Zapier-style) via the Orchestration connector.
- Build a conversational flow with sessions and scoped memory.
- Expose an in-editor AI chat that helps build workflows (`flowdrop_chat`).
- Try nodes and run workflows interactively in the playground.
- Call one workflow from within another (nested workflows).
- Keep API credentials out of config with `${{ secrets.NAME }}` Key-module references.
- Export a workflow as an Ed25519-signed bundle and import it only from a trusted publisher.
- Separate who may build workflows from who grants publisher trust and who allows secret keys.
- Configure pre-set node variants and palette categories without writing code.
- Extend the palette with custom node processors, triggers and orchestrators as PHP plugins.
- Replace an external automation tool for Drupal-centric integration work.
- Model a stateful, resumable process (chat agent, approval chain) as a graph.
