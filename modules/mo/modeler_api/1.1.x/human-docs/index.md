# Modeler API — manual setup guide

**Modeler API** (`modeler_api`) is a framework that lets graphical modelers (visual
editors like BPMN.iO) edit the configuration entities owned by *other* modules —
ECA automation workflows, AI Agents configurations, and so on. It cleanly
decouples *what is modeled* from *how it is modeled*, so any visual editor can work
with any module's config without either side having to know about the other.

This is a developer-oriented framework rather than an end-user feature, and it is
important to understand that **it does nothing on its own**. It needs at least one
**Model Owner** (a module whose config entities you want to model — for example ECA
via its `eca_ui` module, or AI Agents) *and* at least one **Modeler** (a visual
editor — for example BPMN.iO via the `bpmn_io` module, or Workflow Modeler). Once
you have one of each, Modeler API mediates between them, auto-generating the admin
listing, routes, local tasks, and per-owner permissions from plugin metadata, and
handling the whole save cycle through a set of generic component types. Models can
be imported and exported as `.tar.gz` archives or as complete Drupal recipes.

It defines five plugin types (two PHP-attribute types — Modeler and Model Owner —
and three YAML-only types: Context, Dependency, and Template Token), provides Drush
commands, and requires **Drupal 11.3+ / 12** and **PHP 8.3+**. It has no other
module dependencies (the Token module is an optional suggestion for enhanced
template-token support) and no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to implement a
Modeler or Model Owner plugin and how to call the `Api` service — read the sibling
[`agent/`](../agent/start.md) docs, particularly the
[plugin types reference](../agent/plugins/modeler_api.md).

## Contents

1. [Installation](installation/index.md) — install the module with Composer, and
   the model owner(s) and modeler(s) it needs to actually do anything.
2. [Configuration](configuration/index.md) — the settings form (picking a theme and
   storage method per owner/modeler), the permissions, and the Drush commands.

## Where it lives in the admin menu

The settings form sits at **Configuration → Workflow → Modeler API**
(`/admin/config/workflow/modeler_api`). The model management screens themselves
(listing, add, edit, import, export, and so on) are generated dynamically for each
model owner you install, and appear under that owner's own section of the admin.

## How to use it

Install Modeler API together with at least one model owner and one modeler — for
example ECA plus BPMN.iO. Then visit the Modeler API settings form to choose, for
each owner/modeler combination, which editor theme to use and how the raw diagram
data should be stored. From there you manage models through the auto-generated
screens for that owner. See [Configuration](configuration/index.md) for the
details.
