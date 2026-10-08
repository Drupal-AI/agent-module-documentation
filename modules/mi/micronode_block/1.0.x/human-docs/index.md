# Micronode Block — manual setup guide

**Micronode Block** (`micronode_block`) derives a **block plugin for every
micronode type**, giving content authors a highly opinionated, plug-and-play way to
place [Micronode](https://www.drupal.org/project/micronode) content fragments as
blocks. Once enabled, the new block plugins appear in a **"Components"** category and
are most useful within **Layout Builder**.

The experience is deliberately streamlined. When you place a Micronode Block you can
either **create a new micronode** on the spot or **select an existing one**; when you
edit a placed block, you can edit the referenced micronode inline or remove and
replace it. Crucially, there is **no per-type configuration** to repeat: add a new
micronode type and its block plugin is available immediately, with no extra setup.

This plug-and-play authoring leans on **Entity Browser** and **Inline Entity Form**,
so those modules — along with **Micronode** and core **Views** — are requirements.
While there are other ways to render an entity inside a block (Block Node, Quick Node
Block, Entity Browser Block, or a Content Block type with an entity-reference field),
Micronode Block is distinguished by its opinionated author UX and its zero-config
support for new content types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Micronode / Entity Browser / Views dependencies.

There is **no configuration page** — you place the derived blocks (ideally in Layout
Builder), described in "How to use it".

## Where it lives in the admin menu

The module adds no settings page. Its block plugins appear in the **Components**
category wherever you place blocks — most usefully in **Layout Builder**, and also in
**Structure → Block layout**.

## How to use it

1. Enable the module and its requirements (see
   [Installation](installation/index.md)).
2. In **Layout Builder** (or block layout), add a block and look under the
   **Components** category — you'll find a block for each micronode type.
3. When placing the block, choose to **create a new micronode** or **select an
   existing** one.
4. To change it later, edit the block: you can edit the referenced micronode inline,
   or remove and replace it.

New micronode types automatically get their own block — no additional configuration
is needed.
