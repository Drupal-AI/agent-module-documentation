# Node Type Defaults — manual setup guide

**Node Type Defaults** (`node_type_defaults`) lets a site builder customize the
**default values applied to newly created nodes** of a content type. When an editor
opens the "create content" form, the fields and settings this module controls start
pre‑filled with the values you configured — speeding up authoring and keeping
conventions consistent across a team.

Specifically, it lets you set per‑content‑type defaults for:

- **Preview mode** — whether previewing is optional, required, or disabled for the type.
- **Available menus** — which menus a new node of this type can be placed in.
- **Display of author and date** — whether the "submitted by" author and date
  information shows by default.

It affects only the node **create** form's starting values; editors can still change
them per node. The module has no content or access‑control role, and depends on core's
**Menu Link Content** and **Node** modules.

There is no separate settings page — you set these defaults on each content type's own
edit form, alongside Drupal's built‑in publishing and display options. Enable the
module, open a content type, and adjust the defaults.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — defaults are set per content type on its
edit form, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types** (`/admin/structure/types`) and edit the content
   type whose creation defaults you want to change.
3. Adjust the preview mode, available menus, and author/date display options the module
   exposes on that form.
4. Save. New nodes of that type will start with the defaults you chose; editors can
   still override them per node.
