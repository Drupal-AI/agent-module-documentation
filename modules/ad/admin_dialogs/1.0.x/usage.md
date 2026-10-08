Admin Dialogs lets you configure existing Drupal admin UI elements — operation links (Edit/Delete), local tasks, local actions, specific paths, or CSS-selected links — to open in a modal or off-canvas dialog instead of a full page load, without writing code.

---

The module adds two config entity types, **Dialog Group** (`admin_dialog_group`) and **Dialog**
(`admin_dialog`), managed at *Configuration → User interface → Dialog Groups*
(`/admin/config/user-interface/dialogs`, route `entity.admin_dialog_group.list`), plus a global
settings form. Each Dialog config specifies a **type** — `ops` (entity operation links), `tasks`
(local tasks/tabs), `actions` (local action links), `paths` (URL paths), or `selectors` (CSS
selectors) — a dialog presentation (`modal` or `off_canvas`), a width, and optional title
override, together with **selection criteria** (entity type + bundles, keys, paths, routes, or CSS
selectors) that decide where it applies. At runtime the module implements a batch of hooks
(`hook_entity_operation_alter`, `hook_menu_local_tasks_alter`, `hook_menu_local_actions_alter`,
`hook_views_ui_display_top_links_alter`, `hook_form_alter`) to stamp `use-ajax` +
`data-dialog-type`/`data-dialog-options` attributes onto the matching links, and via
`hook_page_attachments` publishes path/selector rules into `drupalSettings.admin_dialogs` where a
JS behavior (`assets/selector.js`) wires up matching links client-side. A global settings form
(`/admin/config/user-interface/dialogs/settings`) toggles convenience defaults: `delete_ops`,
`delete_buttons`, `other_buttons`, and a submit `submit_spinner`. It ships ~40 ready-made Dialog
configs (in `config/optional`) for core and popular contrib admin pages. Everything is gated by a
single `administer dialogs` permission; there are no Drush commands. Clear caches after changing
dialog configs.

---

- Make entity Delete confirmation open in a modal instead of a separate page.
- Open Edit/Delete operation links from admin lists as off-canvas dialogs.
- Turn local task tabs (Edit, Manage fields) into dialogs.
- Make local action links (e.g. "Add") open in a modal.
- Configure a specific admin path to always open in a dialog.
- Target arbitrary links by CSS selector and open them in a dialog.
- Set a per-dialog width and a title override.
- Choose modal vs off-canvas rendering per dialog configuration.
- Group related dialog configs under a Dialog Group for organization.
- Scope a dialog to a specific entity type and bundles via selection criteria.
- Enable the built-in configs for core admin pages (menus, fields, image styles, etc.).
- Enable bundled configs for contrib modules (Pathauto, Redirect, Linkit, Media, and more).
- Add modal delete buttons on content forms via the global `delete_buttons` toggle.
- Make Views UI Delete/Duplicate top links open in modals.
- Show a loading spinner on admin form submit buttons (`submit_spinner`).
- Reduce full page reloads across the admin toolbar workflow.
- Pair with Admin Toolbar for a faster editorial admin experience.
- Provide off-canvas editing of menu links from the menu admin screen.
- Add dialog behavior to your own module's admin links by shipping an `admin_dialog` config.
- Export dialog configurations to keep the admin UX consistent across environments.
- Disable delete-operation dialogs globally with the `delete_ops` toggle.
- Limit dialogs to certain routes using the route selection criteria.
