# Advanced Form — manual setup guide

**Advanced Form** (`advancedform`) lets you **conditionally hide admin UI features
on forms**. Complex admin and edit forms in Drupal can accumulate a lot of fields,
options, and sections; this module lets you hide some of those elements based on
conditions you configure, so editors see a simpler, less cluttered form.

It is an administration convenience for tidying up the editing experience. It
provides its own permission and is configured from its settings form.

**Important — this is not access control.** Hiding a UI element does **not**
protect it. Anything this module hides is still present in the underlying form and
route: a user who can reach the form can still submit the hidden fields (for
example by crafting the raw request), and the data and permissions behind them are
unchanged. So never rely on Advanced Form to stop someone from reaching a setting
or field — use real **permissions** and **field access** for that. Use this module
only to make forms tidier.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form where you choose
   which form features to hide and under what conditions, and the crucial
   "not access control" caveat.

## Where it lives in the admin menu

Advanced Form is configured from its settings form
(`advancedform.settings_form`). It also adds a permission you grant under
**People → Permissions** (`/admin/people/permissions`) to control who may manage
which form features are hidden.
