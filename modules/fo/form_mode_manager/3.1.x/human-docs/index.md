# Form Mode Manager — manual setup guide

**Form Mode Manager** (`form_mode_manager`) makes Drupal's **form modes** actually
usable. Drupal core lets you define alternative *form modes* for an entity's
add/edit forms (for example a stripped-down "quick add" form, or a fuller form for
power users) and enable them per bundle — but core gives you no way to actually
*reach* those forms. Form Mode Manager fills that gap: it automatically generates
the routes, tabs, local action buttons, operations links, and access permissions so
editors can create and edit content through a chosen form mode, all without writing
any custom code.

Once you create a form mode and enable it on a content type, Form Mode Manager
exposes it at a URL like `node/add/{type}/{form_mode}`, adds an edit tab for it, and
mints a **per-mode permission** so you can restrict who uses each form. That makes
it easy to build role-specific editing experiences: give "contributors" a simple
form with fewer fields, hide the default form from them entirely, and let power
users keep the full one.

The module ships two small settings forms — one to **exclude** particular form modes
from the system, and one to control **where the generated tabs appear**. It also
defines an extensible plugin type (`entity_routing_map`) with built-in support for
nodes, users, taxonomy terms, and block content, plus a generic fallback that covers
most other content entity types. Three optional submodules extend it further:
switching the theme per form mode, auto-assigning roles on registration form modes,
and a demo/examples content type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick any submodules you need.
2. [Configuration](configuration/index.md) — the full workflow of creating and
   activating a form mode, the two settings forms, and the per-mode permissions.

## Where it lives in the admin menu

Several places work together:

- **Structure → Display modes → Form modes**
  (`/admin/structure/display-modes/form`) — where you create a form mode.
- A content type's / entity's **Manage form display**
  (e.g. `/admin/structure/types/manage/article/form-display`) — where you *enable*
  (activate) a form mode on a specific bundle.
- **Configuration → Content authoring → Form Mode Manager**
  (`/admin/config/content/form_mode_manager`) — the settings form that excludes
  form modes, plus a "links task" sub-page at `.../links-task` for tab positioning.
- **People → Permissions** (`/admin/people/permissions`) — the generated
  *use … form mode* permissions per role.

## How to use it

The short version: create a form mode, enable it on a bundle, then use the URL or
tab it generates. Full step-by-step instructions are in
[Configuration](configuration/index.md).
