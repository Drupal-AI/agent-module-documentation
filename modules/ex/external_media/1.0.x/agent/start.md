<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Media (external_media) — agent index

Adds two Field API widgets (for core `file` and `image` fields) and a reusable
`external_media` form-element `#type` that let editors pick files from cloud
services — **Dropbox, Box, Google Drive, OneDrive** — instead of (or alongside)
a normal local upload. Each vendor's own JavaScript picker runs client-side; the
picked file's download URL is posted back and the server fetches it and saves it
as a managed `file` entity. Depends only on core `file`. Core requirement
`^10.6 || ^11.3 || ^12`. Configure at `/admin/config/media/external-media`
(`configure: external_media.settings`).

- **Turn services on/off, set button labels, enter per-service credentials** → [configure/settings.md](configure/settings.md)
- **Attach the widget to a File/Image field; per-field widget options** → [fields/widgets.md](fields/widgets.md)
- **Who may use each service (dynamic permissions)** → [permissions/permissions.md](permissions/permissions.md)
- **Add a new provider (the `ExternalMedia` plugin type)** → [plugins/external-media.md](plugins/external-media.md)
- **Hooks it implements + the alter hook for other modules** → [hooks/hooks.md](hooks/hooks.md)

## Key facts

- **Field widgets** (`src/Plugin/Field/FieldWidget/`):
  - `external_media_file_widget` — for `file` fields (extends core `FileWidget`).
  - `external_media_image_widget` — for `image` fields (extends the file widget; adds alt/title/preview).
- **Form element**: `#type => 'external_media'` (`src/Element/ExternalMediaFile.php`, extends core `ManagedFile`). Custom code can use it directly:
  `'#type' => \Drupal::moduleHandler()->moduleExists('external_media') ? 'external_media' : 'managed_file'`.
- **Plugin type** `ExternalMedia` (manager service `plugin.manager.external_media`, directory `Plugin/ExternalMedia/`, attribute `Drupal\external_media\Attribute\ExternalMedia`, legacy annotation `Drupal\external_media\Annotation\ExternalMedia`, interface `ExternalMediaInterface`, base `ExternalMediaBase`, alter hook `external_media_plugin_info`). Bundled providers: `dropbox_chooser`, `box_picker`, `google_drive`, `onedrive_picker`.
- **Permissions are generated, not declared.** `external_media.permissions.yml` only lists a `permission_callbacks` entry → `ExternalMediaController::permissions()`, which emits one `upload from <plugin_id>` permission per plugin **where `$plugin->classExists()` is TRUE**.
- **Settings live in State, not config.** The settings form is a plain `FormBase` that reads/writes `\Drupal::state()->get('external_media.info')` (per-plugin `enabled`, `button_label`, and credentials). There is **no config object and no config schema**; nothing is exported with the site config.
- **Services** (`external_media.services.yml`): `plugin.manager.external_media`, `external_media` (mime/extension helper `Drupal\external_media\ExternalMedia`), `paramconverter.external_media`, and the `Hook\ExternalMediaHooks` OOP hook class.
- **Routes** (`external_media.routing.yml`):

  | Route | Path | Requirement |
  |---|---|---|
  | `external_media.settings` | `/admin/config/media/external-media` | `_permission: administer site configuration` |
  | `external_media.redirect_callback` | `/external-media/redirect/{external_media}` | `_access: 'TRUE'` (OAuth/picker return leg; `{external_media}` is converted to a plugin instance by `paramconverter.external_media`) |

- **State keys**: `external_media.info` (settings). `hook_uninstall` deletes it plus the legacy `external_media_widget.info`.
- **Templates/libraries**: `external_media`, `external_media_element`, `external_media_dropdown` themes; libraries `external_media/external_media.core`, `external_media/external_media.form`, plus one per-provider library built dynamically in `hook_library_info_build`.
