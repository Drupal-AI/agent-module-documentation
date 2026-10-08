<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preserve Changed Timestamp UI (preserve_changed_ui) — agent index

Adds a per-node "Preserve changed time" checkbox to the node edit form. When an editor ticks it,
saving the node keeps its existing `changed` ("Last saved") timestamp instead of bumping it to now —
meant for trivial edits like typo fixes. Node-only. Depends on core `node`.
Core requirement `^8.8 || ^9 || ^10 || ^11`.

Settings page: `/admin/config/system/preserve-changed-ui` (route `preserve_changed_ui.settings_form`).
No Drush commands, no plugin types.

- **Site-wide default for the checkbox + the config object** → [configure/settings.md](configure/settings.md)
- **The `preserve_changed_time` base field, enabling it per bundle, how the timestamp is preserved on save** → [fields/preserve_changed_time.md](fields/preserve_changed_time.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Base field `preserve_changed_time` (boolean) is added to `node` entities via
  `hook_entity_base_field_info`; it is NOT displayed by default — enable its widget on each bundle's
  form display (`/admin/structure/types/manage/<type>/form-display`).
- `hook_form_node_form_alter` sets the checkbox default from config and hides it (`#access = FALSE`)
  for new nodes and for users without the `preserve_changed_ui allow preserve changed time` permission.
- `hook_entity_presave` restores the timestamp: `$entity->setChangedTime($entity->original->getChangedTime())`
  when the box is checked, then clears the field value.
- Config object `preserve_changed_ui.settings`, single key `enable_preserve_changed_time` (boolean,
  default `FALSE`).
- Permissions: `administer preserve_changed_ui configuration`, `preserve_changed_ui allow preserve changed time`.
- Source: `preserve_changed_ui.module`, `src/Form/SettingsForm.php`, `config/install`, `config/schema`.
