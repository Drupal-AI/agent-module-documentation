<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Intranet Documents (openintranet_documents) — agent index

Folder-based **document management** for the Open Intranet distribution. Provides two custom
content entities and a Bootstrap 5 browser at **`/documents`**. Version **1.0.0-alpha6**
(doc dir `1.x`). License GPL-2.0-or-later. Core `^10 || ^11`. Package *Open Intranet*.

**Depends on** core `file`, `user`, `views` and contrib **`alpine_js`**. No Drush, no submodules.

## What it provides

- **Entities** (both revisionable, publishable, owned):
  - `oi_document` (`src/Entity/OiDocument.php`) — fields `title`, `description`, `folder`
    (ref → `oi_folder`), `source_type`, `source_url`, `file` (core file field), `status`, `uid`,
    `created`, `changed`. Access handler `OiDocumentAccessControlHandler`.
  - `oi_folder` (`src/Entity/OiFolder.php`) — `name`, `description`, `parent` (self-ref for
    nesting). Access handler `OiFolderAccessControlHandler`. Its collection
    (`entity.oi_folder.collection`) is the module's `configure` link.
- **Plugin type `document_source`** (manager `DocumentSourceManager`, interface
  `DocumentSourceInterface`, base `DocumentSourceBase`, annotation `@DocumentSource`) — pluggable
  document backends: `local_file` (upload), `google_drive`, `dropbox`, `onedrive`, `box`
  (external URL embed). Each defines preview, download-URL, metadata, and add-form behaviour.
- **Services**: `openintranet_documents.folder_manager` (`OiFolderManager`),
  `openintranet_documents.document_manager` (`OiDocumentManager`),
  `plugin.manager.document_source`, `openintranet_documents.breadcrumb`.
- **Controllers/routes**: browser (`/documents`), folder view, document view (canonical),
  document download, search (`/documents/search`), plus entity add/edit/delete forms with
  full-page and AJAX-modal variants (all under `/documents/...`, front-theme).
- **Config**: single config object `openintranet_documents.settings` (enabled sources, default
  source, max file size). Admin form at `/admin/config/content/documents`
  (`administer oi_document`).
- **Permissions**: `openintranet_documents.permissions.yml` — per-entity view/create/edit/delete
  (+ download + revision ops) and two admin permissions.
- **Hooks**: `hook_theme` (4 templates), `hook_user_cancel` / `hook_user_predelete`
  (anonymize/delete a user's documents & folders).

## Solution docs

- Entities, routes, permissions & how access is enforced →
  [entities/documents-folders.md](entities/documents-folders.md)
- The `document_source` plugin type and the five shipped sources →
  [plugins/document-source.md](plugins/document-source.md)
- Settings config object, schema & admin form →
  [config/settings.md](config/settings.md)
