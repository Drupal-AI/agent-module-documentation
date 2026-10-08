# Entity Reference Display Formatter — manual setup guide

**Entity Reference Display Formatter** (`entity_ref_display_formatter`) is a
**field formatter** for entity reference fields (`entity_reference` and
`entity_reference_revisions`, the field type used by Paragraphs). Instead of
rendering each referenced item as a plain list, it lays the referenced items out
as **horizontal tabs, vertical tabs, an accordion, or anchor links**.

For each referenced item you choose which of its fields act as the **title** (the
clickable tab/section label) and which act as the **body** (the panel content),
and you drag both sets into the order you want. You then pick one of the four
display styles. It all happens in the field's display settings, with no theming
code.

For example, a multi-value Paragraphs field of "sections" could be shown as a set
of tabs, with a heading field as each tab label and the section's body field as
the panel — or the same content could be rendered as an accordion or as an
anchored jump-link list, just by switching the style.

The module has **no settings form or admin page of its own** — it is a pure
field-formatter add-on. You configure it on a field's *Manage display*. It works
on Drupal 10 and 11. Core alone covers the horizontal-tab and anchor styles; the
**Vertical Tab** style additionally needs the *jQuery UI Tabs* module and the
**Accordion** style needs the *jQuery UI Accordion* module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set it up on your entity reference field's *Manage display*, described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from an entity's **Manage
display**, for example **Structure → Content types → *(type)* → Manage display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** of the entity/bundle that has your entity
   reference field — for a content type, **Structure → Content types → *(type)* →
   Manage display**.
3. In the **Format** column for your entity reference field, choose
   **"Entity reference Display formatter"**.
4. Click the gear/settings icon, then:
   - **Select the title field(s)** — the field(s) of the referenced entity used as
     each tab/section label.
   - **Select the content field(s)** — the field(s) used as the panel body.
   - Open the **weight** tables to drag the selected fields into the order you
     want.
   - Choose a **Display Style**: Horizontal Tab, Vertical Tab, Accordion, or
     Anchors.
5. Save. The field now renders its referenced items in the layout you selected.

> Only fields that were **added** to the referenced entity (configurable fields)
> can be picked as title/content; base fields such as the node title are not
> offered. If your reference field targets several bundles, the field list is
> taken from the last target bundle.
