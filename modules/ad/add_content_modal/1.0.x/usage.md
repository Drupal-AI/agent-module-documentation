<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manage content modal makes add/edit/delete/translate operations for chosen content types open inside a modal or off-canvas dialog instead of a full page load.

Use it to speed up content management workflows where editors repeatedly add or edit nodes of specific types.

- Configurable per content type and dialog type (modal or off-canvas).
- Alters links, local tasks, local actions, and entity operations to use `use-ajax`.
- Configurable modal width.
- Adds a close-dialog controller for cancel actions.

---

Install and configure:

- Enable `drush en add_content_modal`.
- Grant `manage add_content_modal settings`.
- Visit `/admin/config/content/add-content-modal`.
- Pick dialog type, width, and the content types to open in a popup.
- Save (the module flushes caches so alters take effect).

---

- Only content types in `node_add_content_types_modal` are affected.
- `hook_link_alter` upgrades translate/edit/delete links to dialog links.
- `hook_menu_links_discovered_alter` upgrades `node.add`/edit menu links.
- `hook_menu_local_actions_alter` and `hook_menu_local_tasks_alter` upgrade the "Add"/tabs.
- `hook_entity_operation_alter` upgrades edit/delete/translate operations on content lists.
- Dialog attributes are set via a shared helper (`data-dialog-type`, `data-dialog-options` width).
- Off-canvas mode uses `off_canvas` renderer; modal mode uses the default modal.
- Node forms get a process callback flattening advanced/vertical-tab layout for the dialog.
- The delete form's cancel is routed to `add_content_modal.close_dialog` (authenticated).
- The close-dialog controller returns the right Close command per dialog type.
- Relies on core `core/drupal.dialog.ajax`.
- Purely a UX layer; entity access is still enforced by core forms/routes.
- Config stored in `add_content_modal.settings`.
- Test with each configured content type.
- Adjust width for your admin theme.
