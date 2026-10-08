# Bootstrap Multiselect — manual setup guide

**Bootstrap Multiselect** (`bootstrap_multiselect`) replaces the native
`<select multiple>` control with a friendlier **dropdown of checkboxes**, using
the Bootstrap Multiselect JavaScript library. Where the browser's built-in
multiple-select forces people to ctrl-click or shift-click (and silently throws
away their earlier picks if they just click normally), a checkbox dropdown is
self-explanatory — you tick the boxes you want.

The native multiple-select is one of the worst-understood controls on the web:
awkward on desktop, nearly unusable on touch screens, and it shows only a few
rows no matter how many options exist. This module swaps it for a control that
most people already understand. On a Bootstrap-themed site it fits in naturally,
because it uses the framework's own dropdown component and needs no extra styling.

Two things are worth checking when you use it, because a replaced native control
can be an improvement *or* a regression. The underlying element should stay a real
`<select multiple>` with the widget layered on top as presentation — that is what
keeps keyboard use, form submission, and assistive technology working. And the
closed control should announce how many options are selected (for example
"3 selected"), so a screen-reader user knows the same thing a sighted user can
see at a glance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. The multiselect widget is chosen per field
under **Manage form display**, or applied to select controls such as exposed
filters, depending on how you use it.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. On a field that stores multiple values, go to the entity's **Manage form
   display** and select the Bootstrap Multiselect widget so the field renders as a
   checkbox dropdown.
3. Use a Bootstrap-themed front end so the dropdown matches the rest of the site.
4. Test the control with a keyboard and, ideally, a screen reader — confirm the
   selection count is announced and that submitting the form saves the right
   values.
