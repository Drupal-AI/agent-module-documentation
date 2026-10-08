# Rendered Entity List formatter — manual setup guide

**Rendered Entity List formatter** (`rendered_entity_list_formatter`) provides a
new, more **accessible** field formatter for entity-reference fields. It behaves
just like core's "Rendered entity" formatter — you still choose the view mode
each referenced entity is rendered in — but it wraps the output in proper
semantic list markup so screen readers announce it as a list.

Concretely: when the field holds **multiple** references, the rendered entities
are wrapped in an unordered list (`<ul>` with `<li>` items); when it holds a
**single** reference, it is wrapped appropriately for one item. This small change
helps meet accessibility requirements for item listings and improves
screen-reader navigation, without you having to override templates.

Once the module is enabled, the formatter appears automatically as a display
option for any entity-reference field, on any entity type's *Manage display*
screen. There is nothing to configure globally — you pick the formatter per
field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
apply it per field on *Manage display*, described below.

## How to use it

Rendered Entity List formatter adds no admin menu item. You use it from the
**Field UI → Manage display** of whichever entity type has the reference field:

1. Go to **Structure → Content types (or any entity type) → *(bundle)* → Manage
   display**.
2. Find your **entity-reference** field in the list.
3. In the **Format** column, choose **Rendered entity list** (the formatter this
   module adds).
4. Click the gear/settings icon to pick the **view mode** the referenced entities
   should render in — exactly as you would for the core "Rendered entity"
   formatter.
5. Click **Update**, then **Save**.

Multi-value fields will now render their referenced entities inside a semantic
`<ul>` list.
