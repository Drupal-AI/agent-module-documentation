# EntityReference Separate Selection and Validation — manual setup guide

**EntityReference Separate Selection and Validation** (`ersv`) is an entity
reference *selection plugin* that splits apart the two jobs a normal selection
handler bundles together: deciding **what a user is allowed to pick** and deciding
**what counts as a valid saved value**.

In stock Drupal a reference field uses one selection handler for both — the list of
options offered in the widget and the validation of whatever was submitted follow
the same rule. That is limiting when the set you want to *show* legitimately
differs from the set you want to *accept*. Classic examples: offer only *future*
events for selection but validate against *all* events, or let editors add and
reference non‑reusable media via Inline Entity Form while keeping validation
broad. Without this module, the narrower selection rule would reject or strip those
values on save.

ERSV lets you configure a **selection** handler and a separate **validation**
handler on the same reference field. It implements Drupal's autocreate interface
(so "create new" still works) and integrates with the **AJAX Dependency** module —
a required dependency — so the offered options can react to the value of another
field on the form, giving you cascading / dependent dropdowns.

This is purely a field‑configuration tool. It adds no routes, permissions or
services and stores no data of its own; everything happens at form‑build and
validation time based on how you configure the field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its AJAX Dependency requirement.

There is **no configuration page** for this module — it has no settings form. You
set it up per field, described in "How to use it" below.

## How to use it

1. Add or edit an **entity reference** field on any bundle (**Structure → Content
   types → *(type)* → Manage fields**, or the equivalent for other entities).
2. On the field's **settings** page, set the **Reference method** to the option
   provided by ERSV.
3. Configure the two nested handlers it exposes:
   - the **selection** handler — what the editor can choose (for example a
     filtered, view‑backed, or AJAX‑dependent subset);
   - the **validation** handler — what values are ultimately accepted (typically
     broader — the default handler, or a different rule).
4. Save the field settings. From then on the widget offers the narrower selection
   set while save validates against the broader validation set.

> **Tip:** To make the selectable options depend on another field's value on the
> same form, combine ERSV's selection handler with the **AJAX Dependency** module
> it requires.
