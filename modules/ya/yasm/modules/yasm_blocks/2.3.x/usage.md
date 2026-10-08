<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
yasm_blocks is an optional YASM submodule providing placeable blocks that show statistics counts for the whole site, the current user, or one or more groups.

---

yasm_blocks turns YASM's counting services into three block plugins you can place anywhere with the core Block module: a **Site counts** block (published nodes, comments, users, groups, files), a **Current user counts** block (the viewing user's own nodes, comments, files), and a **Groups counts** block (contents, members, comments, files and webform submissions for selected groups or the group in the current route). Each block can render as a plain list, cards, or animated counters, with optional FontAwesome icons. It depends on the parent `yasm` module (for the `yasm.builder` / `yasm.entities_statistics` / `yasm.groups_statistics` services) and core `block`. Counts are aggregates and blocks follow standard Drupal block placement and visibility rules, so restrict placement/visibility of the site and group blocks to the audiences you intend.

---

- Show total published content count in a block.
- Show total comment count on the site.
- Show the number of active users.
- Show total file count.
- Show group count when the Group module is enabled.
- Display the current user's own content count.
- Display the current user's own comment count.
- Display the current user's own file count.
- Show contents/members/comments/files for a specific group.
- Show stats for the group in the current page's route automatically.
- Sum stats across several selected groups in one block.
- Render counts as a simple bulleted list.
- Render counts as icon cards.
- Render counts as animated JavaScript counters.
- Prefix each row with a FontAwesome icon.
- Load FontAwesome from a CDN only when the theme lacks it.
- Put site totals in a footer or sidebar.
- Give members a personal "my content" panel on their dashboard.
- Show a group landing page its own membership and content counts.
- Build a lightweight public stats widget from published-content aggregates.
- Reuse YASM counting without opening the full reports dashboards.
- Combine with block visibility rules to scope who sees each counter.
