<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a per-node contribution todo-list where users create, share, pin, and state-track todos attached to nodes through a block.

---

Contribution Todo list defines a lightweight `todo` content entity and a "Contrib todo list block" that renders on node pages. Each todo belongs to a node and a user, carries a free-text description, a state (Pending / In progress / Completed), an optional "pin" (a CSS selector locating an element on the node so a marker can be dropped there), and a share flag. Users holding the `manage todo list` permission add todos via an AJAX form, flip state and share status from a dropdown, pin a todo to a page element, and delete their own todos; shared todos become visible to other permitted users viewing the same node. A separate `/admin/my-todos` listing (linked under Content) shows all of the current user's todos with state/share filters and delete operations. State labels are exposed to Twig through a custom Twig extension, and a French translation ships with the module. Depends on core `options` and `history`; supports Drupal 10 and 11. No admin settings form — behaviour is entirely permission-driven.

---

- Attach a checklist of contribution tasks to any node.
- Let content reviewers track per-node todos without leaving the page.
- Create todos from a block placed on node pages.
- Track each todo through Pending, In progress, and Completed states.
- Share a todo so other permitted users see it on the same node.
- Keep private todos visible only to their owner.
- Pin a todo to a specific element on the page and jump back to it.
- Filter multilingual sites' todos by language (todos are per-langcode).
- Give a role todo access with the single `manage todo list` permission.
- Review all your own todos on the `/admin/my-todos` page.
- Filter the my-todos listing by state and share status.
- Delete your own todos from the block dropdown or the admin listing.
- Show a shared todo's author name to non-owners in the block.
- Drive todo creation, state changes, share toggles and pins over JSON endpoints.
- Add contribution planning UI to a Drupal project/documentation site.
- Coordinate content-editing tasks between team members per article.
- Use the Todo entity as a base for further custom task workflows.
- Expose todo state options to custom Twig templates.
- Provide a French-language todo interface out of the box.
- Track review checklists during content QA.
