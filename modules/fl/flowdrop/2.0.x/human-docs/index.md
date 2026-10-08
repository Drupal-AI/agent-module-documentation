# FlowDrop — manual setup guide (2.0.x)

**FlowDrop** (`flowdrop`) is a visual **workflow orchestration** system for Drupal.
You build automations as *graphs* of typed nodes — AI models, data transforms, HTTP
calls, entity queries and saves, triggers, branches — on a drag-and-drop canvas,
and a runtime executes them inside Drupal. If you have used n8n, Zapier, or
Node-RED, the shape is familiar; the point of having it *inside* Drupal is data
gravity: a workflow that reads entities, calls a model, writes the result back and
notifies someone never has to leave the site or replicate your content model
elsewhere.

FlowDrop is really a **subsystem**, not a single module: this release ships **18
submodules** — a runtime and executor, session and memory handling for
conversational flows, an orchestration layer with connectors, triggers, a pipeline
abstraction, a state graph, a job system, an interrupt mechanism for
human-in-the-loop steps, a chat surface, and a playground for trying nodes out.
Workflows are standard Drupal **config entities**, so they export to YAML, version
in git, and deploy across environments with `drush cex`/`cim`.

The design highlight worth calling out is the **trusted-publisher** model.
Workflows can be exported as bundles and imported — which is exactly the shape of a
supply-chain risk, since an imported workflow can call models, make HTTP requests,
and touch content. FlowDrop's answer is `FlowDropTrustedPublisher` entities holding
publisher keys, with **signature verification before import** and an explicit trust
decision gated behind its own restricted permission. That is a careful architecture
and rare in contrib.

Because FlowDrop can drive **AI models and external HTTP calls**, treat it as a
module with real egress and cost implications: model and API calls cost money and
leave your site, so store credentials as secrets and review what each workflow
reaches out to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Drupal 11.3+
   only), enable the submodules you need.
2. [Configuration](configuration/index.md) — the settings form, permissions,
   secrets handling, and the trusted-publisher import model.

## Where it lives in the admin menu

FlowDrop does not declare a `configure` route in its info file, but its settings
form lives at **`/admin/flowdrop/config/flowdrop`** (logging verbosity, watchdog,
default orchestrator, icon picker). Permissions are assigned under **People →
Permissions**, and the visual editor and workflow management live under the
FlowDrop admin area.

## A caveat before you install

FlowDrop ships **SDC components** via `flowdrop_ui_components`. On a review install,
those components together with the **Canvas** module triggered an assertion fatal in
Canvas's component discovery. FlowDrop itself was fine once Canvas was removed — so
if you run Canvas, test this combination carefully in a non-production environment
first.
