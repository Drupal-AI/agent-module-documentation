# Webform Workflows Element — manual setup guide

**Webform Workflows Element** (`webform_workflows_element`) connects Webform
submissions to Drupal core's **Workflows** module, so each submission can move
through workflow states — for example *draft → needs review → approved* — with
proper access control, logging, and notification emails at every step. It's the
building block for approval queues, editorial review, and multi-stage intake
processes (applications, support tickets, RFPs) built on a single webform.

It adds a new **workflow type** to core Workflows (you define its states and
transitions with the standard Workflows UI) and a new **Webform element** you drop
onto a form and bind to that workflow. On the submission form, the element shows the
current state and offers the transitions the current user is allowed to perform. It
stores the current and previous state, the chosen transition, and public/admin log
messages in the submission data.

Access is genuinely fine-grained: on the element's *Access* tab you decide, **per
transition** and **per state**, which roles, users, or permissions may act — and a
disabled toggle forbids rather than silently allowing. There's a confirm route for
running a single transition, a "Workflows summary" page listing submissions by
state, a bulk **Action** to transition many submissions at once, and a **Workflow
transition email** handler that emails people when a transition fires (with tokens
for transition links, including secure-token links that let logged-out users act).
Two submodules add a **Views** state filter and **Maestro** engine integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (requires Webform
   and core Workflows), enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — create the workflow, add and bind the
   element, set per-transition/per-state access, configure transition emails, and
   find the summary pages.

## Where it lives in the admin menu

- **Configuration → Workflow → Workflows** (`/admin/config/workflow/workflows`) —
  create a *Webform workflow* and define its states/transitions.
- The **element** and its **Access** tab live on each webform's element editor
  (*Structure → Webforms → [your form] → Build*).
- **Structure → Webforms → Configuration → Workflows**
  (`/admin/structure/webform/config/workflows`) — site-wide default transition-email
  bodies and state colour options (requires *Administer webform*).

## How to use it

Create a Webform workflow with your states and transitions, add a **Webform
workflow** element to a form and point it at that workflow, then set the
per-transition and per-state access on the element's *Access* tab. Optionally add
the transition-email handler so people are notified on each state change. See
[Configuration](configuration/index.md) for the full walkthrough.
