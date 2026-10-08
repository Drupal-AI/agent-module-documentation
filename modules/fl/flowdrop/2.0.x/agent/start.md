<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop (flowdrop) — agent index

Visual, code-free **workflow orchestration** for Drupal. A workflow is a `flowdrop_workflow`
**config entity**: a graph of typed nodes (AI models, data transforms, HTTP, entity ops,
gateways, triggers) with typed-port edges, run by a pluggable **Orchestrator** engine that
records every run as a **pipeline** of one **job** per node.

- Installed on-disk: **2.5.0**, `lifecycle: stable`. Doc dir label: `2.0.x`.
- Core **`^11.3` only**; PHP **`>=8.3`**. Package `FlowDrop`, `drupal/flowdrop`, GPL-2.0-or-later.
- Base module depends only on `flowdrop:flowdrop_ui_components`; the real capability lives in
  **~18 submodules** — treat this as a subsystem, not a module.
- External libs: symfony/expression-language, symfony/property-access, loilo/jsonpath (JSONPath),
  dragonmantank/cron-expression (cron triggers), league/html-to-markdown, d34dman/vanilla-icon-picker.

## What the base `flowdrop` module itself provides

- **Plugin types (@api):** `FlowDropNodeProcessor` (node processors — the executable node behind
  each node type; attribute `Drupal\flowdrop\Attribute\FlowDropNodeProcessor`, manager
  `flowdrop.node_processor_plugin_manager`) and `ExpressionEvaluator`
  (`ExpressionLanguageEvaluator`, `PropertyPathEvaluator`, `TwigEvaluator`). Also a
  **DashboardCard** plugin type + a declarative dashboard extension API (see `flowdrop.api.php`,
  `MODULE.flowdrop_dashboard*.yml`).
- **Config entity:** `flowdrop_trusted_publisher` (Ed25519 publisher keys for verifying signed
  workflow bundles). Bundle transport services: `flowdrop.bundle_canonicalizer`,
  `flowdrop.bundle_signer`, `flowdrop.bundle_verifier`, `flowdrop.trusted_publisher_resolver`.
- **Boundary services (null by default, overridden by submodules/providers):**
  `flowdrop.chat_reasoner` (`ChatReasonerInterface`, `NullChatReasoner` until an AI provider
  overrides it), `flowdrop.execution_ledger` (tool at-most-once; `flowdrop_memory` overrides).
- **Secrets:** `flowdrop.resolved_secret_registry` (request-scoped plaintext, never persisted) +
  `flowdrop.secret_scrubber` (exact-match removal of secret values from persisted job data).
- **Other services:** `flowdrop.entity_serializer`, `flowdrop.schema_form_builder` (FlowDropSchema
  = a documented JSON-Schema subset), `flowdrop.api_exception_subscriber` (keeps `/api/flowdrop/*`
  errors JSON), DTOs for nodes/edges/tools/reasoning under `src/DTO/**`.
- **Routes (all `_permission: 'administer flowdrop'`):** dashboard `/admin/flowdrop`, `/config`,
  `/structure`, settings form `/admin/flowdrop/config/flowdrop`, trusted-publisher collection.
- **Permissions:** `administer flowdrop` (**restrict**), `administer flowdrop configuration`,
  `administer flowdrop trusted publishers` (**restrict**).

## Read next

- [entities/entities.md](entities/entities.md) — all config + content entity types, by submodule.
- [plugins/node-processors.md](plugins/node-processors.md) — the node-processor plugin type,
  processor interfaces, and the 40+ built-in nodes.
- [plugins/plugin-types.md](plugins/plugin-types.md) — Orchestrator, ExpressionEvaluator,
  FlowDropEventType (triggers), DashboardCard.
- [runtime/execution.md](runtime/execution.md) — execution modes, runtime, pipelines/jobs,
  StateGraph, interrupts, secrets.
- [api/rest-api.md](api/rest-api.md) — every `/api/flowdrop/*` endpoint and its permission gate.
- [submodules/submodules.md](submodules/submodules.md) — one-line role per submodule.

## Trust boundary (document this, do not treat it as a bug)

**Workflow authorship is equivalent to broad site access** and is deliberately `restrict access`
(`create/edit/administer flowdrop_workflow`, `import flowdrop_workflow`). A workflow author can
place nodes that call LLMs, make outbound HTTP requests, evaluate Twig/ExpressionLanguage, and
query/save entities. The permission descriptions say so explicitly. Powerful node effects are an
*intended, admin-gated* capability, the same class as ECA/Rules/Twig-field-formatter. The HTTP
node still applies an SSRF guard (`OutboundUrlSafetyTrait`) as defence in depth. See
runtime/execution.md for the full posture.

## Caveats

- Drupal **`^11.3` current-edge only**.
- `flowdrop_ui_components` ships **SDC** components; with the **Canvas** module also installed,
  Canvas's component discovery has been observed to assert-fatal the container. FlowDrop itself
  works once Canvas is removed.
- AI nodes need a provider: `flowdrop_ai_provider` bridges the AI / AI Agents modules and overrides
  `flowdrop.chat_reasoner`. Without a provider, the `Reason` node validates but performs no
  inference (null reasoner).
