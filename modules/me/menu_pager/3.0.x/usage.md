<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Pager adds a block with previous/next links derived from a menu's own order and structure, so a visitor can move through a section in the sequence the menu already defines.

---

Sequence navigation needs a definition of the sequence, and the usual source is content creation date — right for a blog, wrong for anything a person deliberately ordered. A handbook's chapters, a guidance section's pages, a course's lessons, a policy document's parts each have an order somebody chose, and that order already lives in the menu, because the menu is how visitors navigate the section in the first place. Menu Pager reads previous/next straight from that menu, so the two agree by construction — reorder the menu and the pager follows, with nothing separate to keep in step. The module derives one block **per menu** (via a deriver); place the block for the menu you care about and it appears only on pages whose active menu link belongs to that menu. Version **3.0.4** on core `^8 || ^9 || ^10 || ^11`, no dependencies, no configuration required. Three concrete behaviours to know. **Tree vs. siblings**: by default it flattens the whole menu tree depth-first, so "next" from the last child of a section jumps into the following section; enable the per-block **Restrict to parent** option and it only pages between links sharing the active link's parent (previous/next stop at the ends of that sibling group). **Access is respected**: the tree passes through core's `checkAccess` manipulator and only links the current user may see — and that are enabled — are eligible, so the pager never links to a route the visitor can't reach; disabled links and `<nolink>`/`<separator>` items are skipped, and you can exclude more with `hook_menu_pager_ignore_paths()`. **The block is uncacheable by design** (cache max-age 0, `url.path` context, with a core `@todo` to make it cacheable), so it is always recomputed per request and never serves a stale pager — the trade-off is no render-cache benefit rather than a staleness bug. Labels are configurable per block: default `<<` / `>>` markers, an option to hide the menu-link title and show only the label, or fully custom Previous/Next text.

---

- Add previous/next links to a handbook whose chapters are ordered in a menu.
- Navigate documentation pages in the exact order the docs menu lists them.
- Move through a course's lessons following the course menu.
- Follow a policy document's parts in menu order.
- Reorder a section's navigation by editing the menu — the pager follows automatically.
- Keep the pager and the section menu in step without a second ordering to maintain.
- Page through a knowledge-base branch using its menu.
- Restrict paging to siblings only, so the pager stays within one section (Restrict to parent).
- Let the pager cross section boundaries by leaving it to traverse the whole tree.
- Add step-by-step navigation to an onboarding sequence built as a menu.
- Move through a manual's chapters placed in a book-like menu.
- Navigate a report's chapters in menu order.
- Follow a legislated procedure's steps as ordered in the menu.
- Show only the neighbouring page titles as prev/next links (default markers).
- Hide the menu title and show only your own Previous/Next wording.
- Set fully custom Previous and Next label text per block.
- Place a distinct pager for each menu on the site (one block is derived per menu).
- Exclude placeholder menu items (`<nolink>`, `<separator>`) from the pager automatically.
- Exclude additional paths from a project's pagers with `hook_menu_pager_ignore_paths()`.
- Ensure the pager never links to a page the current user cannot access.
- Skip disabled menu links so they never appear as prev/next.
- Give a wizard-like section forward/back navigation without custom code.
- Add prev/next to a curriculum or syllabus organized as a menu.
- Keep readers moving through a long section one page at a time.
