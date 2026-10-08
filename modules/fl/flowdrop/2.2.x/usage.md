<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop is a drag-and-drop workflow editor: workflows are graphs of typed nodes — AI models, data transforms, HTTP calls, triggers, branches — assembled visually and executed by a runtime inside Drupal.

---

The category is familiar from n8n, Zapier and Node-RED, and the argument for having it inside Drupal rather than beside it is data gravity. A workflow that reads entities, calls a model, writes the result back and notifies someone does not need to leave the site, cross an authentication boundary or replicate the content model somewhere else. With eighteen submodules the suite is closer to a subsystem than a module: a runtime and executor, session and memory handling for conversational flows, an orchestration layer with connectors, triggers, a pipeline abstraction, a state graph, a job system, an interrupt mechanism for human-in-the-loop steps, a chat surface and a playground for trying nodes out. The main module now defines 60+ node processors across the suite (AI, data, HTTP, control flow) via the `flowdrop_node_processor` plugin type.

**The trusted-publisher design is still the part worth singling out.** Workflows can be exported as bundles and imported, which is exactly the shape of a supply-chain problem — an imported workflow can call models, make HTTP requests and touch content. FlowDrop's answer is `FlowDropTrustedPublisher` entities holding publisher keys, with the permission's own description spelling out the consequence: *"Granting trust to a publisher allows its signed bundles to be imported."* Signature verification before import, an explicit trust decision, a separate `import untrusted flowdrop_workflow` permission for bypassing it, and a restricted permission for administering publishers. That is the right architecture, and it is rare in contrib.

**2.1 and 2.2 add a governed human-in-the-loop gate.** A node type can require operator approval before a side-effecting node executes — covering both graph-scheduled nodes and nodes an AI agent invokes as tools mid-turn. In 2.2 the old `requires_confirmation` tri-state becomes a `confirmation` governance map (policy *ask* / *skip* / derive-from-side-effects, plus author- and runtime-control allow-lists), owned by a dedicated `administer flowdrop confirmation policy` permission split off before tagging so it is never a BC break. The gate is hardened before shipping: consent consumption is atomic under a lock (one approval can no longer authorize two executions), gate questions expire (`gate_expiry`, default 72h) and fail closed, side-effect derivation errors rather than silently ungating an unresolvable plugin, and resolved `${{ secrets.* }}` values are redacted from the persisted gate prompt while the consent hash still binds the real values.

**Outbound HTTP nodes carry an SSRF guard.** `OutboundUrlSafetyTrait` validates any caller-supplied URL: http/https only, DNS resolution with the request pinned to the resolved IP (`CURLOPT_RESOLVE`) to close the DNS-rebinding window, and per-hop re-validation of redirects. Internal targets are refused unless `allow_internal_requests` is set explicitly. The TLS defaults are unchanged (Guzzle verifies certificates); no `verify => false` anywhere.

Two caveats. It requires Drupal `^11.3` — current-edge only, PHP `>=8.3`. And it ships **SDC components** through `flowdrop_ui_components`; on an earlier review install those components together with `canvas` triggered an assertion fatal in Canvas's component discovery. FlowDrop itself was fine once Canvas was removed.

---

- Build an automation workflow visually.
- Chain an AI model into a data pipeline.
- Call an external HTTP API from a workflow (with built-in SSRF protection).
- Transform data between steps.
- Trigger a workflow from a Drupal event.
- Run a scheduled workflow as a job (cron expressions supported).
- Pause a workflow for human approval.
- Require operator confirmation before a side-effecting node runs.
- Gate an AI agent's tool call (e.g. sending an email) behind approval.
- Govern which node types demand confirmation, and who may waive it.
- Let expired approval questions cancel an abandoned run automatically.
- Reference credentials as ${{ secrets.NAME }} instead of storing them in config.
- Build a conversational flow with memory.
- Expose a chat surface backed by a workflow.
- Branch a workflow on a condition.
- Model a process as a state graph with approval gates.
- Try a node out in the playground.
- Export a workflow as a signed bundle.
- Import a workflow only from a trusted publisher.
- Separate who may build workflows from who grants trust and who governs gates.
- Orchestrate several workflows together via connectors.
- Convert markdown to HTML inside a workflow.
- Drive workflow bundles, pipeline traces and trigger tests from Drush.
- Keep automation next to the content it acts on.
- Replace an external automation tool for Drupal-centric work.
