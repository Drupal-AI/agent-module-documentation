<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Reusable Blocks lets an editor create a reusable content block, and (optionally) edit an existing reusable block, without leaving Layout Builder for the block library.

---

Layout Builder offers two kinds of custom block: inline blocks, which belong to one layout and cannot be reused, and reusable content blocks from the library, which can be placed anywhere but are normally created and edited at `/admin/content/block`. That split forces a context switch at exactly the wrong moment — an editor building a page realises the callout should be shared, and has to leave the page, create it elsewhere, come back and place it.

This module alters the Layout Builder "Add block" form (`hook_form_layout_builder_add_block_alter`) so that when you add a custom inline block you first choose "Create inline block" or "Create reusable block"; choosing reusable adds an "Admin title" field, and on save the block is flipped to reusable (`setReusable(TRUE)`) and the placed component is rewired to reference `block_content:<uuid>` from the library. A site setting can skip the choice and make every added block reusable. Separately, a custom block plugin `LayoutBuilderReusableContentBlock` can — when the administrator turns it on — surface the block's edit form inline in Layout Builder so a shared block can be edited in place, with an optional warning message. The module ships one settings form at `/admin/config/user-interface/layout-builder-reusable-blocks`, gated by the `administer layout builder reusable blocks` permission (`restrict access: true`), and one permission. It depends on core `layout_builder` and `block_content`.

The thing to be deliberate about is the consequence of that convenience, because it is the same one the block library's separation was protecting against: editing a reusable block from one page changes it on every page that uses it. Whether that is a problem depends on the site, but it is worth pairing this with a clear visual distinction between inline and reusable blocks, and with a considered decision about who may edit shared blocks. Note the in-place editing feature is off by default (`allow_editing_reusable_blocks` defaults to FALSE).

---

- Create a reusable block from inside Layout Builder instead of the block library.
- Choose inline vs reusable at the moment you add a custom block.
- Give a new reusable block an admin title so it can be found and reused later.
- Promote a just-created inline block to the block library in one flow.
- Avoid a context switch to `/admin/content/block` while building a page.
- Let editors build and share components without leaving the layout.
- Reuse a callout, CTA or notice across several landing pages.
- Update shared content once and have it change everywhere it is placed.
- Reduce duplicated block content across many pages.
- Force every new Layout Builder block to be reusable site-wide (streamlined workflow).
- Edit a shared reusable block in place when the administrator enables that option.
- Show editors a warning that changes to a reusable block affect all instances.
- Customise the wording of that warning message per site.
- Restrict who may configure the module via a dedicated permission.
- Keep the inline/reusable behaviour consistent through exported configuration.
- Pair with theming that visually marks which blocks on a page are shared.
- Train editors on the reach of a shared-block edit before enabling in-place editing.
- Adopt the core Issue #2999491 workflow now without carrying core patches.
- Standardise "make this reusable" as a first-class step in your editorial process.
- Speed up assembling pages from a small set of shared, maintained components.
