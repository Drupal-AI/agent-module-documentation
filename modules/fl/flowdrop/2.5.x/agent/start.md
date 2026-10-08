<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop (flowdrop) — agent index

Visual **workflow-orchestration** subsystem for Drupal: graphs of typed nodes (AI models, data
transforms, HTTP, triggers, branches, gateways, loops, nested workflows) built on a drag-and-drop
canvas and executed inside Drupal. Version **2.5.0**, `lifecycle: stable`.
Core **`^11.3`** only, PHP **`>=8.3`**. Depends on `flowdrop:flowdrop_ui_components`.
Comparison points: n8n, Zapier, Node-RED — the reason to run it *inside* Drupal is data gravity.

**18 submodules — a subsystem, not a module.** The base module defines two plugin types
(`flowdrop_node_processor`, `expression_evaluator`); the node-processor library (`flowdrop_node_processor`,
~48 plugins; ~73 processor classes across the whole suite — the README markets this as "25+
built-in nodes") covers data, control-flow, entity ops, HTTP and AI. Workflows are Drupal **config
entities** (`drush cex`/`cim`). Drush commands ship for bundles, pipeline traces and trigger tests.

## Lifecycle framing (README)
- **Create/Edit** — visual editor, typed ports, colour-coded data types, visible edges.
- **Manage** — workflows are config entities; Node Types/Categories configure pre-set node variants.
- **Run** — three execution modes: **synchronous** (in-request), **asynchronous** (queue), and
  **StateGraph** (checkpointed, resumable — chat, loops, human-in-the-loop). Event **triggers**
  (entity/user/cron/external). **Human-in-the-loop** interrupt nodes pause for input.
- **Track** — every run is a **pipeline** record with one **job** per node (inputs/outputs/timing/failures).

## Config
No `configure` route in info.yml. Base settings at **`/admin/flowdrop/config/flowdrop`**
(`FlowDropSettingsForm`: logging verbosity, watchdog, default orchestrator `flowdrop_runtime:synchronous`,
Iconify icon picker). Which Key-module keys workflows may resolve is set separately at
`/admin/flowdrop/config/secrets` (`flowdrop_runtime` `SecretSettingsForm`), gated on
`administer flowdrop runtime` (allowing a key is what lets an author *spend* a credential they cannot read).
Config schema shipped.

## Permissions (root + notable submodule)
Root: `administer flowdrop` (**restrict**), `administer flowdrop configuration`,
`administer flowdrop trusted publishers` (**restrict**). Node-type: `administer flowdrop_node_type`,
`administer flowdrop confirmation policy` (**restrict** — governs the gate), `administer flowdrop_port_shape`.
Workflow: `create/edit/delete/view/execute flowdrop_workflow`, `access workflow schemas`,
`import flowdrop_workflow` **vs** `import untrusted flowdrop_workflow` (the trust-bypass split).
Interrupt: `view/resolve/cancel own|any flowdrop interrupts`, `resolve flowdrop interrupts via callback`,
`cancel any`/`pause any flowdrop workflow`. Session: `execute session workflow`. Playground:
`execute playground workflow`. Stategraph: `manage approval gates`. Runtime: `access flowdrop runtime api`,
`administer flowdrop_workflow_snapshot`.

## Security model (cite it as the model; all present, posture unchanged from 2.2)
**Trusted-publisher signed-bundle import.** Workflows export as bundles and import — a supply-chain
surface (an imported workflow can call models, make HTTP requests, touch content). `Entity/FlowDropTrustedPublisher`
holds a base64 **Ed25519** public key; `Service/Bundle/BundleVerifier` verifies a detached signature over the
canonical bytes of the *payload that will be imported* (`sodium_crypto_sign_verify_detached`). The verifying key
comes from the site's trusted-publisher store, **never from the bundle**; the payload's declared `publisher`
must equal the signature `key_id`; a valid signature from an unknown/disabled publisher is reported *untrusted*.
Trusting a publisher is an explicit admin action behind the restricted permission; bypassing verification needs
the separate `import untrusted flowdrop_workflow`.

**SSRF guard on outbound HTTP.** `src/Utility/OutboundUrlSafetyTrait`: http/https only; resolve host and pin
the request to the resolved IP via `CURLOPT_RESOLVE` (closes DNS-rebinding on the initial request); re-validate
every redirect hop (`on_redirect`), `strict`/`referer` off, hops held to http/https; private/reserved IPs refused
unless the node sets `allow_internal_requests`. Outbound requests use Guzzle's default TLS verification.

**Secrets kept out of config/records.** With Key, `${{ secrets.NAME }}` resolves at runtime.
`Service/Secret/ResolvedSecretRegistry` holds the substituted plaintext **in-memory, per-request only**
(never state/cache/durable); `Service/Secret/SecretScrubber` exact-match-redacts those exact strings (`***`,
longest-first) out of any job output or error text a node echoes back.

**Governed human-in-the-loop gate** (`flowdrop_node_type` `ConfirmationSettings`/`ShippedConfirmationPolicy`):
a node type can require operator approval before a side-effecting node runs — graph-scheduled nodes AND
agent tool calls. Policy *ask*/*skip*/derive-from-`HasSideEffectsInterface`, behind
`administer flowdrop confirmation policy`; consent consumed atomically, `gate_expiry` fails closed,
resolved secrets redacted from the persisted prompt.

## API routes (all gated; CSRF on every state-changing op)
`/api/flowdrop/*` (workflows CRUD/import/export/run, nodes, categories, triggers, chat, playground sessions/
messages, interrupts, pipelines/jobs/logs, session turn) — each carries a `_permission` (OR-superset with
`administer flowdrop`) and, for POST/PUT/PATCH/DELETE, `_csrf_request_header_token: TRUE`; several add
`_custom_access` for per-entity ownership (pipeline-jobs, playground drive-vs-view, pipeline signal cancel/
pause/resume). The outbound call-and-wait callback `flowdrop_interrupt.api.callback` authenticates via
`_auth: [basic_auth]` with the `resolve flowdrop interrupts via callback` permission and an interrupt UUID.
`FlowDropApiExceptionSubscriber` keeps those routes' 403/404 machine-readable JSON.

## Submodules
`flowdrop_runtime` (engine + secret settings + snapshot REST API), `flowdrop_workflow` + `flowdrop_workflow_executor`
(entity + `/run` executor), `flowdrop_session`, `flowdrop_memory`, `flowdrop_stategraph` (checkpoints/approval gates),
`flowdrop_pipeline`, `flowdrop_orchestration` + `flowdrop_orchestration_connector`, `flowdrop_trigger`,
`flowdrop_job`, `flowdrop_interrupt` (human-in-the-loop / gate / pipeline signals), `flowdrop_chat`,
`flowdrop_playground`, `flowdrop_node_type` / `_category` / `_processor`, `flowdrop_ui_components` (SDC/Svelte editor).

## Diff 2.2.x → 2.5.x
Same 18-submodule architecture, same core `^11.3` / PHP `>=8.3`, same dependency
(`flowdrop_ui_components`), same library set. Same architecture for trusted-publisher Ed25519 import,
outbound-URL trait, secret registry/scrubber, and confirmation gate (all still present). README reframed around a
**Create / Manage / Run / Track** lifecycle and now markets "**25+ built-in nodes**" (2.2 docs said 60+/65+;
the plugin tree actually holds ~73 processor classes — a wording change, not a capability cut). Observable
surface in 2.5 includes the trusted-publisher **admin UI** (list builder + add/edit form with key-length
validation), pipeline **signal endpoints** (cancel/pause/resume, per-pipeline `_custom_access` + CSRF),
a workflow **Doctor** recovery form, a **snapshot REST API**, a node-identity slim-format migration, and the
`flowdrop_workflow_executor` `/run` endpoint.

## Caveat
`flowdrop_ui_components` ships SDC components. On an earlier review install those together with the **Canvas**
module triggered an assertion fatal in Canvas's component discovery; FlowDrop was fine once Canvas was removed.
Test that combination in non-production first.
