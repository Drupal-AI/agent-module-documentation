<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enable the "Provide a menu link" option by default on chosen content types, so new nodes of those types open with the menu-settings widget on.

---

Menu Link by Default adds a per-content-type checkbox to the node type edit form (inside core Menu UI's "Menu settings" section): "Enable 'Provide a menu link' by default when creating new content of this type." The choice is stored as a node-type third-party setting (`menu_link_by_default.enable_menu_link_by_default`). On new node forms for that type (the `default` operation only), the module opens the collapsed "Menu settings" details element and pre-checks the "Provide a menu link" checkbox, so editors are prompted to add the page to a menu rather than silently skipping it. It does not force a link, choose a parent, or pre-fill the link title — it only flips the default state of core's existing widget. Existing-node edits and non-default operations (revisions, etc.) are left untouched. It depends only on core `menu_ui` and `node` and supports Drupal 10.2, 11, and 12.

---

- Encourage editors to add a menu link every time they create a landing page.
- Default the "Provide a menu link" checkbox to on for the Basic page content type.
- Keep evergreen content types (e.g. Page, Landing page) wired into site navigation.
- Reduce the number of published pages that get orphaned from the main menu.
- Pair with Pathauto so new pages get both an alias and a menu placement prompt.
- Turn the behavior on for some content types (Page) while leaving others (Article) untouched.
- Auto-expand the collapsed "Menu settings" section on new node forms so it is not missed.
- Nudge non-technical authors toward consistent information architecture.
- Give a lighter-touch alternative to enforcing menu links via required fields or validation.
- Configure the default entirely through the UI, per content type, with no code.
- Export the per-type default in configuration (as a node-type third-party setting) for deployment.
- Ship the "menu link by default" behavior across environments via config sync.
- Prompt editors on a Documentation content type to file each page under a section.
- Keep the setting invisible until at least one menu is made available to the content type.
- Avoid changing behavior for existing content edits — new content only.
- Leave revision and other non-default node form operations unaffected.
- Let editors still uncheck the box per node when a menu link is not wanted.
- Standardize editorial workflow across a team without custom form_alter code.
- Onboard new site sections by flipping one checkbox on the type.
- Support Drupal 10.2+, 11, and 12 with a core-only footprint.
