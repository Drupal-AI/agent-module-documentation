# Views Templates — manual setup guide

**Views Templates** (`views_templates`) brings back the "dynamic default views"
pattern: it lets modules ship pre‑built Views as **reusable templates** that a
site builder can clone into real, fully editable View entities. Instead of a
module shipping a View as fixed configuration (which reappears on config sync and
can't be freely changed), the View is offered as a starting point you copy once
and then own.

This is primarily a **developer API**, but it also gives site builders a small,
friendly workflow in the Views admin. A module registers a `ViewsBuilder` plugin
that either builds a View in code or loads a `*.yml` Views export from its own
`views_templates/` folder, optionally running placeholder substitutions so one
template can produce several variants. Once such a plugin exists, site builders
get an **"Add view from template"** action on the Views list page.

Choosing a template opens a short form asking for a name, machine name, and
description, then creates a brand‑new View and drops you straight into the normal
Views edit form — where the result is just an ordinary View you can change however
you like. Because the template is only a scaffold, your cloned View never gets
overwritten when configuration is imported. The module itself ships no settings,
permissions, or Drush commands; its admin UI is gated by core's **Administer
views** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings of its
own. It only becomes useful once another module registers a template. See "How to
use it" below.

## Where it lives in the admin menu

Views Templates has no settings page. Its one addition to the UI is the **"Add
view from template"** local action on **Structure → Views**
(`/admin/structure/views`), which opens a browsable list of available templates at
`/admin/structure/views/template/list`.

## How to use it

1. Install and enable Views Templates alongside a module that actually provides
   one or more templates. On its own, the template list will read "There are no
   available Views Templates."
2. Go to **Structure → Views** and click **Add view from template** (or visit
   `/admin/structure/views/template/list`) to see the templates on offer, each
   with a name and description.
3. Click **Add** next to a template. Fill in a **name**, **machine name**, and
   **description** (plus any extra fields the template defines).
4. Submit. A new View is created and you're taken to its normal edit form, where
   you can adjust it like any other View. The template is not linked to your copy,
   so your changes are safe from config sync.

> **For developers:** to offer your own templates, add a `ViewsBuilder` plugin
> under `Plugin/ViewsTemplateBuilder` — either extend `ViewsBuilderBase` and
> build the View in `createView()`, or extend `ViewsDuplicateBuilderBase` and
> point it at a `*.yml` export in your module's `views_templates/` directory. See
> the [`agent/plugins`](../agent/plugins/views_templates.md) doc for details.
