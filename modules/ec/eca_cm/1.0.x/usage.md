<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Classic Modeler (eca_cm) is a built-in, dependency-free user interface for building ECA (Events-Conditions-Actions) models using only Drupal core's Form API. It registers a "core" ECA modeller so you can create and edit ECA models entirely within the Drupal admin, without BPMN.js or any external modeling tool.

---

ECA itself is the engine (it stores automation models as `eca.eca.*` config entities and executes them), but it needs a *modeller* to author those models; eca_cm provides one called **Core** (`@EcaModeller(id = "core")`, class `Plugin/ECA/Modeller/Core`). It adds a set of Drupal-core form routes under `/admin/config/workflow/eca/` to create a model (`/add/core`) and to add, edit and delete its events, conditions and actions, plus a route subscriber and menu/local-action derivers that wire those forms into ECA's admin. You build a model by first adding an event, then actions (and optional conditions), and finally connecting components as *successors* to define the execution chain — everything persisted into the model's `eca.eca.<id>` config entity (in ECA 3.x the modeller is tracked at runtime, not stored as a `modeller` key in that config). It integrates with Select2 (nicer plugin pickers) and the Token module (token browser) when those are installed. eca_cm defines **no config of its own, no permissions** (it reuses ECA's `administer eca` permission), no config schema, and no Drush; it is purely an authoring UI layered on ECA. The maintainer explicitly positions it as an accessibility-friendly fallback modeller and recommends the richer modellers on the ECA project page where possible.

---

- Build an ECA automation model entirely in the Drupal admin without installing a BPMN modeler.
- Create a new "classic" ECA model at `/admin/config/workflow/eca/add/core`.
- Add an event (e.g. entity insert/update) to a model through a core Drupal form.
- Add actions to run when an event fires, and wire them as successors of the event.
- Add conditions to gate whether an action runs.
- Edit or delete individual events, conditions and actions of an existing model.
- Author ECA models on a server where you cannot run the JavaScript-based modelers.
- Provide a screen-reader-accessible way to configure ECA logic.
- Use ECA on a minimal site that only has Drupal core plus ECA core installed.
- Connect multiple actions in sequence by adding each as a successor to build an execution chain.
- Enable or disable a built ECA model from the model list.
- Improve plugin selection ergonomics by installing Select2 alongside eca_cm.
- Browse available tokens while configuring actions by installing the Token module.
- Prototype an automation workflow quickly using only core form UIs.
- Manage the events/conditions/actions of a model as it grows via dedicated add/edit/delete routes.
- Keep ECA models as exportable `eca.eca.*` configuration for deployment across environments.
- Author business-rule style automations (send email on publish, set a field on save, etc.).
- Replace a Rules-style UI expectation with ECA's event-driven model (noting they differ).
- Restrict who can author models using ECA's `administer eca` permission.
- Serve as the authoring UI on sites that standardize on core-only tooling.
- Add a condition and an action to the same event to express "if X then do Y".
