# FlowDrop — manual setup guide (2.5.x)

**FlowDrop** (`flowdrop`) is a visual **workflow orchestration** system for Drupal.
You build automations as *graphs* of typed nodes — AI models, data transforms, HTTP
calls, entity queries and saves, triggers, branches — on a drag-and-drop canvas,
and a runtime executes them inside Drupal. The comparison points are n8n, Zapier,
and Node-RED; the reason to run it *inside* Drupal is data gravity: a workflow that
reads entities, calls a model, writes the result back and notifies someone never
has to leave the site or replicate your content model elsewhere.

The 2.5 README frames the whole thing as a lifecycle — **create, manage, run,
track**: build a flow on the canvas, keep it as an exportable config entity, run it
synchronously, asynchronously or as a checkpointed state graph, and read back a
pipeline record with one job per node.

FlowDrop is a **subsystem**, not a single module: it ships **18 submodules** — a
runtime and executor, session/memory/state-graph handling for conversational and
long-running flows, an orchestration layer with connectors, triggers, a pipeline
abstraction, a job system, a human-in-the-loop interrupt mechanism, a chat surface,
and a playground. The base module defines the `flowdrop_node_processor` and
`expression_evaluator` **plugin types**, and the suite ships a large node-processor
library (the README markets **25+ built-in nodes**) across AI, data, HTTP, and
control-flow, plus **Drush commands** for workflow bundles, pipeline traces, and
trigger tests. Workflows are Drupal **config entities**, so they export to YAML and
deploy with `drush cex`/`cim`.

This release keeps the same security model as 2.2, which is worth understanding
before you use it:

- **A trusted-publisher import model.** Workflows export as *bundles* and import,
  which is a supply-chain decision — an imported workflow can call models, make
  HTTP requests and touch content. Bundles carry a detached **Ed25519** signature;
  FlowDrop verifies it against a **trusted-publisher key stored on your site**
  (never a key from the bundle itself) before import, and the import is gated
  behind a restricted permission. 2.5 adds an admin UI for managing those
  publishers.
- **A governed human-in-the-loop confirmation gate.** A node type can require
  operator approval before a *side-effecting* node runs — covering both
  graph-scheduled nodes and nodes an AI agent invokes as tools mid-turn. The gate
  is hardened: consent is consumed atomically (one approval cannot authorise two
  runs), gate questions expire and **fail closed**, and resolved `${{ secrets.* }}`
  values are redacted from the persisted prompt. It is owned by a dedicated
  **administer flowdrop confirmation policy** permission.
- **An SSRF guard on outbound HTTP nodes.** Caller-supplied URLs are validated
  (http/https only), DNS is resolved with the request pinned to the resolved IP to
  close the DNS-rebinding window, redirects are re-validated per hop, and internal
  targets are refused unless explicitly allowed. TLS verification stays on
  (Guzzle's default) — there is no `verify => false` anywhere.
- **A `${{ secrets.NAME }}` reference syntax** (with the Key module) so credentials
  resolve at runtime, never land in workflow config or job records, and are
  scrubbed back out of anything a node echoes into storage.

Because FlowDrop drives **AI models and external HTTP calls**, treat it as a module
with real egress and cost implications: calls cost money and leave your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Drupal 11.3+,
   PHP 8.3+), enable the submodules you need.
2. [Configuration](configuration/index.md) — the settings form, permissions
   (including the confirmation-policy permission), secrets, the confirmation gate,
   and the trusted-publisher import model.

## Where it lives in the admin menu

FlowDrop does not declare a `configure` route in its info file, but its settings
form lives at **`/admin/flowdrop/config/flowdrop`** (logging verbosity, watchdog,
default orchestrator, icon picker). Which Key-module keys workflows may resolve is
set separately at **`/admin/flowdrop/config/secrets`** (the `flowdrop_runtime`
submodule). Permissions are assigned under **People → Permissions**, and the visual
editor and workflow management live under the FlowDrop admin area.

## A caveat before you install

FlowDrop ships **SDC components** via `flowdrop_ui_components`. On an earlier review
install, those components together with the **Canvas** module triggered an
assertion fatal in Canvas's component discovery. FlowDrop itself was fine once
Canvas was removed — so if you run Canvas, test this combination carefully in a
non-production environment first.
