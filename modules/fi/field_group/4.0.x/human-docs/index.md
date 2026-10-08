# Field Group — manual setup guide

**Field Group** (`field_group`) lets you organize an entity's fields into visual
groups — tabs, accordions, fieldsets, collapsible "details" sections, or plain
HTML wrappers — on both the edit form and the rendered display, without writing
any code. Out of the box Drupal shows fields as one long flat vertical list;
Field Group adds a layer on top of core's Field UI so you can wrap related fields
in a group and tidy up an otherwise sprawling form or page.

You do the work right where the fields already live: on an entity's **Manage form
display** and **Manage display** tabs. There you add a group, choose a *format
type* (Tabs, Tab, Fieldset, Details, Details sidebar, HTML element), and drag
fields — and even other groups — into it, so groups can nest as deeply as you
like. Each format has its own small settings form for things like the label,
wrapper element, CSS classes, and whether a "Details" starts open or closed.

Because the groups are stored as configuration on the display itself, they export
and deploy between environments like any other config. Field Group has **no
global settings page** — there is nothing to configure site-wide, and it does
nothing on its own until you create a group on a specific display. It depends
only on core's **Field** module, which is already enabled on any standard site.
One optional (and now deprecated) submodule, **Field Group Accordion**
(`field_group_accordion`), adds a jQuery-UI accordion format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and decide whether you need the accordion submodule.
2. [Configuration](configuration/index.md) — how to create and configure field
   groups on a form or display, format type by format type.

## Where it lives in the admin menu

Field Group has no page of its own under **Configuration**. Instead it surfaces
on every fieldable entity's display tabs — for a content type, for example, at
**Structure → Content types → (your type) → Manage form display** and **Manage
display**. Once the module is enabled, an **Add group** action link appears at
the top of those tables. See [Configuration](configuration/index.md) for the full
walkthrough.
