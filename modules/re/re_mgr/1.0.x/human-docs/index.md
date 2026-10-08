# Real Estate Manager — manual setup guide

**Real Estate Manager** (`re_mgr`) is a framework for managing property
portfolios in Drupal. It defines four **hierarchical custom content entity
types** that mirror how real estate is actually organised:

- **Estate → Building → Floor → Flat**

Each level is bundleable (it has its own *type* configuration entities),
revisionable, and governed by granular per-entity permissions (view, add, edit,
delete, administer). A relationship runs down the pyramid: a Building can
optionally belong to an Estate, a Floor must belong to a Building, and a Flat must
belong to a Floor. A dedicated entity-reference **autocomplete widget** links the
levels together — when you pick a parent it shows each entity's name alongside its
parent's name, and it hides "final" floors from the results.

The project ships three optional submodules so you install only what you need:

- **`re_mgr_presentation`** — a configurable block for presenting the portfolio
  data, driven by pluggable presentation plugins arranged in tabs.
- **`re_mgr_visualization`** — provides a presentation plugin that displays the
  data in a richer visual way (and adds a coordinate field to entity types other
  than Estate); depends on the presentation submodule, plus Webform and core
  Media.
- **`re_mgr_demo`** — installs demo content so you can evaluate the module
  quickly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   `entity` dependency, and enable the submodules you want.

Configuration and content management happen in the module's own admin section
rather than a single settings form; see "Where it lives" and "How to use it"
below.

## Where it lives in the admin menu

Real Estate Manager gives itself a dedicated admin area under **`/admin/re-mgr`**,
which includes content management, entity/bundle configuration, and a *Purge
data* form (`/admin/re-mgr/config/purge`). Bundles are also reachable from
**Configuration → Entities configuration**. The various administration pages are
gated by the **Access real estate manager administration pages** permission, and
the more powerful actions (the *administer module* and *administer … entity*
permissions) are marked restricted.

## How to use it

1. **Enable the pieces you need** — the base module (and optionally
   presentation, visualization, and/or demo — see
   [Installation](installation/index.md)).
2. **Grant permissions.** Give the relevant roles the per-entity-type permissions
   (view/add/edit/delete) plus administration access as appropriate.
3. **Create content top-down.** Start with an **Estate** (only a name is
   required), then add **Buildings** (optionally linked to an Estate, with an
   available/reserved/sold status), then **Floors** (each must have a parent
   Building; you can mark a floor "final" to exclude it from parent selection),
   then **Flats** (each must have a parent Floor, and always carries a status
   because flats are always for sale).
4. **Present the portfolio.** If you enabled the presentation submodule, place its
   block and enable the plugins you want in the block's configuration (each plugin
   has its own settings and the plugin order is configurable). Add the
   visualization submodule for a richer visual presentation.
5. **Clean up when decommissioning.** Use the **Purge data** form at
   `/admin/re-mgr/config/purge` (requires *administer module*) to remove all
   module data in one place, which prepares the module for uninstall.
