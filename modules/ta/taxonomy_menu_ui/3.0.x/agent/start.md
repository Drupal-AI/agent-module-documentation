<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Menu UI — agent index

Ports core `menu_ui`'s "Menu settings" from node types/nodes to **vocabularies/terms**. Pure
form alters — no entity type, no service, no plugin, no permission, no Drush,
`configure: null`. Its persistent state is (a) two **third-party settings on the vocabulary**
and (b) ordinary `menu_link_content` entities.

- **Vocabulary settings (`available_menus`, `parent`), where they live, how to set them** →
  [configure/vocabulary-menu-settings.md](configure/vocabulary-menu-settings.md)
- **The term form's Menu settings, the `menu_link_content` it writes, access rules, tokens** →
  [api/term-menu-links.md](api/term-menu-links.md)

Key facts an agent gets wrong:

- The third-party provider is **`menu_ui`**, *not* `taxonomy_menu_ui` — the config key is
  `taxonomy.vocabulary.<vid>.third_party_settings.menu_ui.available_menus` / `.parent`
  (schema id `taxonomy.vocabulary.*.third_party.menu_ui`). Defaults when unset:
  `available_menus = ['main']`, `parent = 'main:'`.
- A term's menu link is a plain `menu_link_content` entity with
  `link.uri = internal:/taxonomy/term/<tid>` — there is no custom storage to query.
- The term form's Menu settings group requires the `administer menu` permission (or a
  matching `menu_admin_per_menu` grant); it is hidden otherwise.
- `available_menus = []` disables the group entirely — `taxonomy_menu_ui_form_taxonomy_term_form_alter()`
  returns early.
