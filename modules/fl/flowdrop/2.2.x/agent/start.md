<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop (flowdrop) — agent index

Visual workflow editor and runtime: graphs of typed nodes (AI models, data transforms, HTTP,
triggers, branches) executed inside Drupal. Version **2.2.0**, `lifecycle: stable`.
Core **`^11.3`** only, PHP **`>=8.3`**. Depends on `flowdrop:flowdrop_ui_components`.
**18 submodules** — this is a subsystem, not a module. The main module defines the
`flowdrop_node_processor` and `expression_evaluator` plugin types; the suite ships 60+ node
processors and Drush commands (workflow bundles, pipeline traces, trigger tests).

Root permissions: `administer flowdrop` (**restrict**), `administer flowdrop configuration`,
`administer flowdrop trusted publishers` (**restrict**). New in the 2.x confirmation work:
`administer flowdrop confirmation policy` (**restrict**, `flowdrop_node_type`), plus the
`flowdrop_workflow` split of `import flowdrop_workflow` vs `import untrusted flowdrop_workflow`.

**Trusted-publisher design (cite it as the model).** Workflows export as bundles and import — a
supply-chain surface, since an imported workflow can call models, make HTTP requests and touch
content. `Entity/FlowDropTrustedPublisher` holds publisher keys and **signed bundles are verified
before import**; the permission says it plainly: *"Granting trust to a publisher allows its signed
bundles to be imported."* Signature verification + explicit trust + a separate restricted admin
permission + an `import untrusted` bypass permission.

**Governed human-in-the-loop gate (2.1 → 2.2).** A node type can require operator approval before a
side-effecting node runs — covering graph-scheduled nodes AND agent tool calls. 2.2 replaces the
`requires_confirmation` tri-state with a `confirmation` governance map (policy *ask* / *skip* /
derive-from-`HasSideEffectsInterface`, plus author/dynamic control allow-lists) behind
`administer flowdrop confirmation policy`. Hardening: consent consumed atomically under a lock
(no double-authorize), gate questions expire (`gate_expiry` default 72h, fail closed), derivation
errors rather than ungating an unresolvable plugin, and resolved `${{ secrets.* }}` values are
redacted from the persisted gate prompt (the consent hash still binds real values). Non-breaking
upgrade: `drush updatedb`, two order-independent post-updates carry stored tri-states forward.

**SSRF guard on outbound HTTP.** `src/Utility/OutboundUrlSafetyTrait` (used by the `http_request`
node and `flowdrop_interrupt` CallAndWaitNode): http/https only, DNS resolution with the request
pinned to the resolved IP (`CURLOPT_RESOLVE`) against rebinding, per-hop redirect re-validation;
internal targets refused unless `allow_internal_requests` is set. TLS verification is left on
(Guzzle default) — no `verify => false` in the codebase.

Config: no `configure` route in info.yml; settings live at `/admin/flowdrop/config/flowdrop`
(`FlowDropSettingsForm`: logging verbosity, watchdog, default orchestrator, icon picker). Runtime
secrets settings under `flowdrop_runtime` (`SecretSettingsForm`). Config schema shipped.

Submodules: `flowdrop_runtime`, `flowdrop_workflow` + `flowdrop_workflow_executor`,
`flowdrop_session`, `flowdrop_memory`, `flowdrop_stategraph`, `flowdrop_pipeline`,
`flowdrop_orchestration` + `flowdrop_orchestration_connector`, `flowdrop_trigger`,
`flowdrop_job`, `flowdrop_interrupt` (human-in-the-loop / gate), `flowdrop_chat`,
`flowdrop_playground`, `flowdrop_node_type` / `_category` / `_processor`, `flowdrop_ui_components`.

**Caveat:** `flowdrop_ui_components` ships SDC components. With `canvas` also installed, Canvas's
component discovery asserted and fataled the container. FlowDrop was fine once Canvas was removed.
