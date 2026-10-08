# Revert Default Permission (RDP) — manual setup guide

**Revert Default Permission** (`revert_default_perm`) controls who can see the
**"Revert to defaults"** button in Layout Builder. In Drupal's Layout Builder, a
content entity that has an overridden (customized) layout normally shows a button
that resets it back to the default layout for its type. That reset is destructive
to the custom work: one click discards the tailored layout. This module lets you
hide that button so users cannot revert a customized layout back to its default
state, helping preserve layouts you have deliberately built.

It works by adding a permission that gates the button's visibility, so you decide —
by role — which users still see and can use "Revert to defaults" and which do not.
This is a UI-access refinement for Layout Builder; it does not change any other
access on the entity. It depends on core's **Layout Builder** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. You control its behavior
through the permission it adds and on the content entity's Layout Builder settings,
described in "How to use it" below.

## How to use it

1. After enabling the module, go to **People → Permissions**
   (`/admin/people/permissions`) and review the permission the module adds for the
   "Revert to defaults" button. Grant it only to the roles that should be allowed
   to reset customized layouts; withhold it from roles whose custom layouts you
   want to protect.
2. Configure the option on the content entities where you want to hide the button,
   so that users editing those entities in Layout Builder no longer see (or can no
   longer use) "Revert to defaults" and their custom layouts are preserved.

The net effect: users without the permission keep their customized Layout Builder
layouts, because the one-click path back to the default is no longer available to
them.
