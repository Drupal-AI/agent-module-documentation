# Solo Copy Blocks — manual setup guide

**Solo Copy Blocks** (`solo_copy_blocks`) is a one-purpose migration helper for
the **Solo** theme (the successor to the W3CSS theme). It copies your block
placements and their configuration from the W3CSS theme — or any of its
sub-themes — straight into the Solo theme, so you do not have to recreate every
block by hand when you switch.

When you run it, it carries over block placements, keeps block order and weight
intact, preserves each block's enabled/disabled status, and automatically maps
regions between the two themes so the transition is as close to hands-off as
possible. It is designed **exclusively** for the W3CSS theme and its sub-themes as
the source — it is not a general-purpose block copier.

This is a site-building utility that **duplicates configuration**, so run it
deliberately and review the result afterwards. It creates and copies config
entities but plays no content or access-control role beyond that. The module
works through a single admin form; there is nothing that happens automatically on
enable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the "Copy Blocks to Solo Theme"
   page and how to run the copy.

## Where it lives in the admin menu

Once enabled, the tool sits at **Configuration → System → Copy Blocks to Solo
Theme** (`/admin/config/system/solo-copy-blocks`), served by the
`solo_copy_blocks.admin_form` route.
