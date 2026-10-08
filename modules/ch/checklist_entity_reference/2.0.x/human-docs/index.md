# Checklist Entity Reference — manual setup guide

**Checklist Entity Reference** (`checklist_entity_reference`) turns an ordinary
entity-reference field into a **checklist**. Instead of an autocomplete or select
box, the referenced items (taxonomy terms, nodes, or any referenceable entity)
render as a list of checkboxes, and ticking a box marks that item as "done." It's
a natural fit for onboarding steps, compliance items, task lists, or any workflow
where you want to track progress against a defined set of items.

On top of the checklist itself the module adds progress reporting. A **Checklist
Progress** pseudo-field can be dragged onto the entity's form display to show a
progress bar summarising how many items are checked — and if an entity has more
than one checklist field, that widget shows cumulative progress across all of
them. Matching progress-bar **formatters** let you display the same progress when
the entity is viewed. The module also offers options to record **when** an item
was checked and **who** checked it, and to **prevent unchecking** items once
they're ticked, so a completed step can't be silently reverted.

It borrows its checklist look and feel from the well-regarded Checklist API
module, but works with real Drupal entities rather than its own bespoke data
structure. It has no third-party dependencies and needs no site-wide settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Everything is set up per field
through the Field UI, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage fields / Manage form display
/ Manage display**.

## How to use it

1. On a bundle, add an **entity reference** field (or edit an existing one) that
   points at the items you want in your checklist — for example a taxonomy
   vocabulary of steps.
2. On **Manage form display**, set that field's widget to the checklist
   (checkboxes) widget so referenced items render as tickable boxes. In the
   widget settings you can enable options such as recording the check date/user
   and disallowing unchecking.
3. To show a progress bar on the editing form, drag the **Checklist Progress**
   pseudo-field into the enabled area of **Manage form display**.
4. On **Manage display**, choose a progress-bar formatter for the field (or the
   Checklist Progress element) to show completion when the entity is viewed.
