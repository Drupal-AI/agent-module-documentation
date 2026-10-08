# Views Fieldsets — manual setup guide

**Views Fieldsets** (`views_fieldsets`) adds a special "Global: Fieldset" field to
Views that lets you wrap other fields in a `<fieldset>`, a collapsible
`<details>` disclosure, or a plain `<div>`. In a field‑based Views display you can
visually group related fields — address parts, contact details, meta information —
and even nest one group inside another to build card‑ or accordion‑style layouts,
all without writing a custom Views style plugin.

You add one or more Fieldset fields to a display, then drag your ordinary fields
*underneath* them on the **Rearrange** screen to make them children; drag one
Fieldset under another to nest. Each Fieldset field has options for the wrapper
type (details / fieldset / div), a legend (heading) that can use row tokens like
`{{ title }}`, comma‑separated CSS classes (also token‑aware), and collapsible /
collapsed toggles. At render time the module moves each fieldset's child fields
inside the chosen wrapper and themes them through Twig templates — and a group is
only output when at least one child actually has content, so you never get empty
boxes.

The module works as soon as you enable it: the "Global: Fieldset" field simply
appears in the Views field picker. There is **no settings form, no permissions,
and no dependencies beyond core Views**. Developers can add new wrapper types with
a hook and override the markup with granular per‑view/display/field template
suggestions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the field options
schema, the wrapper‑types hook, and the theme hooks and template suggestions —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views Fieldsets has no admin page of its own. You use it entirely inside the Views
UI at **Structure → Views** (`/admin/structure/views`), when editing a
field‑based display.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a **field‑based** Views display — an Unformatted list, Grid, or Table (not
   a display that renders whole entities).
3. Under **Fields**, click **Add** and choose **Global: Fieldset** (it may also be
   listed as "Views: Fieldset"). Add more than one if you want several groups.
4. In the field's settings, pick the **wrapper type** (Details, Fieldset, or
   Div), optionally set a **legend** (heading text — tokens like `{{ title }}`
   work), add any **CSS classes**, and choose whether it is **collapsible** and
   starts **collapsed**.
5. Open the **Rearrange** screen (the Fields section dropdown → *Rearrange*). Drag
   your normal fields so they sit *underneath* a Fieldset field — the indentation
   shows they've become its children. Drag one Fieldset beneath another to nest
   groups.
6. Use **Preview** to check the result: each fieldset renders its child fields
   inside the wrapper. Remember an empty group is hidden automatically.

Tips: a `<details>` wrapper with **collapsible/collapsed** on gives you an
accordion‑style teaser; token‑driven classes (e.g. `status-{{ field_status }}`)
let you style rows dynamically; and all of this stays inside the view's own
configuration — there is no separate entity to manage.
