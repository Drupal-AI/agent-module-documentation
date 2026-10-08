# Grouped by field widget — manual setup guide

**Grouped by field widget** (`group_by_field_widget`) is an entity‑reference field
widget that organises selectable options into **collapsible groups** instead of
one flat list. Despite the "group" in its name, it has nothing to do with the
Group module — it is about grouping *form options*, such as taxonomy terms drawn
from several vocabularies or a deep hierarchy.

Drupal's standard entity‑reference widgets show choices as a single
undifferentiated column of checkboxes. When a field points at more than one
vocabulary, or at a hierarchical one, that list becomes hard to scan — "Health",
"Cardiology", "Finance", "Payroll" with nothing showing which options belong
together. This widget groups the options under their parent (a vocabulary, a
parent term, or a related entity referenced further up a chain), rendering each
group as a collapsible details section. Multi‑value fields use checkboxes;
single‑value fields use radio buttons, and a selected radio can be cleared by
clicking it again.

Because it is only a **widget substitution**, the field type and the values you
store are untouched. Switching to it — or switching back — costs nothing, and
existing validation, storage, and display behaviour keep working exactly as
before. It supports multiple grouping levels and can follow entity‑reference
relationships, so grouping is not limited to fields attached directly to the
selectable entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module (`configure` is null) — it has
no settings form. You set it up on a field's form display, described under "How to
use it" below.

## Where it lives in the admin menu

The widget adds no admin page of its own. You select it at **Structure → Content
types → *(type)* → Manage form display** (or the equivalent Manage form display
for any fieldable entity), on the entity‑reference field you want to group.

## How to use it

1. Add (or locate) an **entity‑reference field** on your content type — for
   example a field referencing taxonomy terms across several vocabularies.
2. Go to that content type's **Manage form display**.
3. Change the field's widget to **Group by field reference widget**.
4. In the widget's settings, choose the field(s) to **group by**. You can follow
   references up a chain to group by a parent entity's field, and nest multiple
   grouping levels.
5. Save. Multi‑value fields now render as grouped checkboxes; single‑value fields
   render as grouped radio buttons.

> **Troubleshooting — an empty "Group by" selector.** Only fields with a
> cardinality of 1 can be used as a grouping field. Also, fields that use the
> *"Views: Filter by an entity reference view"* reference type must have their
> bundles selected first before they become available to group by.
