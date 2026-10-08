<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Force - Taxonomy Menu UI — agent index

Taxonomy counterpart of [Menu Force](../../../../2.0.x/agent/start.md). Makes menu placement
**mandatory for terms** in chosen vocabularies. Depends on the contrib **`taxonomy_menu_ui`**
module (which provides the menu widget on the term form). Pure form-alter submodule — **no
configure route** (`configure: null`), no settings form, no permissions, no plugins, no Drush.

- **Turn it on for a vocabulary / where it is stored** →
  [configure/require-menu.md](configure/require-menu.md)

Key facts:

- Config path: `taxonomy.vocabulary.<vid>` →
  `third_party_settings.menu_force_taxonomy_menu_ui.menu_force_taxonomy_menu_ui: true`
  (and optionally `menu_force_taxonomy_menu_ui_parent: true` to lock the default parent).
- Read/written with provider **`menu_force_taxonomy_menu_ui`**
  (`$vocabulary->getThirdPartySetting('menu_force_taxonomy_menu_ui', 'menu_force_taxonomy_menu_ui')`).
- The shipped config schema key is `taxonomy.vocabulary.*.third_party.menu_force` (it does not
  match the provider name the code actually uses) — the value is stored under the
  `menu_force_taxonomy_menu_ui` provider regardless.
- Mechanism is identical to the parent: on the term form it forces the menu fieldset open,
  checks+disables "Provide a menu link", and makes the menu link title `#required`.
