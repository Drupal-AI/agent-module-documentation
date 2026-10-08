# Entity Reference validators — manual setup guide

**Entity Reference validators** (`entity_reference_validators`) adds two opt-in
safety checks to any entity reference field, guarding against the two most common
reference mistakes:

- **Circular references** — stops an entity from referencing itself. For example, a
  "Related articles" field on a node should not let an article point at itself, and
  a category's "Parent" field should not create a loop. An optional *deep* mode
  walks the whole reference tree, so an indirect loop (A → B → A) is caught too.
- **Duplicate references** — stops the same target from being listed more than once
  in a multi-value field, so a "Team members" or "Tags" field can't repeat the same
  entry.

There is no admin page and nothing site-wide to switch on. Instead, the module adds
a small **"Reference validators"** section to each entity reference field's edit
form, with checkboxes to enable the checks on that specific field. When you tick a
box, the module attaches a standard Drupal validation constraint to the field, so
the rule is enforced by core's normal validation — both on the entity edit form
(with an inline error) and whenever code runs the entity's validation. The settings
are saved as third-party settings on the field, so they travel with your exported
configuration.

One useful nuance: the circular-reference checkboxes only appear when the field
points at the **same entity type it lives on** (a node field targeting nodes, a
term field targeting terms), because a self-reference check only makes sense there.
Duplicate prevention is available on any entity reference field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Turning the validators on for a field is covered in the *How to use it* section
below.

## Where it lives in the admin menu

There is no dedicated settings page. You enable the checks per field, on the
field's own edit form under **Structure → Content types → (your type) → Manage
fields → (an entity reference field) → Edit**.

## How to use it

1. Go to the reference field's edit form: *Structure → Content types → (bundle) →
   Manage fields*, then **Edit** an *Entity reference* field.
2. Find the **Reference validators** section and tick the checks you want:
   - **Prevent circular references** — blocks the entity from referencing itself.
   - **Recursively check circular references** — the deep check that also catches
     indirect loops. It only applies when the box above is ticked.
   - **Prevent entity from referencing duplicates** — blocks the same target from
     appearing twice.
3. **Save** the field. From now on, saving content through the edit form (or any
   code that validates the entity) enforces the rule, showing an inline error such
   as "This entity cannot be referenced" or "The value … has been entered multiple
   times."

> **Note on the circular checkboxes.** They only appear when the field's target
> type matches the entity type it lives on (e.g. a *node* field targeting *nodes*).
> That is by design — a self-reference check is only meaningful there. Duplicate
> prevention is always available.

One caveat worth knowing: a plain programmatic `$entity->save()` does not
automatically run validation, so bulk imports that skip validation are not blocked.
Call `$entity->validate()` in such code to enforce the constraints. See the
[`agent/`](../agent/start.md) docs for the constraint details.
