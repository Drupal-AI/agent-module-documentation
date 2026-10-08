<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form block — agent index

Four block plugins that render core forms. **No routes, no services, no permissions,
no settings form, no config schema, no Drush.** `configure` is `null`; there is nothing
to configure globally — everything is per block instance.

| Plugin ID | Admin label | Has settings? |
|---|---|---|
| `formblock_node` | Content form | `type`, `form_mode`, `show_help` |
| `formblock_user_register` | User registration form | `form_mode` |
| `formblock_contact` | Site-wide contact form | `contact_form` |
| `formblock_user_password` | Request new password form | none |

- **Place a block, exact stored config keys, drush/PHP recipes, access rules** →
  [configure/blocks.md](configure/blocks.md)
- **What each plugin builds, and the `hook_entity_type_alter()` form-mode trick** →
  [plugins/block-plugins.md](plugins/block-plugins.md)

Gotcha: the settings **form element names differ from the stored config keys**
(`formblock_node_type` → `type`, `formblock_node_form_mode` → `form_mode`,
`formblock_show_help` → `show_help`, `formblock_contact_form` → `contact_form`,
`formblock_user_form_mode` → `form_mode`). When writing a block config entity by hand,
use the **stored** keys.
