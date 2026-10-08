# Simple Block — manual setup guide

**Simple Block** (`simple_block`) gives you reusable title/content blocks that are
stored as **configuration entities** instead of content. Core's *Block Content*
saves custom blocks as content in the database; Simple Block instead saves each
block as a small piece of exportable config — just a machine name, a title, and a
formatted‑text body. That difference matters when a block's markup should be
deployed like code: your promo notice, footer disclaimer, or standard call‑to‑action
travels through config sync from dev to stage to production, staying identical
everywhere and living under version control alongside the rest of your site config.

You manage these blocks at **Administration → Structure → Block layout → Simple
blocks** (`/admin/structure/block/simple-block`), where you can add, edit, clone,
and delete them. Each block's content is a rich‑text area with a chosen text format
(for example *Full HTML*), and **global tokens** such as `[site:name]` are replaced
when the block renders — handy for a call‑to‑action that echoes the site name or the
current date. Every block you create becomes a placeable block plugin
(`simple_block:<id>`) that you drop into a region just like any other block.

The module also ships a field formatter, *Simple block (rendered)*, so an
`entity_reference` field that points at a simple block can render that block's
content inline. An optional submodule, **Simple Block + Layout Builder**
(`simple_block_layout_builder`), lets you create and edit these blocks directly
inside the Layout Builder UI. Simple Block depends only on core's **Block** and
**Filter** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and decide whether you need the Layout Builder submodule.

## Where it lives in the admin menu

Once enabled, the block manager sits at **Structure → Block layout → Simple blocks**
(`/admin/structure/block/simple-block`). Placing the blocks you create happens on the
regular **Block layout** page (`/admin/structure/block`). Simple Block adds no
settings form of its own.

## How to use it

### Create a block

1. Go to **Structure → Block layout → Simple blocks** and click **Add simple block**
   (you need the core **Administer blocks** permission).
2. Enter a **Title**, accept or edit the auto‑generated **Internal name** (the machine
   id), and write the **Content** in the formatted text area. The form notes that
   *global tokens are allowed*, so you can drop in tokens like `[site:name]`.
3. Pick the text format you want (for example *Full HTML*) and save.

### Place it in a region

Open **Structure → Block layout** (`/admin/structure/block`), click **Place block**
in the region you want, and find your block by its title (it appears under the
*Simple block* category). It renders its content through the chosen text format with
global tokens replaced.

### Clone, edit, or delete

Back on the **Simple blocks** listing, each row has **Edit**, **Clone**, and
**Delete** actions. Cloning is the quickest way to spin up a variant of an existing
block.

### Deploy it as config

Because each block is a config entity, `drush config:export` writes a
`simple_block.simple_block.<id>.yml` file into your config sync directory. Commit and
deploy it like any other configuration, and the block appears — identical — on the
target environment.

### Permissions

Beyond core's **Administer blocks** (needed to add and list blocks and place them in
regions), Simple Block adds three permissions to refine who can change existing
blocks:

| Permission | Lets a role… |
|-----------|--------------|
| **Update simple blocks** (`update simple blocks`) | Edit an existing block |
| **Clone simple blocks** (`clone simple blocks`) | Clone an existing block |
| **Delete simple blocks** (`delete simple blocks`) | Delete a block |

This lets you give an editor the ability to update copy without handing over full
block administration. Note that *creating* a new simple block still requires the core
**Administer blocks** permission.
