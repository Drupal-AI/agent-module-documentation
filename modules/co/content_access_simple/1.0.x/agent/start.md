<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Access Simple (content_access_simple) — agent index

**Adds a simplified per-node "view access" role list to the node edit form, backed by the Content Access module's node grants.**

- **Version:** 1.0.x (1.0.0-beta4)
- **Core:** ^10 | ^11
- **Requires:** content_access
- **Permission:** `access content access simple` (shows/edits the widget)
- **Service:** `content_access_simple.access_manager` (Drupal\content_access_simple\AccessManager)
- **Hooks:** hook_form_node_form_alter, hook_entity_extra_field_info, hook_theme
- **Config:** `content_access_simple.settings` (hidden_roles, disabled_roles, debug, help_text_view, unpublished_message)

Enable the "Content Access Simple" extra form field via Manage form display, and enable per-node access on the content type's Content Access settings.

**Security:** Enforcement is delegated to Content Access (writes real node grants via acquireGrants + node.grant_storage); this module only alters the node form UI, gated by the `access content access simple` permission and per-node-access being enabled. Admin message/help strings are Xss::filterAdmin()-sanitised. No anonymous or standalone mutating endpoints.

See [configure/content_access_simple.md](configure/content_access_simple.md)