# Link with description - Attributes — manual setup guide

**Link with description - Attributes** (`link_description_attributes`) is a small
bridge module that combines two existing modules: it brings the **Link Attributes**
widget to fields provided by **Link with description**. In other words, a link
field that already carries a description can now *also* set link attributes such as
`rel`, `target`, and `class` through the Link Attributes UI — you get both features
on the same field.

It is deliberately minimal: as the maintainers put it, the module has **no menu and
no modifiable settings — there is nothing to configure**. You simply enable it and
switch the relevant fields to the widget it provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside its two dependencies) and enable it.

This module has **no configuration page** — there are no settings. All you do is
select its widget, described in "How to use it" below.

## How to use it

1. Make sure your entity has a **Link with description** field.
2. Go to that bundle's **Manage form display**.
3. Set the field's widget to **Link description (with attributes)**.
4. Save. Editors can now set link attributes (rel, target, class, …) on the
   described link, using the Link Attributes UI.
