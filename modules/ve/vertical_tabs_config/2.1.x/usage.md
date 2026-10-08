<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vertical Tabs Config lets you hide the vertical tabs (Authoring information, Promotion options, Menu settings, etc.) on node add/edit forms per content type and per role, and reorder them.

---

The module has two features, driven by two admin screens under *Configuration › User interface › Vertical Tabs Config*. **Visibility** (route `vertical_tabs_config.visibility`, the `configure` route) presents, per content type, a checkbox for each known vertical tab plus optional role checkboxes; ticked tabs are hidden on that content type's node form, either for everyone or only for the selected roles. This visibility data is stored in a **custom database table `vertical_tabs_config`** (columns `content_type`, `vertical_tab`, `hidden`, `roles` as JSON), not in config. **Order** (route `vertical_tabs_config.order`) sets a weight for each tab, stored in the config object `vertical_tabs_config.order` under keys like `vertical_tabs_config_author`. At form build time `hook_form_node_form_alter()` reads both: it hides the flagged tabs (respecting the role rule) and applies the configured `#weight` to each present tab. The known tabs are a fixed list: `meta` (Entity meta information), `options` (Promotion options), `menu`, `revision_information`, `path_settings`, `author` (Authoring information), `book`, `ds_switch_view_mode`; the Metatag tab is intentionally excluded from reordering because it forces itself to the top. Both admin pages are gated by the core `administer site configuration` permission (the module defines no permission of its own). The module affects only node add/edit forms.

---

- Hide the "Authoring information" tab from editors on the Article content type.
- Hide "Promotion options" (sticky/promoted) on content types where it shouldn't be exposed.
- Remove "URL path settings" from the node form for a specific content type.
- Hide "Menu settings" so editors can't attach menu links to certain content.
- Hide "Revision information" on a content type that doesn't use revisions.
- Hide the "Book outline" tab where books aren't used.
- Hide tabs only for specific roles (e.g. hide authoring info from a "content editor" role but keep it for admins).
- Apply a hide rule to all roles by selecting no role for a content type.
- Reorder vertical tabs so the most-used tab appears first.
- Move "Authoring information" to the top of the node form's vertical tabs.
- Give a consistent tab order across all content types.
- Simplify the node edit UI for non-technical editors by hiding advanced tabs.
- Reduce editor confusion by removing rarely used tabs from the form.
- Set per-content-type visibility so a landing-page type shows fewer tabs than an article.
- Push a low-priority tab (e.g. Book outline) to the bottom via a high weight.
- Standardise the node form layout during an editorial UX cleanup.
- Hide the Display settings (`ds_switch_view_mode`) tab provided by Display Suite.
- Configure tab weights through exported config (`vertical_tabs_config.order`).
- Keep the Metatag tab where it is (it can't be reordered) while ordering the rest.
- Restrict advanced publishing options from junior editors by role-scoped hiding.
- Present a cleaner node form on a decoupled/editorial site.
- Hide the Entity meta information tab on content types that don't need it.
- Roll out a role-specific editing experience without custom form_alter code.
- Adjust the node form tab order after adding a contrib module that injects a new tab.
