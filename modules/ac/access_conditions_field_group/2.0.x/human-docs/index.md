# Access Conditions Field Group — manual setup guide

**Access Conditions Field Group** (`access_conditions_field_group`) lets you show
or hide a [Field Group](https://www.drupal.org/project/field_group) — a tab,
fieldset, accordion item or any other group of fields — based on the reusable
**access models** you define in the
[Access Conditions](https://www.drupal.org/project/access_conditions) module.

It adds a **Visible to certain access models** setting to every field group's
format settings on the *Manage display* and *Manage form display* screens. When
you pick one or more access models there, the group renders only if at least one
of those models grants access to the current visitor. Leave it blank and the
group shows to everyone, exactly as before.

The evaluation happens as the field group renders, and the module merges the
access checker's cache contexts, tags and max-age into the element, so it stays
safe to use with Drupal's dynamic page cache. This means you can conditionally
reveal grouped fields on an entity display without writing any per-field access
code.

One important caveat, worth repeating: this is a **display** feature. Hiding a
group removes it from the rendered page, but the underlying field data still
exists on the entity and can still be reached through other channels (JSON:API,
REST, search, Views). For genuinely sensitive data, use real field or entity
access control — not just this visibility setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

This module has no settings page of its own. You configure it inline, on each
entity's display: **Structure → Content types → (a type) → Manage display**
(or **Manage form display**), then edit an individual field group's settings.

## How to use it

1. First create your access models in **Access Conditions** — the setting
   references them by name, so they must exist first.
2. Go to the **Manage display** (or **Manage form display**) tab of the entity
   bundle that has the field group.
3. Click the gear/settings icon on the field group you want to control.
4. Under **Visible to certain access models**, choose one or more models. If
   *any* selected model grants access, the group is shown; if none do, it is
   hidden. (Choosing several models gives you OR logic.)
5. Save the display.

The setting is stored with the display configuration, so it exports and deploys
like any other display setting. Test each display as different roles to confirm
the group appears and disappears as you expect, and remember the security caveat
above for sensitive fields.
