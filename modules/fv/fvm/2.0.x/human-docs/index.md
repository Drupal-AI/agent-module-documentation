# Field View Mode — manual setup guide

**Field View Mode** (`fvm`) lets editors choose, per individual entity, which
view mode that entity is rendered in. Want one particular article shown in a
"Featured" layout while every other article uses the default? With Field View
Mode the editor just picks the view mode from a select list on the edit form — no
Layout Builder, no code.

It works by adding a small, locked entity-reference field named
`view_mode_selection` to the bundles you choose. You enable Field View Mode per
bundle from a single central settings form; ticking a bundle creates the field
(and adds it to the edit form) automatically, and unticking it removes the field —
so you never have to set anything up by hand in Field UI. At render time the
module reads the editor's choice and switches the entity's view mode accordingly.

You can also **limit** which view modes appear in the dropdown per bundle (offer
only "Teaser" and "Featured", say), relabel or hide the empty "Default" option,
and — when Layout Builder is involved with custom blocks — decide whether Field
View Mode's field or Layout Builder's own view-mode field wins, so the two don't
fight over the same setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: enabling bundles,
   limiting view modes, the select widget, and the Layout Builder option.

## Where it lives in the admin menu

- **Settings** — **Structure → Display modes → View modes → Field View Mode**
  (`/admin/structure/display-modes/view/fvm`), reached via an action link on the
  view-modes page. Gated by the core **Administer display modes** permission
  (the module adds no permission of its own).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the bundles you care about actually have **more than one view mode**
   — Field View Mode only lists bundles that do, since there's nothing to choose
   between otherwise. Create extra view modes at **Structure → Display modes → View
   modes** and enable them for the bundle on its *Manage display* screen.
3. Open the [settings form](configuration/index.md) and tick the bundles where
   editors should be able to pick a view mode. This creates the **View Mode** field
   on each of those bundles' edit forms.
4. Edit an entity of that bundle, choose a view mode from the **View Mode** select,
   and save. That entity now renders in the chosen view mode.

> **Important:** to *stop* using Field View Mode on a bundle that already has data,
> hide the field via the bundle's *Manage form display* rather than unticking the
> bundle in the settings form — unticking deletes the field (and its data) when the
> bundle has no rows, and the maintainers warn this can cause data loss on
> populated bundles.
