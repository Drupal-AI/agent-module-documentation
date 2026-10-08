# Easy Responsive Tabs to Accordion — manual setup guide

**Easy Responsive Tabs to Accordion** (`field_group_easy_responsive_tabs`) adds a
Field Group display format that renders a group of fields as **tabs on wide
screens and as an accordion on narrow ones**. Tabs and accordions solve the same
problem — too much content for one screen — but at different widths: tabs need
horizontal room for their labels and fall apart on a phone, while an accordion
works at any width but wastes vertical space on a desktop. This module switches
between the two at a breakpoint, which is usually what a responsive design
actually wants.

It builds on the contrib
**[Field Group](https://www.drupal.org/project/field_group)** module, which
already organizes fields into tabs, fieldsets, and details in both form and view
displays. This module adds one more rendering option to that existing structure,
so the grouping is configured once and can apply to the rendered page and, if you
choose, to the node edit form as well. The behavior is driven by the
"Easy Responsive Tabs to Accordion" jQuery plugin, which you install separately
(see Installation).

A word on accessibility: because the semantics change with the layout — a tab set
needs `role="tablist"`/`role="tab"`/`role="tabpanel"` and arrow‑key navigation,
while an accordion needs a button per header with `aria-expanded` — it is worth
testing the result with a screen reader at **both** widths, not just one, to be
sure the component behaves correctly as it switches modes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the required jQuery library, and enable it alongside Field Group.

There is **no site‑wide configuration page** for this module. You choose the
tabs/accordion format on a field group, described below.

## Where it lives in the admin menu

This module adds no admin page of its own. You use it from the Field Group UI on
an entity's **Manage display** (or **Manage form display**) tab — for a node,
**Structure → Content types → *(type)* → Manage display**
(`/admin/structure/types/manage/{type}/display`).

## How to use it

1. Go to the **Manage display** (or **Manage form display**) tab for your entity.
2. Add a new field group and choose the responsive tabs/accordion format that this
   module provides.
3. Move the fields you want into that group. Each child group becomes a tab (or an
   accordion section on narrow screens).
4. Save. On wide screens the group renders as tabs; as the viewport narrows it
   collapses to an accordion.
