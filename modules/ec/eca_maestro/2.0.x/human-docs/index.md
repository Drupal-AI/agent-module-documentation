# ECA Maestro — manual setup guide

**ECA Maestro** (`eca_maestro`) is a bridge between two automation tools:
[ECA](https://www.drupal.org/project/eca) — Drupal's no‑code
Event‑Condition‑Action engine — and
[Maestro](https://www.drupal.org/project/maestro), a structured
business‑process (BPM) workflow engine. On its own, ECA is great at "when this
happens, if that holds, do this", while Maestro is great at multi‑step,
long‑running business processes with tasks, queues and assignments. This module
lets the two work together, so ECA models can drive or react to Maestro workflow
tasks and transitions and you can combine free‑form automation with a formal
business process.

Like most ECA integration modules, ECA Maestro does not add a settings page of
its own. It contributes ECA plugins (actions and conditions) that become
available inside the ECA model editor once the module is enabled. You build the
actual behavior by drawing an ECA model, not by filling in a configuration form.

It depends on the ECA base module and on **ECA Endpoint** (`eca_endpoint`), both
of which Drupal will pull in as dependencies, and it supports Drupal 9.5, 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Maestro.

There is **no configuration page** for this module. It adds plugins you use
inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Maestro adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**), where its
Maestro‑related actions and conditions appear when you build or edit a model.
Maestro's own workflow templates are managed separately under Maestro's admin
pages.

## How to use it

1. Make sure both ECA and Maestro are installed and that you have at least one
   Maestro workflow template to interact with.
2. Open the ECA model editor and create or edit a model.
3. Add the Maestro‑related actions and conditions this module provides to your
   model — for example, to react when a Maestro task changes or to advance a
   Maestro process as part of a wider automation.
4. Save and enable the model. The behavior lives in the exported ECA
   configuration, so review and version it the way you would review code.
