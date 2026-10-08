# Entity Reference View Selection with ID Args — manual setup guide

**Entity Reference View Selection with ID Args**
(`entity_reference_view_selection_with_id_args`) provides a **Views‑based
entity-reference selection handler** that passes the **host entity's ID (and
related IDs) as Views contextual arguments**. In plain terms: it lets you filter
the list of selectable entities on a reference field by the context of the entity
you are currently editing.

Core already lets you back a reference field with a View to control which entities
appear in the autocomplete or select list. What this module adds is the ability to
feed that View the **current entity's ID** as a contextual filter argument — so the
options can depend on the host entity itself. For example, you could limit the
choices to entities related to the node being edited, rather than showing every
possible target. It depends on core's **Field** and **Views** modules and runs on
Drupal 9.4 through 11.

Because the selectable options come from a View, the **selection view's own access
checks and filters apply** — the module has no access‑control role of its own.
Still, keep in mind that a selection view controls which **labels/entities an
editor sees as options**; design the view so it does not surface entities whose
existence or titles should stay hidden from the people who use that field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You choose it as the field's reference method (selection handler) in the
field settings, described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference View Selection with ID Args adds no admin settings page. You use
it from **Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
fields → *(the reference field)* → field settings**.

## How to use it

1. First build (or reuse) a **View** of the entity reference display type, with a
   **contextual filter** that accepts an entity ID. This is where the host entity's
   ID will be applied.
2. Go to your entity-reference field's settings (**Structure → Content types →
   *(bundle)* → Manage fields → *(the field)***).
3. Set the field's **Reference method** to the selection handler provided by this
   module (the Views selection that passes ID arguments), and pick the View and
   display you created.
4. Save the field settings.

When editors use the field, the option list is now filtered by the current
entity's ID through the View's contextual argument.
