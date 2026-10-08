<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `document_source` plugin type

Documents are handled through a pluggable backend called a **document source**. Each `oi_document`
stores a `source_type` (plugin id) and, for external sources, a `source_url`. Preview, download
URL, metadata, file icon and the add/edit form fields all come from the source plugin.

## Plugin infrastructure

- **Manager**: `DocumentSourceManager` (`src/DocumentSourceManager.php`), service
  `plugin.manager.document_source`. Extends `DefaultPluginManager`, directory
  `Plugin/DocumentSource`, interface `DocumentSourceInterface`, annotation
  `@DocumentSource`, alter hook `document_source_info`, cache bin `cache.discovery`.
  - `getDefinitions()` — all discovered sources.
  - `getEnabledDefinitions()` — filtered to `openintranet_documents.settings:enabled_sources`
    (default `['local_file']`).
  - `getDefaultSourceId()` — `settings:default_source` (default `local_file`).
  - `createInstanceById($id, $config = [])`.
- **Annotation**: `@DocumentSource` (`src/Annotation/DocumentSource.php`) — `id`, `label`,
  `description`, `icon` (Bootstrap-icon class, default `bi-file-earmark-plus`).
- **Interface**: `DocumentSourceInterface` (`src/Plugin/DocumentSource/DocumentSourceInterface.php`)
  extends `PluginInspectionInterface`, `ConfigurableInterface`. Methods:
  `getLabel`, `getDescription`, `getIcon`, `buildPreview`, `getDownloadUrl`, `getFileMetadata`,
  `getFileIcon`, `buildSourceForm`, `validateSourceForm`, `submitSourceForm`.
- **Base**: `DocumentSourceBase` (`src/Plugin/DocumentSource/DocumentSourceBase.php`) —
  supplies label/description/icon getters and no-op validate/submit; subclasses override the rest.

## Shipped sources (`src/Plugin/DocumentSource/`)

| id | label | icon | Kind |
|---|---|---|---|
| `local_file` | Upload Local File | `bi-file-earmark-arrow-up` | server-stored managed file |
| `google_drive` | Add from Google Drive | `bi-google` | external URL embed |
| `dropbox` | Add from Dropbox | `bi-dropbox` | external URL embed |
| `onedrive` | Add from OneDrive | (see class) | external URL embed |
| `box` | Add from Box | (see class) | external URL embed |

### `local_file` (`LocalFile.php`)

- `buildSourceForm()` — a `managed_file` element with `#upload_validators` `FileExtension`
  (`pdf doc docx xls xlsx ppt pptx txt rtf odt ods odp jpg jpeg png gif`) and
  `FileSizeLimit` (50 MB), `#upload_location => 'public://documents/' . date('Y') . '/' . date('m')`.
- `submitSourceForm()` — loads the uploaded file, marks it permanent, sets it on the document,
  clears `source_url`.
- `getDownloadUrl()` — a URL to the `openintranet_documents.download` route (access-checked stream).
- `buildPreview()` — inline `<img>` for images, `<iframe>` for PDFs, otherwise a "no preview"
  message. `getFileIcon()` maps extensions to Bootstrap file icons.

### External sources (`GoogleDrive`, `Dropbox`, `OneDrive`, `BoxCom`)

Each renders a single `url` form element, validates the URL against provider-specific host
patterns (e.g. GoogleDrive accepts only `drive.google.com/file/d/...` or
`docs.google.com/{document,spreadsheets,presentation}/d/...`; Dropbox only `dropbox.com/s/` or
`/scl/`), and on submit stores it in `source_url` and clears the `file` field. `buildPreview()`
returns a client-side `<iframe>` pointing at a provider embed URL derived from the stored URL;
`getDownloadUrl()` returns a provider download/redirect URL. **No server-side fetch of the URL is
performed** — the browser loads the embed/redirect.

## The document form wiring (`OiDocumentForm` / `OiDocumentModalForm`)

- `buildForm()` removes the raw `file` / `source_url` / `source_type` widgets and instead: shows a
  **source-type `select`** (only when >1 source is enabled, else a hidden field) with an AJAX
  callback (`ajaxSourceTypeCallback`) that re-renders the `source_fields` container; then calls the
  chosen plugin's `buildSourceForm()` into `source_fields` (`#tree => TRUE`). Route params
  `source_type` and `folder` pre-seed the selected source and destination folder.
- `validateForm()` and `save()` delegate to the plugin's `validateSourceForm()` /
  `submitSourceForm()`. After save the user is redirected to the containing folder (or `/documents`).
- `copyFormValuesToEntity()` skips `file`, `source_url`, `source_type` (plugin-managed).

## Adding a custom source

Create a class in `src/Plugin/DocumentSource/` (in any module) extending `DocumentSourceBase`
with a `@DocumentSource` annotation, implement `buildSourceForm/validateSourceForm/submitSourceForm`
plus `buildPreview/getDownloadUrl/getFileMetadata`, then enable it at
`/admin/config/content/documents`. See [../config/settings.md](../config/settings.md).
