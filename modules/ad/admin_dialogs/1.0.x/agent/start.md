# Admin Dialogs — agent index

Configure existing Drupal admin links/forms to open in modal or off-canvas dialogs, no code.
Two config entities (`admin_dialog_group`, `admin_dialog`) + a settings form. Config route
`entity.admin_dialog_group.list`. One permission, no Drush. Clear cache after config changes.

- **Dialog + Dialog Group config entities, the five dialog types, selection criteria, the global
  settings form, and how the runtime hooks apply attributes** → [configure/dialogs.md](configure/dialogs.md)
- **The `administer dialogs` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Dialog `type`: `ops` | `tasks` | `actions` | `paths` | `selectors`. `dialog_type`: `modal` |
  `off_canvas`. Config schema `admin_dialogs.admin_dialog.*` / `admin_dialogs.admin_dialog_group.*`.
- Runtime: `hook_entity_operation_alter`, `hook_menu_local_tasks_alter`,
  `hook_menu_local_actions_alter`, `hook_views_ui_display_top_links_alter`, `hook_form_alter`
  add `use-ajax` + `data-dialog-*` attributes; `hook_page_attachments` feeds
  `drupalSettings.admin_dialogs.{paths,selectors}` to `assets/selector.js`.
- Global settings (`admin_dialogs.settings`): `delete_ops`, `delete_buttons`, `other_buttons`,
  `submit_spinner`.
- Ships ~40 ready-made dialog configs under `config/optional/`.
- Purely presentational admin UX; entity `admin_permission` is `administer dialogs`.
