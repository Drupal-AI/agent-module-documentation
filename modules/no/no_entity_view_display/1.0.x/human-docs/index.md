# No Entity View Display — manual setup guide

**No Entity View Display** (`no_entity_view_display`) turns off entity view
displays and view modes for entity types that simply don't need them. On a
**headless / decoupled** site — where the front end is rendered outside Drupal —
or on any project that renders its own markup without using Drupal's field
formatters, the *Manage display* screens and their view modes are dead weight.
This module removes them so site builders aren't distracted by rendering
configuration they will never use.

When you enable it and choose which entity types to cover, the module **deletes
the existing view displays and view modes** for those types, stops new ones from
being created, and removes any menu links that point to view-display or
view-mode pages. That makes the change **destructive** — plan for it, and take a
configuration backup first if you might want those displays back.

One thing to be clear about: this affects **rendering configuration only, not
access**. Disabling a view display does not hide sensitive data or restrict who
can read an entity — for that you still need real access control. The module has
no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

After enabling the module, its settings form is at
`admin/config/system/no-entity-view-display`
(**Administration → Configuration → System**).

## How to use it

1. Go to `admin/config/system/no-entity-view-display`.
2. Select the **entity types** for which view displays should be disabled.
3. Submit the form. **This is destructive:** existing view displays and view
   modes for the selected types are deleted, no new ones will be created, and
   related menu links are removed. Back up your configuration first if you may
   need those displays again.

Because the effect is permanent for the selected types, use this only on
projects (typically headless or custom-rendered) where you are certain the
Drupal-side displays are not needed.
