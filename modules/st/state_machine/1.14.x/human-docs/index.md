# State Machine — manual setup guide

**State Machine** (`state_machine`) provides *code‑driven workflows*: sets of
**states** and **transitions** that an entity moves through during its lifecycle.
The current state is stored in a special `state` field, and you never write to
that field directly — instead you apply a named transition and save, which lets
the module validate the change, run any guards, and fire events. It's the
workflow engine that underpins Drupal Commerce (order, payment, fulfillment, and
shipment states) and it's widely reused for custom domain workflows.

The key difference from Drupal core's **Content Moderation** is *where the
workflow is defined*. Content Moderation is configured through the admin UI;
State Machine defines its workflows in **YAML plugin files shipped by a module**.
That makes it the right choice for developers who want reliable,
version‑controlled state logic that deploys as code rather than as
click‑configured settings. A workflow declares its states and its transitions
(each transition has a label, one or more allowed "from" states, and a single
"to" state), and every workflow belongs to a **workflow group** that ties it to
an entity type.

Because it's a developer tool, **State Machine has no admin UI, no settings
page, and no permissions of its own** — enabling it simply makes the workflow
engine, the `state` field type, and its APIs available. You then build workflows
in code. Guards (tagged services) can veto individual transitions based on
permissions, sibling entities, or any custom logic, and each save dispatches
`pre_transition` and `post_transition` events so other code can react (send a
notification, modify the entity, log the change). Its only dependency is core's
**Options** module.

This guide is written for a **human** installing the module and getting oriented.
The real substance — defining workflows in YAML, applying transitions, writing
guards, reacting to events — is developer work, and an AI coding agent should
read the sibling [`agent/`](../agent/start.md) docs, which cover all of it in
depth.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — State Machine adds no menu items and no settings form. It is a
framework other code builds on. Once enabled, the things it provides show up in
*code* (a `state` field type you add to an entity, workflow YAML plugins you
define) rather than on any admin page. Where a state field is used, its allowed
transitions can be rendered as inline action buttons via the provided field
formatter, and its value can be filtered on in Views.

## How to use it

State Machine is used by developers, not clicked through. In outline:

1. A module defines one or more **workflow groups** and **workflows** in YAML
   plugin files (states and transitions).
2. A `state` field, configured to use one of those workflows, is added to an
   entity type.
3. Application code reads the allowed transitions and calls
   `applyTransitionById()` then saves — the module validates that the transition
   is allowed and fires its events.
4. Optionally, **guards** restrict specific transitions, and **event
   subscribers** react to `pre_transition` / `post_transition` events.

Common uses include Commerce order/payment/shipment lifecycles, editorial
approval flows on custom entities, subscription active/paused/canceled states,
and support‑ticket lifecycles. See the [`agent/`](../agent/start.md) docs for the
YAML format, the field API, guards, events, and the alter hooks.
