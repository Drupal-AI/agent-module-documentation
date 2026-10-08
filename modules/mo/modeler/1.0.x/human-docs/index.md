# Workflow Modeler — manual setup guide

**Workflow Modeler** (`modeler`) is a modern, drag‑and‑drop visual editor for
Drupal workflow models, built on React Flow. It's a plugin for the
[Modeler API](https://www.drupal.org/project/modeler_api) and provides the editing
canvas for any module that registers as a Modeler API "model owner" — most commonly
[ECA](https://www.drupal.org/project/eca), the event‑condition‑action automation
module. In practice, it replaces ECA's classic form‑based editor with a visual
canvas where you drop event, action, condition, and gateway nodes and connect them
into a flow.

Each node and edge is configured through a dynamic property panel generated from
that component's normal Drupal configuration form, including schema‑aware assistance
for YAML fields. Beyond authoring, the editor can replay a past workflow execution
step by step, run a live test with results highlighted on the canvas, search and
filter nodes, add documentation annotations, undo/redo, and switch between
fullscreen and a floating window with a light/dark theme. Finished models can be
exported as a Drupal **Recipe**, a config **Archive**, portable **JSON**, or an
**SVG** snapshot, and a separate standalone viewer can embed a read‑only diagram on
any web page.

There is nothing to configure on this module itself: it has **no settings page and
no permissions of its own**. It activates automatically once Modeler API and at
least one model‑owner module (such as ECA) are installed, and the six editing
capabilities (edit metadata, switch context, edit templates, create templates,
test, replay) are defined and access‑checked by Modeler API on the model owner's
permission set — you grant them there.

This is a modern‑stack module: it needs **Drupal 11.3+ (or 12)**, **PHP 8.3+**,
and **Modeler API 1.1+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Modeler API and
   a model owner such as ECA) and enable it.

## Where it lives in the admin menu

Workflow Modeler adds no admin page of its own. You reach it through the model
owner's admin UI — for ECA, that's **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`) — where adding or editing a model opens the React
canvas in place of the classic form. Permissions are granted on the model owner's
permission set at **People → Permissions**.

## How to use it

1. Install and enable Modeler API, this module, and a model owner (for example ECA
   and its UI submodule) — see [Installation](installation/index.md).
2. Grant the relevant Modeler API capabilities (edit metadata, create/edit
   templates, test, replay, and so on) to the appropriate roles on the model
   owner's permission set.
3. Open the model owner's admin UI (for ECA, **Configuration → Workflow → ECA**)
   and **Add** or edit a model. The visual canvas opens inline.
4. Build the flow by dragging components from the palette onto the canvas and
   connecting them; click a node or edge to configure it in the property panel.
5. Use the toolbar to test, replay, search, annotate, or export the model
   (Recipe / Archive / JSON / SVG).

If more than one modeler plugin is installed, Modeler API lets you choose which one
to use; when Workflow Modeler is the only one, it is used automatically and models
open inline (via HTMX) without a full page reload. View preferences like window
position and dark mode are saved in your browser, not on the server, so there is
nothing to set per site.
