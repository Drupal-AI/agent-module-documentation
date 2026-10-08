<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop (flowdrop) — agent index

Visual **workflow-orchestration** subsystem for Drupal: graphs of typed nodes (AI models, data
transforms, HTTP, triggers, branches, gateways, loops, nested workflows) built on a drag-and-drop
canvas and executed inside Drupal. Version **2.6.0** (first stable 2.x release), `lifecycle: stable`.
Core **`^11.3`** only, PHP **`>=8.3`**. Depends on `flowdrop:flowdrop_ui_components`.
Comparison points: n8n, Zapier, Node-RED — the reason to run it *inside* Drupal is data gravity.

**18 submodules — a subsystem, not a module.** The base module defines two plugin types
(`flowdrop_node_processor`, `expression_evaluator`); the node-processor library (`flowdrop_node_processor`,
~48 plugins; ~73 processor classes across the whole suite — the README markets this as "25+
built-in nodes") covers data, control-flow, entity ops, HTTP and AI. Workflows are Drupal **config
entities** (`drush cex`/`cim`). Drush commands ship for bundles, pipeline traces, trigger tests, and
the new retention dry-run report.

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
Iconify icon picker). The shipped `config/install/flowdrop.settings.yml` also carries a **`retention:`**
block (per-type `mode`/`max_age`/`failure_max_age`) that is **declarative only in this release** — both
`off` and `delete` behave as `off`, nothing is ever deleted, there is no sweeper and no cron hook;
`drush flowdrop:retention:report` is the dry run. Which Key-module keys workflows may resolve is set
separately at `/admin/flowdrop/config/secrets` (`flowdrop_runtime` `SecretSettingsForm`), gated on
`administer flowdrop runtime` (allowing a key is what lets an author *spend* a credential they cannot
read). Config schema shipped.

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

## Security model (cite it as the model; all present, posture unchanged in 2.6)
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
(`FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE`) unless the node sets `allow_internal_requests`.
Outbound requests use Guzzle's default TLS verification (no `verify => false` anywhere in the tree).

**Secrets kept out of config/records.** With Key, `${{ secrets.NAME }}` resolves at runtime.
`Service/Secret/ResolvedSecretRegistry` holds the substituted plaintext **in-memory, per-request only**
(never state/cache/durable); `Service/Secret/SecretScrubber` exact-match-redacts those exact strings (`***`,
longest-first) out of any job output or error text a node echoes back.

**Governed human-in-the-loop gate** (`flowdrop_node_type` `ConfirmationSettings`/`ShippedConfirmationPolicy`):
a node type can require operator approval before a side-effecting node runs — graph-scheduled nodes AND
agent tool calls (including the 2.6 editor WebMCP tools the AI Assistant invokes). Policy
*ask*/*skip*/derive-from-`HasSideEffectsInterface`, behind `administer flowdrop confirmation policy`; consent
consumed atomically, `gate_expiry` fails closed, resolved secrets redacted from the persisted prompt.

## API routes (all gated; CSRF on every state-changing op)
`/api/flowdrop/*` (workflows CRUD/import/export/run, nodes, categories, triggers, chat, playground sessions/
messages, interrupts, pipelines/jobs/logs, session turn) — each carries a `_permission` (OR-superset with
`administer flowdrop`) and, for POST/PUT/PATCH/DELETE, `_csrf_request_header_token: TRUE`; several add
`_custom_access` for per-entity ownership (pipeline-jobs, playground drive-vs-view, pipeline signal cancel/
pause/resume). The outbound call-and-wait callback `flowdrop_interrupt.api.callback` authenticates via
`_auth: [basic_auth]` with the `resolve flowdrop interrupts via callback` permission and an interrupt UUID.
**New in 2.6:** every returned refusal carries a stable machine-readable **`error_code`**; the base module owns
the shared vocabulary in `src/Controller/Api/ApiErrorCode.php` (`NOT_FOUND`, `ACCESS_DENIED`,
`INVALID_REQUEST_BODY`, `INVALID_QUERY_PARAMETER`, `VALIDATION_FAILED`, `INVALID_INPUTS`, `RATE_LIMITED`,
`INTERNAL_ERROR`), door-specific codes live on each submodule's `*ErrorCode.php`, and the signal API's prose
`error` wording is explicitly no longer contract. `FlowDropApiExceptionSubscriber` keeps those routes'
403/404 machine-readable JSON.

## Submodules
`flowdrop_runtime` (engine + secret settings + snapshot REST API), `flowdrop_workflow` + `flowdrop_workflow_executor`
(entity + `/run` executor), `flowdrop_session`, `flowdrop_memory`, `flowdrop_stategraph` (checkpoints/approval gates),
`flowdrop_pipeline`, `flowdrop_orchestration` + `flowdrop_orchestration_connector`, `flowdrop_trigger`,
`flowdrop_job`, `flowdrop_interrupt` (human-in-the-loop / gate / pipeline signals), `flowdrop_chat`,
`flowdrop_playground`, `flowdrop_node_type` / `_category` / `_processor`, `flowdrop_ui_components` (SDC/Svelte editor).

## Diff 2.5.x → 2.6.x
Same 18-submodule architecture, same core `^11.3` / PHP `>=8.3`, same dependency
(`flowdrop_ui_components`), same library set and suggests. Same architecture for trusted-publisher Ed25519
import, outbound-URL trait, secret registry/scrubber, and confirmation gate (all still present, posture
unchanged). **2.6.0 is the first stable 2.x release.** Observable changes: every API door now returns a
stable **`error_code`** (base-module `ApiErrorCode` shared vocabulary + per-door `*ErrorCode.php`); the
shipped settings now carry a **declarative `retention:` block** (off by default, nothing deleted, dry-run
via `drush flowdrop:retention:report`); runtime tables gained missing indexes; **jobs now record a
`pipeline_id`** (run `drush updb` — `flowdrop_pipeline` update 10007 + backfill post-update) so StateGraph
loop-round restore pages a keyset cursor instead of replaying whole job history; the editor exposes WebMCP
tools driven through the approval gate; an unrecognised `edgeType` is refused at save; the memory value
ceiling is configurable. New `@api` interface `FlowDropPipelineJobLookupInterface`
(`getJobsNewestFirst(limit, before_id)`).

## Caveat
`flowdrop_ui_components` ships SDC components. On an earlier review install those together with the **Canvas**
module triggered an assertion fatal in Canvas's component discovery; FlowDrop was fine once Canvas was removed.
Test that combination in non-production first.
