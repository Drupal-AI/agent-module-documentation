# ECA Classic Modeler — manual setup guide

**ECA Classic Modeler** (`eca_cm`) is a built-in, dependency-free way to build
[ECA](https://www.drupal.org/project/eca) automation models using nothing but
Drupal core's own form UI. ECA (Events–Conditions–Actions) is the engine that runs
automations — "when X happens, if Y is true, do Z" — but it needs a *modeller* to
author those models. Most ECA setups use a graphical, JavaScript-based modeller
(BPMN.js). ECA Classic Modeler provides a simpler alternative called **Core**: it
lets you create and edit ECA models entirely through plain Drupal forms in the
admin, with no diagramming tool involved.

Because it's built on plain forms, the Classic Modeler works where the graphical
modellers can't — on servers or setups where you can't run the JavaScript modeller —
and it is screen-reader friendly. It's a good fit for a minimal site that only has
Drupal core plus ECA installed, or when you specifically want an accessible,
core-only authoring experience.

The module adds **no configuration or settings of its own** — no settings form, no
new permissions, no Drush commands. It reuses ECA's engine and ECA's *administer
eca* permission, and the models you build are stored as ECA's own configuration
entities, so they export and deploy like any other config. It integrates nicely with
the **Select2** module (nicer plugin pickers) and the **Token** module (a token
browser) when those are installed.

> The maintainer positions the Classic Modeler as an accessible fallback and
> recommends the richer graphical modellers listed on the ECA project page where you
> can use them.

This guide is written for a **human** building automations in the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install ECA and the Classic Modeler with
   Composer, then enable them.

## Where it lives in the admin menu

Everything happens under ECA's admin at **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`). The Classic Modeler adds an **Add new Classic
model** action there, and per-component add/edit/delete forms under the same path.
All of it requires the **administer eca** permission (defined by ECA, not by this
module).

## How to use it — build a model

1. Go to **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`) and click
   **Add new Classic model** (this opens the create form at
   `/admin/config/workflow/eca/add/core`). Give the model a name and save — you now
   have an empty model.
2. **Add an event** — the trigger that starts the automation, e.g. "an entity is
   saved".
3. **Add an action** — what should happen (e.g. send an email, set a field). You can
   also **add a condition** to gate whether an action runs.
4. **Connect the components.** Open the event and, at the bottom of its form, add
   your action (and/or condition) as a **successor**. This successor wiring is what
   defines the order things run in — add each further action as a successor of the
   component before it to build a chain.
5. **Save.** Nothing takes effect until you save.

You can **enable or disable** a finished model from the ECA model list, edit or
delete individual events, conditions, and actions at any time, and export the model
as configuration for deployment to other environments.

### Optional integrations

- **Select2** (`drupal/select2`) — upgrades the event/condition/action plugin
  selectors to nicer, searchable dropdowns.
- **Token** (`drupal/token`) — adds a token browser when configuring components.

Install either alongside the Classic Modeler to improve the authoring experience;
neither is required.
