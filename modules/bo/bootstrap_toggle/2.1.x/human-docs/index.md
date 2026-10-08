# Bootstrap Toggle — manual setup guide

**Bootstrap Toggle** (`bootstrap_toggle`) renders boolean (on/off) checkbox
fields as sliding **toggle switches**, using the Bootstrap Toggle library. The
switch has become the expected control for an on/off setting — mobile operating
systems made it so — and a plain checkbox can read as a form field rather than a
switch. This module gives you the switch look for fields where the control *is*
the setting: a published flag, a feature on or off, a notification preference.

The one thing worth deciding before you reach for it is **when the change takes
effect**. A switch implies immediacy — people expect it to *do the thing now*,
because that is how switches behave everywhere else. A checkbox in a form implies
"this will be saved when I submit." If a value only applies after saving, dressing
it as a switch can make people think the setting did not stick.

Two accessibility points separate a working toggle from a decorative one. The
underlying input should stay a real checkbox — focusable, operable with the
spacebar — with the switch as presentation. And the state must be conveyed by
more than colour and position: a green-versus-grey switch with no label means
nothing to a colour-blind user or a screen reader, so on/off text or a state-aware
accessible name is required, not optional.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. You choose the toggle widget per boolean field
under **Structure → Content types → (your type) → Manage form display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. On a boolean field, open the entity's **Manage form display** and select the
   Bootstrap Toggle widget so the checkbox renders as a switch.
3. Use a Bootstrap-based theme so the switch styling matches the site.
4. Prefer switches for settings that feel immediate; keep plain checkboxes for
   values that only apply when the form is submitted. Confirm the switch is
   keyboard-operable and labelled with its state.
