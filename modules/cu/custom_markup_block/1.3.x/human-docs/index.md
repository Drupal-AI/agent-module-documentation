# Custom Markup Block — manual setup guide

**Custom Markup Block** (`custom_markup_block`) provides a block with a single
filtered text area where you type in whatever markup you want rendered. What makes it
different from a core custom block is *where the content lives*: the markup is stored
entirely in **configuration**, not as a content entity. That means it travels with
your config in the normal staging/deployment process (`drush cim`), is
version‑controlled alongside the rest of the site, and won't come back as an orphaned
block after a database refresh. Use it for markup the **codebase** owns — a copyright
or legal notice, a button, a third‑party embed wrapper, a small structural fragment —
rather than content an editor should manage.

The markup is edited through a **text‑format** field, and this is the reassuring part
of the design: the format list you're offered is limited to the text formats you're
actually permitted to use, and the block renders its content **through Drupal's filter
pipeline** with that format applied — not as raw, unfiltered HTML. The default format
is *Full HTML*, which core only offers to users who already hold it. As always with a
text area that can emit HTML, treat the ability to place these blocks as a trusted,
admin‑level task: whoever can add or edit the block controls what markup the page
renders, so keep block administration to trusted roles.

One trade‑off to keep in mind: because the content is configuration, a config import
(`drush cim`) overwrites anything that was edited through the UI on that environment.
That's exactly what you want for codebase‑owned snippets, but it's the wrong tool for
anything an editor needs to change directly. The module depends only on core's
**Filter** module and works on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings page; each block is configured where you place it, as
described in "How to use it" below.

## Where it lives in the admin menu

You add and place the block from **Structure → Block layout** (`/admin/structure/block`),
and it's equally available inside **Layout Builder**, **Page Manager**, or similar
display tools. Placing and editing blocks is governed by core's **Administer blocks**
permission.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region you
   want (or add the block within a Layout Builder / Page Manager layout).
2. Choose **Custom markup block**.
3. Enter your markup in the text area and pick a **text format** from the list (you'll
   only see formats you're allowed to use; *Full HTML* appears only if you hold it).
   The content will be rendered through that format's filters.
4. Configure the usual block settings (region, visibility conditions, title) and save.

Because the content is stored in config, export it (`drush cex`) and commit it so the
block deploys identically to every environment.
