<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_language — Permissions

Defined in `disable_language.permissions.yml`. Two permissions, both **not** restricted-access:

| Permission | Gates |
|---|---|
| `view disabled languages` | Users **with** it still see disabled languages in the **language switcher** (the module skips filtering the switcher links for them). Use it for admins/translators who must preview a not-yet-public language. |
| `create content in disabled language` | Users **with** it keep disabled languages available in **content-form language selects** (the `language_select` widget). Without it, disabled languages are removed from those dropdowns so editors cannot author content in them. |

Notes:

- Neither permission controls the **admin language edit form** or the settings form — those are
  gated by core `access administration pages` (see the route requirement on
  `disable_language.disable_language_settings`).
- The front-end **redirect** for disabled-language requests is applied to everyone; these two
  permissions only relax the *switcher* and *content-language-select* filtering, not the redirect.
- Grant from the CLI, e.g.:

```bash
drush role:perm:add editor 'create content in disabled language'
drush role:perm:add translator 'view disabled languages'
drush cr
```
