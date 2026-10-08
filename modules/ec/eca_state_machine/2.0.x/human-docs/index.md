# ECA State Machine — manual setup guide

**ECA State Machine** (`eca_state_machine`) connects
[ECA](https://www.drupal.org/project/eca) — the visual, model‑driven
Event‑Condition‑Action automation framework, and the modern successor to Rules —
to the [State Machine](https://www.drupal.org/project/state_machine) module,
which models a workflow as a set of states and the legal transitions between
them. State Machine is what Drupal Commerce uses for order and payment state.

The two are useful separately, but the combination is where the value lies. State
Machine is precise about *what may follow what* and deliberately says nothing
about side effects; ECA is great at side effects but has no notion of legal
transitions. Bridged together, a sentence like *"when an order moves to
fulfilment, if the customer is in the EU, send this notification and set that
field"* becomes something a business analyst can express — and neither module can
express it alone.

Concretely, this module exposes State Machine's moving parts to ECA: **events**
for pre‑transition and post‑transition, **conditions** to test an entity's
current state or whether the triggering event is a particular transition, and an
**action** to trigger a transition on an entity. Like other ECA integrations, it
has no settings form of its own — the plugins appear in the ECA model editor.

Two cautions apply to all automation‑by‑configuration. First, the logic lives in
**configuration, not code**, so it never shows up in a code review unless you
export the models and review them the way you would review code. Second, a model
that fires on a transition and then causes another transition can **loop** — test
for that. State Machine also needs at least one configured workflow to do
anything; if you don't have one yet, enable the bundled **ECA State Machine
Example** submodule to get a working workflow to experiment with (it is meant for
testing, not production).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside ECA and State Machine, and optionally add the example
   submodule.

There is **no configuration page** for this module. It adds plugins you use
inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA State Machine adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**), where its
transition events, state/transition conditions and the transition action become
available when you build or edit a model. State Machine workflows themselves are
defined in configuration (and, for the example, by the bundled submodule).

## How to use it

1. Make sure ECA (2.x or 3.x) and State Machine are installed, and that you have
   at least one State Machine workflow configured. If you don't, enable **ECA
   State Machine Example** for a ready‑made test workflow.
2. Open the ECA model editor and create or edit a model.
3. Use a **pre‑** or **post‑transition** event to react when an entity changes
   state, add **conditions** to check the current state or the specific
   transition, and use the **trigger a transition** action to move an entity
   through the workflow.
4. Save and enable the model. Export it with your configuration and review it as
   code — and check deliberately that no transition triggers another in a loop.
