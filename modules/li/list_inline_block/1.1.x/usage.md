<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
List Inline Block surfaces the inline blocks added through Layout Builder and where each is used.

---

Layout Builder inline blocks are otherwise hard to enumerate; this module adds an admin page (`/admin/structure/block/list-inline-block`, gated by `access site configuration`) and a Drush command that list inline block content entities together with the nodes/layouts referencing them. It is an administrative auditing/reporting tool with no content of its own.

---

- List all inline blocks created in Layout Builder.
- Show which nodes/layouts use each inline block.
- Audit orphaned or reused inline blocks.
- View the list from an admin UI page.
- Query the inline block list via Drush.
- Gate the UI behind `access site configuration`.
- Help clean up Layout Builder inline block content.
- Track inline block usage across the site.
- Support site audits and content inventory.
- Report block-to-node relationships.
- Assist maintenance of Layout Builder sites.
- Integrate with core Layout Builder.
- Support Drupal 9 and 10.
- Provide reporting without altering content.
- Speed up locating a specific inline block.
- Expose inline block data to admins only.
