# Configure dialogs

Admin at *Configuration → User interface → Dialog Groups*
(`/admin/config/user-interface/dialogs`). All routes require `administer dialogs`. Clear cache
after editing dialog configs (they alter cached render arrays / attachments).

## Config entities

- **Dialog Group** (`admin_dialog_group`) — a container/label for organizing dialogs. Fields:
  `id`, `label`, `description`. Managed at the base route; a group holds a list of dialogs at
  `/admin/config/user-interface/dialogs/manage/{group}/dialogs`.
- **Dialog** (`admin_dialog`) — one rule. Add/edit form `AdminDialogEditForm`. Fields (schema
  `admin_dialogs.admin_dialog.*`):

| Field | Values | Purpose |
|---|---|---|
| `type` | `ops`, `tasks`, `actions`, `paths`, `selectors` | Which class of UI element to target. |
| `dialog_type` | `modal`, `off_canvas` | Dialog presentation (off-canvas maps to `data-dialog-renderer: off_canvas`). |
| `dialog_width` | string (px) | Dialog width. |
| `dialog_title_override` | string | Replaces the default dialog title. |
| `dialog_group` | group id | Owning Dialog Group. |
| `status` | bool | Enabled. |
| `selection_criteria` | mapping | Where the rule applies: `entity_type`, `key`, `bundles[]`, `paths[]`, `routes[]`, `selectors[]`. |

## How each type is applied at runtime (`AdminDialogsModule`)

- `ops` → `hook_entity_operation_alter`: matching entity operation links get `use-ajax` +
  `data-dialog-type`/`data-dialog-options`. Matching uses `checkEntityTypeMatch()`
  (entity_type + optional bundles) and the operation `key`.
- `tasks` → `hook_menu_local_tasks_alter`; `actions` → `hook_menu_local_actions_alter`;
  Views UI top links (Delete/Duplicate) → `hook_views_ui_display_top_links_alter` (gated by the
  `other_buttons` setting).
- `paths` / `selectors` → `hook_page_attachments`: for enabled dialogs of these types the module
  publishes `drupalSettings.admin_dialogs.paths` and `.selectors` (each mapping →
  attributes from `getAttributes()`) and attaches `admin_dialogs/admin_dialogs.selector`
  (`assets/selector.js`) which wires the links client-side.

`getAttributes()` builds `['class' => ['use-ajax'], 'data-dialog-type' => 'modal',
'data-dialog-options' => {width,title?}]`, switching to `data-dialog-type: dialog` +
`data-dialog-renderer: off_canvas` for off-canvas.

## Global settings form

`/admin/config/user-interface/dialogs/settings` (`AdminDialogSettingsForm`, config
`admin_dialogs.settings`, schema `admin_dialogs.schema.yml`):

| Key | Default | Effect |
|---|---|---|
| `delete_ops` | `true` | Allow dialogs on delete operation links. |
| `delete_buttons` | `true` | Turn form `actions.delete` (and `delete_translation` when `other_buttons`) into modal buttons via `hook_form_alter`. |
| `other_buttons` | `true` | Enable dialogs on additional buttons / Views UI top links. |
| `submit_spinner` | `false` | Attach a spinner to admin form submit buttons (`admin_dialogs/admin_dialogs.spinner`). |

## Bundled configs

~40 ready-made `admin_dialog`/`admin_dialog_group` configs ship in `config/optional/` (core admin
pages plus Pathauto, Redirect, Linkit, Media, Aggregator, CAPTCHA, and more). They install when
their target modules are present. Add your own by shipping an `admin_dialogs.admin_dialog.*` config
in your module.
