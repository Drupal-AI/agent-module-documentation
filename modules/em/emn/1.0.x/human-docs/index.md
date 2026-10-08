# Entity Machine Name (emn) — manual setup guide

**Entity Machine Name** (`emn`) is a small, single‑purpose convenience for
developers and site builders: it surfaces the otherwise‑hidden **machine names**
of several config entities directly in Drupal's admin list tables, so you can read
an ID without opening each entity's edit form.

Once enabled, it adds a **Machine name** column to four core admin listings:

- **Content types** at `/admin/structure/types`.
- **Taxonomy vocabularies** on the vocabularies overview.
- **User roles** at `/admin/people/roles`.
- **Blocks** on the block layout page (showing each block's plugin ID).

It changes no data — this is a purely read‑only usability aid. It has no settings,
no routes, no permissions, and no services of its own; the columns simply appear on
the core admin pages you already have access to, so access is inherited from those
pages' existing administer permissions. There are no module dependencies beyond
core's User, Block, Taxonomy, and Node modules (all enabled by default).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration** for this module. No setup is required — the machine
name columns appear automatically once it's enabled.

## How to use it

There's nothing to configure. After enabling the module, visit any of the admin
listings above (for example **Structure → Content types**) and you'll see a new
**Machine name** column beside the human‑readable labels. Use it to copy a machine
name for code, confirm a content type's ID before referencing it in a View or
template, check a block's plugin ID when theming, or onboard yourself to an
unfamiliar site's structure — all without clicking into each entity's edit form.
