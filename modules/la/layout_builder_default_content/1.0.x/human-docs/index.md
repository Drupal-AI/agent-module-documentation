# Layout builder default content — manual setup guide

**Layout builder default content** (`layout_builder_default_content`) fixes a
specific, annoying problem: Layout Builder **inline blocks** do not survive a
default‑content export/import cleanly. Core stores an inline block reference by its
local id and revision id, and those numbers differ from site to site — so when you
export a page with the Default Content module's `content:export` command and import
it elsewhere, the inline blocks come across broken.

This module works around that. An event subscriber rewrites the inline block
reference in a component's configuration: on **export** it records the block's
stable `block_uuid`, and on **import** it reads that UUID back and resolves it to
the correct local id and revision id on the destination site. The result is that
inline blocks placed in Layout Builder layouts round‑trip correctly between
environments.

There is nothing to configure — no routes, no permissions, no settings. Enabling
the module *is* the whole setup. It addresses core issue
[#3553119](https://www.drupal.org/project/drupal/issues/3553119) for inline blocks
specifically (not other kinds of layout content).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** — enabling it is all that is required.

## Where it lives in the admin menu

It adds no admin page. It works silently behind the
[Default Content](https://www.drupal.org/project/default_content) module's
export/import commands.

## How to use it

1. Install and enable this module on **both** the source site (where you export)
   and the destination site (where you import).
2. Use the Default Content module's `content:export` / import commands exactly as
   you normally would.
3. Inline blocks placed in Layout Builder layouts will now export with a UUID
   reference and re‑import against the right local id and revision — no manual
   re‑creation needed. This makes it practical to seed a new site's layouts from
   exported content, keep them in version control, or ship them in an install
   profile.
