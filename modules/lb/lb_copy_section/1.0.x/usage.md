<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Copy Layout Builder section adds "Copy" and "Paste" links to Layout Builder sections so an editor can duplicate a whole section — its layout, settings, blocks and inline content — within the same page or onto another page.

---

The module has no configuration UI and no settings; its only setup is a single permission, **"copy paste sections"**. When a user with that permission edits a layout, a `hook_element_info_alter()` pre-render (`CopySectionRender::preRender`) injects a **Copy** link on every existing section and a **Paste** link on every "add section" position. Copying stores the chosen `Section` object (and a label) in the user's **private tempstore** (collection `lb_copy_section`, key `copied_section`). Pasting reads it back, deep-clones it via `DeepCloningTrait` — generating fresh component UUIDs and recursively duplicating referenced `block_content` inline blocks (and paragraphs) so the pasted copy is fully independent — then inserts it at the target delta through the Layout Builder tempstore. Actions work over AJAX (the layout refreshes in place) or fall back to a redirect. Because the copy buffer lives in per-user tempstore, a section copied on one page can be pasted on any other page the same user edits. There is nothing to export or configure beyond granting the permission.

---

- Duplicate a fully built Layout Builder section (columns, blocks, content) with two clicks instead of rebuilding it.
- Copy a hero/banner section from one node's layout and paste it onto another node.
- Reuse a complex multi-column section across several landing pages.
- Clone a section within the same page to repeat a pattern (e.g. a repeated card row).
- Copy a section containing an inline (custom) block and get an independent duplicate, not a shared reference.
- Speed up building pages that need repeated section configuration or content.
- Move a section's design between an entity layout and a default (content type) layout.
- Grant only trusted editors the ability to copy/paste sections via the "copy paste sections" permission.
- Copy a section with nested paragraphs and have the paragraphs duplicated too.
- Paste a previously copied section at any "add section" position in a layout.
- Standardise recurring page structures by copying a canonical section around a site.
- Avoid manual re-entry of block configuration when replicating layouts.
- Prototype quickly by duplicating and tweaking sections rather than starting from scratch.
- Keep pasted inline blocks editable independently of the original (new block_content entities are created).
- Copy a section between two browser tabs/pages during the same editing session (per-user tempstore buffer).
- Build a page by assembling copies of sections captured from several reference layouts.
- Let content teams replicate approved section templates without developer help.
- Duplicate a call-to-action section across multiple product pages.
- Reduce errors from hand-copying block settings by cloning the whole section at once.
- Work entirely within the Layout Builder UI over AJAX with in-place refresh.
