# Recreate Block Content — manual setup guide

**Recreate Block Content** (`recreate_block_content`) solves a specific, annoying
deployment problem. Drupal's configuration system exports where custom blocks are
*placed* (block placements, Layout Builder / Panels / Page Manager layouts) but never the
custom block *content* itself — because that content is content, not configuration. When
you import that config onto a fresh site, the block placement points at a block that
doesn't exist, and you get a **"missing content dependency"** error.

This module fills the gap by creating **empty placeholder blocks** so those references
resolve. It does **not** export, copy, or move any block content. Instead it scans your
imported configuration for missing `block_content` dependencies and, for each one whose
block type exists on the site, creates an empty block with the exact **bundle** and
**UUID** the config expects (plus a best-effort title pulled from the block placement).
An editor can then fill in the real content later — the important thing is that the
layout is no longer broken.

The clever bit is the trigger: the module hooks into Drupal's cache rebuild, so you
kick it off simply by **clearing caches** (`drush cr`, or Admin → Configuration →
Development → Performance → Clear all caches). It also runs once automatically when you
first install it. Each block it recreates — or each one it can't, because the block type
is missing — is reported on screen and to the log. It works with core Block layout,
Panels, and Page Manager (but not Panelizer, which declares no block dependency).

There is **no UI, no settings, and no permissions**. Its only dependency is core's
**Block Content** module. If you actually need to move block *content* between
environments, the project README points you to other tools (Fixed block content, Simple
block, or Deploy) instead.

This guide is written for a **human** using the module in a deployment. If you want
terse, token-cheap references for an AI coding agent — the two functions and the
title-resolution logic — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it; that's
   the whole setup.

## How to use it

There is nothing to configure. The workflow fits naturally into a config deployment:

1. **Enable the module** (once). Enabling it immediately runs one recreation pass, so any
   blocks already missing at that point are recreated straight away.

   ```bash
   drush en recreate_block_content -y
   ```

2. **Deploy config as usual**, then **clear caches** to recreate any blocks the newly
   imported config references. In a `drush deploy` chain the post-import cache rebuild
   does this for you; otherwise run:

   ```bash
   drush cr
   ```

   (Or use **Admin → Configuration → Development → Performance → Clear all caches**.)

Any block that gets a placeholder — or any that can't be created because its block type
(bundle) doesn't exist on the target site — is reported on screen and written to the log.
To review afterwards:

```bash
drush watchdog:show --type=recreate_block_content
```

The placeholder blocks are empty (only the type, UUID, and a title are set) — a content
editor fills in the body and fields. Preserving the UUID is what makes the imported
placement resolve correctly.
