<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Group lets you bundle several blocks into a single, placeable block. Each block group you create becomes both a new derived block plugin and a new theme region, so the child blocks move together, inherit their parent's placement and visibility, and can even be nested.

---

Block Group extends the core Block layout system. Creating a "block group content" config entity (`block_group_content`) does two things at once: it registers a derived block plugin (`block_group:<id>`) whose admin label is the group's name, and — via `hook_system_info_alter()` — it adds a theme region named after the group id to every theme. You place the group's block into a normal region on `/admin/structure/block`, then drag any other blocks into the group's own region; when the group block renders it collects every enabled block assigned to its region (sorted by weight, access-checked) and outputs them together. Because the group block is itself a block, its placement, weight, and visibility conditions propagate to all its children, and one group can be dropped into another group's region to nest arbitrarily deep. Special core blocks are handled: the main content block and the page title block render correctly inside a group. Groups are managed at `/admin/structure/block_group_content` behind the `administer blockgroups` permission. Everything is stored as config (only `id` and `label` are exported), so groups travel through configuration sync. The module ships no dependencies of its own beyond core's Block module and defines no services or Drush commands.

---

- Wrap a header logo, search block, and menu into one "Header" group placed as a single block.
- Build a reusable footer bundle (menus, copyright, social links) that moves as a unit.
- Create a sidebar "promo" group and toggle its visibility with one set of conditions.
- Group blocks so a single visibility condition (path, role, content type) governs all of them.
- Give a set of blocks one shared weight/position instead of ordering each individually.
- Nest a block group inside another group to build multi-level layout structures.
- Apply one block's placement to many blocks at once by grouping them.
- Assemble a "call to action" cluster (heading, text, button blocks) as one placeable unit.
- Reorder a whole cluster of blocks on a page by moving the single parent block.
- Move a group of blocks between regions (sidebar → content) in one drag.
- Show/hide an entire promotional section per role by conditioning only the group block.
- Keep the main page content and page title together inside a custom-rendered group region.
- Create theme regions on the fly without editing the theme's `.info.yml`.
- Provide site builders named regions ("Block group: Hero") that appear in the block UI.
- Package a landing-page block arrangement so it can be exported and deployed via config sync.
- Duplicate a common block arrangement across environments by exporting the group config entity.
- Compose dashboards from many small blocks grouped into logical panels.
- Limit repetitive per-block configuration by setting conditions once on the group.
- Group utility blocks (language switcher, user login) into a compact "tools" cluster.
- Stage an experimental block layout as a group, then place or unplace it with one action.
- Organize blocks by section (marketing, navigation, legal) for easier site-builder handoff.
- Render a curated set of blocks inside a card/panel wrapper region for theming.
- Reduce block-layout clutter by collapsing related blocks into one parent entry.
- Keep related blocks in sync when migrating a page design between themes.
