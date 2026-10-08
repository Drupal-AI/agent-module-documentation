<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Field — agent index

Adds a `language_field` field type that stores language **codes** as data on any entity
(spoken languages, original language, …), plus a `custom_language` config entity for
languages Drupal doesn't ship. No global settings form (`configure: null`); everything is
configured per field (storage settings) and per custom-language entity.

- **Add a Language field, storage settings (`language_range`, include/exclude), widgets & formatter** →
  [configure/field.md](configure/field.md)
- **Register a custom language (`custom_language` config entity), permission, admin route** →
  [configure/custom-languages.md](configure/custom-languages.md)
- **Field type / widgets / formatter plugin ids, tokens, Views/Feeds/Tamper integration** →
  [api/plugins.md](api/plugins.md)

Key facts:
- Field type id: `language_field` (default widget `languagefield_select`, default formatter `languagefield_default`).
- Widgets: `languagefield_select`, `languagefield_autocomplete`, `languagefield_autocomplete_tags`.
- Storage setting `language_range` values: `1` configurable, `2` locked, `3` all core, `4` site default, `11` all predefined, `12` custom (module's own).
- Custom languages: config entity `custom_language.<id>` at `/admin/config/regional/custom_language`; permission `administer languagefield`.
