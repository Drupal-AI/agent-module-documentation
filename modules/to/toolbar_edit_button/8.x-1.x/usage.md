<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toolbar Edit Button surfaces the entity Edit local task as a button in the Drupal admin toolbar.

---

Toolbar Edit Button provides a service (`toolbar_edit_button.edit_button`) that inspects the current route's local tasks and, on `entity.node.canonical` and `entity.taxonomy_term.canonical` pages, injects a toolbar item linking to the node or term edit form. On other routes it renders a hidden dummy item (for cache consistency). It relies on the local-task plugin manager and current route match; there is no configuration form or permission of its own - visibility follows the user's access to the underlying edit route and the core toolbar.

---

- Add an Edit button to the admin toolbar.
- Jump straight to a node's edit form from its page.
- Jump to a taxonomy term's edit form from its page.
- Keep the edit shortcut visible while browsing content.
- Render nothing (hidden) on non-editable routes.
- Reuse the entity edit local task rather than a custom link.
- Provide a keyboard-reachable edit affordance in the toolbar.
- Speed up editorial workflows for content editors.
- Attach a small styling library for the toolbar icon.
- Cache per url.path so the button follows the page.
- Work with the core Toolbar module.
- Avoid a dedicated config form (zero setup).
- Respect edit-route access (button only where edit exists).
- Show a pencil/edit toolbar icon.
- Apply site-wide once enabled.
