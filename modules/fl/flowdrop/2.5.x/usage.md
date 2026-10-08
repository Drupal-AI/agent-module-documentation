<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop is a drag-and-drop workflow-orchestration subsystem for Drupal: workflows are graphs of typed nodes — AI models, data transforms, HTTP calls, entity queries and saves, triggers, branches, loops — assembled visually and executed by a runtime inside Drupal. Its README frames the whole lifecycle as create, manage, run and track: build a flow on the canvas, keep it as an exportable config entity, run it synchronously, asynchronously or as a checkpointed state graph, and read back a pipeline record with one job per node.

---

The category is familiar from n8n, Zapier and Node-RED, and the argument for having it inside Drupal rather than beside it is data gravity. A workflow that reads entities, calls a model, writes the result back and notifies someone does not need to leave the site, cross an authentication boundary or replicate the content model somewhere else. With eighteen submodules the suite is closer to a subsystem than a module: a runtime and executor, session and memory handling for conversational flows, an orchestration layer with connectors, triggers, a pipeline abstraction, a state graph, a job system, an interrupt mechanism for human-in-the-loop steps, a chat surface and a playground for trying nodes out. The base module defines two plugin types (`flowdrop_node_processor` and `expression_evaluator`); the processor library ships around 73 node-processor classes across AI, data, HTTP and control flow, which the 2.5 README markets as "25+ built-in nodes" (earlier docs quoted 60+ — a wording change, not a capability cut).

**The trusted-publisher design is still the part worth singling out.** Workflows can be exported as bundles and imported, which is exactly the shape of a supply-chain problem — an imported workflow can call models, make HTTP requests and touch content. FlowDrop's answer is `FlowDropTrustedPublisher` entities holding a base64 Ed25519 public key, with the permission's own description spelling out the consequence: *"Granting trust to a publisher allows its signed bundles to be imported."* The verifier checks a detached Ed25519 signature over the canonical bytes of the payload that will actually be imported, using the key from the site's trust store rather than from the bundle, and it refuses a valid signature whose declared publisher does not match the key id or whose publisher is not enabled. There is an explicit trust decision, a separate `import untrusted flowdrop_workflow` permission for bypassing it, a restricted permission for administering publishers, and — new since 2.2 — an admin UI (list builder plus an add/edit form that validates the key length before saving). That architecture is right, and it is rare in contrib.

**The governed human-in-the-loop gate carries forward from 2.1/2.2.** A node type can require operator approval before a side-effecting node executes — covering both graph-scheduled nodes and nodes an AI agent invokes as tools mid-turn. Policy is *ask* / *skip* / derive-from-side-effects, owned by a dedicated `administer flowdrop confirmation policy` permission, with consent consumed atomically under a lock, gate questions that expire and fail closed, and resolved `${{ secrets.* }}` values redacted from the persisted gate prompt while the consent hash still binds the real values.

**Outbound HTTP nodes carry an SSRF guard.** `OutboundUrlSafetyTrait` validates any caller-supplied URL: http/https only, DNS resolution with the request pinned to the resolved IP (`CURLOPT_RESOLVE`) to close the DNS-rebinding window, and per-hop re-validation of redirects. Internal targets are refused unless `allow_internal_requests` is set explicitly. The TLS defaults are unchanged (Guzzle verifies certificates); there is no `verify => false` anywhere. Secrets stay out of storage too: with the Key module, `${{ secrets.NAME }}` resolves at runtime into a request-scoped, in-memory registry, and a scrubber exact-match-redacts those values from anything a node echoes into a persisted job record.

Two caveats. It requires Drupal `^11.3` — current-edge only, PHP `>=8.3`. And it ships **SDC components** through `flowdrop_ui_components`; on an earlier review install those components together with `canvas` triggered an assertion fatal in Canvas's component discovery. FlowDrop itself was fine once Canvas was removed.

---

- Build an automation workflow visually as a graph of typed nodes.
- Chain an AI model into a data pipeline as one controlled step.
- Call an external HTTP API from a workflow (with built-in SSRF protection).
- Transform and reshape data between steps.
- Query and save Drupal entities inside a flow.
- Trigger a workflow automatically from a Drupal entity, user or form event.
- Run a scheduled workflow on a cron expression.
- Run a flow synchronously, asynchronously on a queue, or as a resumable state graph.
- Track every run as a pipeline with one job per node (inputs, outputs, timing, failures).
- Pause a workflow for human approval, a choice, a form or free-text input.
- Require operator confirmation before a side-effecting node runs.
- Gate an AI agent's tool call (e.g. sending an email) behind approval.
- Govern which node types demand confirmation, and who may waive it.
- Let expired approval questions fail closed and cancel an abandoned run.
- Reference credentials as ${{ secrets.NAME }} instead of storing them in config.
- Build a conversational flow with scoped memory and tool-calling nodes.
- Expose a chat surface backed by a workflow.
- Branch and loop a workflow on conditions and gateways.
- Compose complex automation by nesting workflows inside workflows.
- Try a node out interactively in the playground.
- Export a workflow as a signed bundle and import it only from a trusted publisher.
- Verify an imported bundle's Ed25519 signature against a trusted publisher key.
- Cancel, pause or resume a running pipeline from the interrupt inbox.
- Diagnose and repair a broken stored workflow with the Doctor form.
- Separate who may build workflows from who grants publisher trust and who governs gates.
- Orchestrate several workflows together via connectors.
- Convert markdown to HTML inside a workflow.
- Drive workflow bundles, pipeline traces and trigger tests from Drush.
- Keep automation next to the content it acts on instead of in an external tool.
