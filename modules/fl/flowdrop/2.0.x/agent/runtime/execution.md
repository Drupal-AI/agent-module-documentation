<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Execution, pipelines, interrupts, secrets

## Execution modes

Set the default in `flowdrop.settings` (`execution.default_orchestrator`); a workflow/trigger can
override per run.

1. **Synchronous** (`flowdrop_runtime:synchronous`) — runs in-request. Simple, immediate.
2. **Asynchronous** (`flowdrop_runtime:asynchronous`) — pushed onto a Drupal queue and processed
   in the background (queue workers / cron / `queue_ui`).
3. **StateGraph** (`flowdrop_stategraph`) — checkpointed, resumable execution with reducers and
   approval gates, for chat, loops, and long-running flows. Saves `state_checkpoint` entities so a
   run can pause (e.g. on an interrupt) and resume later.

## Runtime, pipelines and jobs

`flowdrop_runtime` drives execution and provides queue processing plus real-time monitoring and
workflow **snapshots** (`flowdrop_workflow_snapshot`, with a snapshot REST API and cleanup form).
Every run produces:

- one **`flowdrop_pipeline`** (content entity) — overall status, `input_data`, and the grouping of
  its jobs; the audit unit. Rerun / generate-jobs / clear-jobs admin actions exist.
- one **`flowdrop_job`** (content entity) per node — status, input, output, timing, errors.

Admin execution surface (`flowdrop_runtime`, all gated `administer flowdrop runtime` OR
`administer flowdrop`): `/admin/flowdrop/execute`, `.../workflow`, `.../pipeline`, `.../interact`.

## Launching a run programmatically / via API

- `flowdrop_workflow_executor` provides `POST /api/flowdrop/workflow/{flowdrop_workflow}/run`
  (schema-resolved initial inputs → 202 + new pipeline id), gated by the `execute flowdrop_workflow`
  capability (distinct from view/administer) plus a CSRF header token. It also enables **nested
  workflows** (calling a workflow from within another, sync or async).
- `flowdrop_session` provides `POST /api/flowdrop/session/{flowdrop_session}/turn` — a chat turn,
  gated on `execute session workflow` **and** `flowdrop_session.update` entity access (a turn runs
  under the owner's identity and memory scope, so an observer with only view cannot drive it).

## Human-in-the-loop (`flowdrop_interrupt`)

A workflow can pause and request input: confirmation, choice, free text, or a JSON-schema form.
Pending requests are `flowdrop_interrupt` entities, surfaced in an inbox
(`/admin/flowdrop/interrupts`) and resolvable per item. Rich permission model: `view/resolve/cancel
own|any flowdrop interrupts`, `administer flowdrop interrupts` (**restrict**). Pipeline-level
signals (cancel/pause/resume) are authorised by owner-of-pipeline OR a matching `*any flowdrop
workflow` permission, enforced at the routing layer via `_custom_access`.

**Machine callback:** `POST /api/flowdrop/interrupts/{interrupt_id}/callback` answers an outbound
call-and-wait. It is deliberately CSRF-exempt but `_auth: [basic_auth]` only (no browser session
reaches it), gated on the dedicated `resolve flowdrop interrupts via callback` permission
(**restrict**, service accounts only) plus the unguessable interrupt UUID. This is a
well-constructed authenticated callback, not an open webhook.

## Secrets

With the **Key** module, node config may reference `${{ secrets.NAME }}`; values resolve at runtime
into a request-scoped `flowdrop.resolved_secret_registry` (plaintext, never persisted). Which keys
a workflow may resolve is controlled at `/admin/flowdrop/config/secrets`, gated on the runtime
admin permission — **not** on workflow authoring, because allowing a key is what lets an author
*spend* a credential they cannot read. `flowdrop.secret_scrubber` then removes those exact secret
strings from anything a node echoes into persisted job data.

## Bundles / marketplace (base module)

Workflows export as portable **bundles** with deterministic canonicalization and **Ed25519**
signing (`flowdrop.bundle_signer` / `bundle_verifier`). Import (`POST
/api/flowdrop/workflows/import`, permission `import flowdrop_workflow`, **restrict**) verifies the
signature against trusted `flowdrop_trusted_publisher` keys before applying. Importing an unsigned
or untrusted bundle requires the separate `import untrusted flowdrop_workflow` (**restrict**)
permission. This is the module's supply-chain answer and is unusually rigorous for contrib.

## Drush (from submodules)

`flowdrop_pipeline` (pipeline trace), `flowdrop_workflow` (workflow bundle export/sign/import),
`flowdrop_trigger` (trigger test) each ship Drush commands under `src/Drush/Commands`. The base
`flowdrop` module ships none.
