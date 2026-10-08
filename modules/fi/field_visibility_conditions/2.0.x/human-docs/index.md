# Field Visibility Conditions — manual setup guide

**Field Visibility Conditions** (`field_visibility_conditions`) lets you attach
Drupal **Condition plugins** — request path, interface language, user role, current
theme, and so on — to individual fields, so a field is shown or hidden on an entity
**form** depending on whether its conditions evaluate to true. It's a clean way to
simplify long authoring forms by only showing the fields that are relevant in the
current context.

For example, you can hide a field on the node edit form unless the request path
matches a pattern, show a field only for a particular interface language, reveal
"extra details" only for certain roles, or vary which fields appear based on the
active theme. Multiple conditions can be combined on a single field (all must
pass). The rules also apply to fields embedded through Inline Entity Form.

The module builds on the **Conditions Helper** module for the condition sub‑form
and evaluation, and it stores each field's rules as that field's *third‑party
settings*, so the visibility rules travel with your field configuration and can be
exported and deployed like any other config.

> **Important:** this is an authoring‑form convenience, **not** an access‑control
> or security boundary. It controls whether a field's widget *appears on a form*,
> not read access to already‑stored data, and a field with no conditions is shown
> normally. If a condition can't be evaluated, the field is shown (it fails open).
> Don't use it to protect sensitive data — use real permissions for that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Conditions Helper dependency).

## Where it lives in the admin menu

There are two places it appears:

- A **global settings page** at **Configuration → Content authoring → Field
  Visibility Conditions** (`/admin/config/content/field-visibility-conditions`),
  where you choose which condition types editors are allowed to use. Reaching it
  needs the restricted **Administer field visibility conditions** permission.
- A **"Field Visibility"** section that this module adds to every individual
  field's edit form under *Manage fields*, where you set the actual conditions for
  that field.

## How to use it

1. **Pick the available conditions (once, site‑wide).** Visit
   `/admin/config/content/field-visibility-conditions` and enable the condition
   plugins you want to make available (for example request path, language, role,
   theme). By default none are enabled, so this is the first step. This list is
   stored in the `field_visibility_conditions.settings` config object and is
   exportable.
2. **Set conditions on a field.** Go to the field you want to control — for
   example **Structure → Content types → Article → Manage fields**, then edit a
   field. On the field's edit form you'll find a **Field Visibility** section built
   from the conditions you enabled in step 1. Configure one or more conditions and
   save. The rules are stored on the field's third‑party settings, so they move
   with the field's configuration.
3. **See it in action.** When an editor opens an entity form, the module evaluates
   each field's stored conditions and removes the field from the form when they
   don't pass. Fields with no conditions are left untouched.

Developers can add or remove the conditions offered via the
`hook_field_visibility_conditions_available_conditions_alter()` hook — see the
[`agent/`](../agent/start.md) docs for details.
