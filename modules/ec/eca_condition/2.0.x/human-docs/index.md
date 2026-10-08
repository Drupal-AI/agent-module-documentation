# ECA Condition — manual setup guide

**ECA Condition** (`eca_condition`) lets your ECA models reuse Drupal's own
**Condition plugins** — the same reusable checks core and contrib provide for
things like the current request path, a user's role, or a node's content type.
Instead of ECA only knowing about its own built-in conditions, this module opens
the door to the whole Condition-plugin ecosystem, so an ECA workflow can branch
on "is this the front page?", "does the current user have the *editor* role?", or
"is this an *article*?" without any custom code.

ECA (Event-Condition-Action) is Drupal's no-code automation framework: you build
*models* that listen for an event, evaluate conditions, and then run actions. This
module simply adds more conditions to that palette. It is pure automation
plumbing — it has **no access-control role of its own**; a condition only decides
whether the rest of an ECA model runs, and it inherits whatever behavior the
underlying Condition plugin provides.

The module works the moment you enable it. There is nothing to configure on a
settings page — you use it entirely from inside the ECA modeller when you build or
edit a model. Its only dependency is the ECA base module (`eca`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA.

There is **no configuration page** for this module — it has no settings form. You
use the conditions it adds from within the ECA modeller, described in "How to use
it" below.

## Where it lives in the admin menu

ECA Condition adds no admin page of its own. You work with it inside the ECA
modeller, which lives at **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`). ECA models are built either with the visual
**BPMN.iO** modeller or the form-based **ECA Classic Modeller**, depending on
which modelling tool you have installed.

## How to use it

Once enabled, the extra conditions appear whenever you add a condition to an ECA
model:

1. Open or create an ECA model at **Configuration → Workflow → ECA**.
2. Add a **condition** to a gateway (a branching point) in your model.
3. In the list of available conditions, pick one of the Drupal Condition plugins
   this module exposes — for example a request-path, user-role, or content-type
   check.
4. Configure that condition's settings (the path pattern, the roles, the bundle,
   and so on), then wire the "true"/"false" outcomes to the actions you want.

The condition only gates which branch of the model runs; it never grants or
denies access on its own.
