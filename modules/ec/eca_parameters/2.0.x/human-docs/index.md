# ECA Parameters — manual setup guide

**ECA Parameters** (`eca_parameters`) adds parameter handling to
[ECA](https://www.drupal.org/project/eca), Drupal's no‑code
Event‑Condition‑Action automation engine, by integrating it with the
[Parameters](https://www.drupal.org/project/parameters) module. With it, ECA
models can accept, pass and reuse parameters — turning a one‑off automation into
a reusable, configurable one. It provides ECA events, conditions and actions for
working with parameters, and it also introduces a new collection of parameters
for use within ECA.

Like other ECA integration modules, it has no standalone settings form of its
own — it contributes plugins that appear inside the ECA model editor. An optional
submodule, **ECA Parameters UI** (`eca_parameters_ui`), adds the user interface
for working with parameters; enable it if you want that interface.

One thing worth keeping in mind: ECA automations run with real privileges and can
change content and configuration, so deciding who may build ECA models is a
trusted, admin‑level capability. Adding parameter support makes models more
flexible but does not change that. This module requires ECA 2.x and supports
Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside ECA and Parameters, and add the optional UI submodule.

There is **no configuration page** for this module. It adds plugins you use
inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Parameters adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**), where its
parameter‑related events, conditions and actions become available when you build
or edit a model.

## How to use it

1. Make sure ECA (2.x) and the Parameters module are installed. Enable the
   **ECA Parameters UI** submodule if you want the interface for working with
   parameters.
2. Open the ECA model editor and create or edit a model.
3. Use this module's events, conditions and actions to accept and pass
   parameters, so the same model can be reused with different inputs.
4. Save and enable the model. Because ECA logic lives in configuration rather
   than code, export and review it as part of your normal deployment process.
