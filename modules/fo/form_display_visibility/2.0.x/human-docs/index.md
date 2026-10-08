# Entity Form Display Visibility — manual setup guide

**Entity Form Display Visibility** (`form_display_visibility`) lets you attach
**access/visibility conditions to individual field widgets** on an entity's form
display, so a field only appears on the add/edit form for users who satisfy the
condition. You configure it right where you already manage fields — on the
**Manage form display** page — without writing any custom `hook_form_alter`
code.

Two conditions ship out of the box: **Access by Role** (restrict which roles may
edit a field) and **Access by Permission** (require a specific permission to edit
a field). Conditions are plugins, so a developer can add project‑specific ones.
When more than one condition is enabled on a field, they combine with AND — every
enabled condition must allow access.

Crucially, enforcement uses Drupal's form `#access`, not CSS. A field a user is
not allowed to edit is genuinely **removed from the form**, so its value cannot
be submitted by an unauthorised user — this is real field‑edit access control,
not visual hiding. Configuration lives on the standard Field UI pages, so it is
governed by Field UI's own admin permissions, and there are no anonymous or
mutating endpoints of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires Field UI).
2. [Configuration](configuration/index.md) — adding role/permission conditions to
   a field on Manage form display, step by step.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it entirely from
**Structure → Content types (or any entity's bundle) → Manage form display**, in
each field's widget settings (the cogwheel), where a **Visibility Conditions**
section appears.
