<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Mode Manager examples — agent index

A demo submodule (package **Examples**) that installs sample config so you can try Form Mode
Manager immediately. Not for production. No `configure` route, no config schema, no permissions,
no services of its own.

What it installs (from `config/install`):
- Content type **`node_form_mode_example`** (with body + `field_picture` image field).
- Node form mode **`contributor`** (`core.entity_form_mode.node.contributor`) + its form display.
- A **`contributor`** user role.
- A default view display for the demo type.

What it adds in code:
- Front-page controller at **`/form_mode_manager_examples`** (route
  `form_mode_manager_examples.front_page`, permission `access content`) linking to the demo type's
  add form.
- `hook_menu_local_actions_alter()` → shows the `form_mode_manager.action:node.contributor` local
  action ("Add node as contributor") on that front page.

For how form modes actually work, see the parent module docs
(`../../../3.1.x/agent/start.md`).
