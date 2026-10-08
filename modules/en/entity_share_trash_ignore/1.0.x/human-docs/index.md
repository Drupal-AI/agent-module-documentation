# Entity Share Trash Ignore — manual setup guide

**Entity Share Trash Ignore** (`entity_share_trash_ignore`) makes **Entity Share**
skip entities that are in the **Trash** bin when syncing, so trashed content is not
re‑imported onto the target site. If you don't use both Entity Share and the Trash
module, you don't need this module.

The problem it fixes is a concrete failure. When an entity has been imported via
Entity Share and then moved to the trash bin on the target site, Entity Share sees
it as new again and offers to import it. Attempting that import fails with a 500
error, because Entity Share tries to create a new entity whose UUID is already
taken by the trashed one. This module adds an import processor that simply skips
entities already in the trash bin, avoiding the collision.

It is refreshingly hands‑off: the processor is **active as long as the module is
installed**, so there is nothing to configure — it works right out of the box. It
depends on **Entity Share Client** (`entity_share_client`) and the **Trash**
(`trash`) module, and has no access‑control role of its own — sharing access still
follows Entity Share's own configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** and nothing to set up — the trash‑skipping
processor is active automatically once the module is enabled.

## Where it lives in the admin menu

The module adds no admin page. It works invisibly during Entity Share sync,
skipping any entity that is currently in the Trash bin.
