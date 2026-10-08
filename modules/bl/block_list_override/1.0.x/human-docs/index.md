# Block List Override — manual setup guide

**Block List Override** (`block_list_override`) trims Drupal's block library —
both the theme's block-placement list and Layout Builder's "Add block" chooser — by
removing block plugins you never use. On sites with lots of entity and field
blocks, those lists can grow to hundreds of entries; this module lets you cut them
down so editors see only relevant blocks, which declutters the UI and speeds up the
block admin pages.

You describe which block plugins to target using three kinds of rule: an **exact
match** on a plugin id (for example `system_powered_by_block`), a **prefix** match
(for example everything starting `field_block:`), or a **regex** pattern. An
**Action** setting then decides what happens to the matched blocks: either *Remove*
them from the list (the default) or *Allow only* them — meaning the list is
restricted to just the matched blocks and everything else is hidden. Blocks already
placed inside a Layout Builder section are always kept, so tidying the list won't
break existing layouts.

A quirk worth knowing in this version: the same match/prefix/regex patterns govern
**both** the theme block list and the Layout Builder chooser; only the *Action*
toggle can differ between the two. The module provides two preview pages so you can
see exactly which blocks survive your rules before relying on them. Block List
Override depends on core's **Block** module, adds an **Access block list override**
permission for its settings, and has no third-party dependencies or submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the exact config
keys, the matching semantics, and the Layout Builder behavior — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the match/prefix/regex rules, the
   Remove vs Allow-only action, and the preview pages.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Block List
Override Settings** (`/admin/config/block_list_override/settings`), with preview
pages at `/admin/config/block_list_override/system-list` and `/layout-list`.

## How to use it

Open the settings form, add the plugin ids (or prefixes/regexes) of the blocks you
want gone, choose whether to *Remove* or *Allow only* them, and save. Then check
the preview pages to confirm the surviving list looks right. Be careful removing a
block that is actually placed somewhere — Drupal will show "non-existent block"
warnings — which is exactly what the preview pages help you avoid. See
[Configuration](configuration/index.md) for the details.
