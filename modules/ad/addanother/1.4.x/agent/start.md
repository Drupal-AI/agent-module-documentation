<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add Another — agent index

Per-content-type node-creation shortcuts: a **"Save and add another"** button, an after-save
**message**, and an **"Add another" tab** (optionally on edit pages too). All state lives in one
config object, `addanother.settings`. Node-only (`dependencies: node`). No plugins, no Drush.

- **Settings form, global defaults, and per-type config keys** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Configure route: `addanother.admin_config` → `/admin/config/content/addanother` (global defaults
  `default_button` / `default_message` / `default_tab` / `default_tab_edit`).
- Per-type overrides are stored keyed by node type: `button.<type>`, `message.<type>`,
  `tab.<type>`, `tab_edit.<type>` in `addanother.settings`, edited on each content type's form.
- Two permissions: `administer add another` (reach the settings form) and `use add another`
  (see the button/message/tab). The button and message only render on the **node add** form
  (new node, empty id) for users with `use add another`.
- Routes: `addanother.redirect` = `/node/{node}/addanother` (the tab; redirects to `node.add`).
