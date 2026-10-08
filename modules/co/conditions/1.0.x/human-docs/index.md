# Conditions — manual setup guide

**Conditions** (`conditions`) is a **developer toolkit** for working with Drupal's
condition plugins — the same plugin type that powers block visibility (request
path, language, user role, and many more from core and contrib). It provides
reusable **form elements**, a **field type**, and **services** so that you can
expose condition configuration to editors on any form or field, and evaluate
those conditions at runtime to decide what to show, where, and to whom.

What it offers:

- A **`conditions` form element** — renders a configurable list of condition
  plugins with AND/OR logic.
- A **`conditions_groups` form element** — renders multiple groups of conditions,
  each with its own logic and a published/unpublished toggle.
- A **ConditionsService** — initialises condition plugins (including context
  mapping) and resolves nested condition groups at runtime.

The base module has **no admin UI of its own** — it is meant to be integrated by
other modules and site builders. It depends on the **Plugin form element**
module. Two submodules extend it: **Conditions Field** (`conditions_field`) adds
a *Conditions* field type you can attach to any entity via the Field UI (stored
one row per condition so entities can be queried efficiently by their assigned
conditions), and **Conditions Test** (`conditions_test`) is a test helper you
would not enable in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Plugin form element dependency, and enable the module (and optionally the
   Conditions Field submodule).

There is **no configuration page** for this module. It is a library other code
builds on; the one site-builder-facing feature is the *Conditions* field added by
the `conditions_field` submodule, described below.

## How to use it

- **Developers** integrate the `conditions` / `conditions_groups` form elements
  into their own forms, and call `ConditionsService` to evaluate the stored
  conditions at runtime. See the [`agent/`](../agent/start.md) docs for the
  service and element APIs.
- **Site builders** who just want a per-entity conditions field should enable the
  **Conditions Field** submodule (`conditions_field`), then add a **Conditions**
  field to any entity type through **Structure → *(entity type)* → Manage
  fields**. Editors can then configure conditions directly on the entity edit
  form via its AJAX-enabled widget.
