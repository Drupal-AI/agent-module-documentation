# Simple Multistep — manual setup guide

**Simple Multistep** (`simple_multistep`) turns an ordinary entity form into a
**multi-step wizard** — the long form is split into a sequence of steps with
**Next** and **Back** navigation, so editors and visitors work through fewer
fields at a time. It's a great fit for long content-creation forms, guided
registration or profile flows, multi-section surveys, and staff data-entry
screens where presenting everything at once feels overwhelming.

It builds directly on the **Field Group** module. You don't write any code or
create a special form: on the entity's *Manage form display* you add one or more
**"Form step"** groups (a Field Group format this module provides) and drag fields
into each. Every "Form step" group becomes one step. From there the module takes
over — it hides all but the current step, injects the Next/Back buttons, and
remembers the values you've entered as you move between steps.

Each step can have its own title, description, and help text, its own Next/Back
button labels, and a rule about whether required fields must be filled before
advancing. Navigation is handled server-side, so entered values are preserved
across steps. It even works inside **Inline Entity Form** sub-forms. There's no
global settings page and no permissions — everything is configured per form
display. It requires the Field Group module.

This guide is written for a **human** configuring form displays through the admin
UI. If you want terse, token-cheap references for an AI coding agent (the
formatter plugin internals and the controller-swap hook), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Field Group)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — add "Form step" groups on Manage form
   display and set each step's title, help text, buttons, and required-fields
   behavior.

## Where it lives in the admin menu

There's no dedicated settings page. You build the wizard on an entity's **Manage
form display** tab — for example **Structure → Content types → *(your type)* →
Manage form display** — using the **Add group** control and the **Form step**
group format.

## How to use it

In short: on *Manage form display*, click **Add group**, choose **Form step** as
the format, name it, and drag the fields for that step into it. Repeat for each
step. Any form display that contains at least one "Form step" group is
automatically turned into a multi-step form with Next/Back buttons. See
[Configuration](configuration/index.md) for the per-step options.
