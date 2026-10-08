<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search Autocomplete — agent index

Adds typeahead suggestions to input fields via **`autocompletion_configuration`** config entities that
map a CSS `selector` to a suggestion `source` (a callback URL or a `view::display`). Depends on `views`.
Ships 3 configs; admin UI at `/admin/config/search/search_autocomplete`.

- **The `autocompletion_configuration` entity: fields, defaults, admin UI, `admin_helper` setting** →
  [configure/autocompletion-configuration.md](configure/autocompletion-configuration.md)
- **Build a suggestion source from a view (Views display/row/style plugins)** →
  [plugins/views-callback.md](plugins/views-callback.md)
- **Attach autocompletion to a form element in code (`#autocomplete_configuration`)** →
  [api/attach.md](api/attach.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity type id `autocompletion_configuration`; config names
  `search_autocomplete.autocompletion_configuration.<id>`.
- Ships enabled: `search_block`, `search_form_content`, `search_form_users`.
- `configure` route `autocompletion_configuration.list`; single settings key
  `search_autocomplete.settings:admin_helper` (bool).
- Permissions: `administer search autocomplete`, `use search autocomplete`.
