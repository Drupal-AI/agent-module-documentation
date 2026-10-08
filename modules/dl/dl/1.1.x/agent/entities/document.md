<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `document` content entity

Defined in `src/Entity/Document.php` (`@ContentEntityType id = "document"`), base table
`document`, non-revisionable, non-translatable, `admin_permission = "administer document library"`.
Interface `src/Entity/DocumentInterface.php`. Uses `EntityChangedTrait` + `EntityOwnerTrait`.

## Fields

Base fields (`baseFieldDefinitions()`):
- `title` (string, required, max 255) — the entity label (`entity_keys.label = title`).
- `folder_id` (integer, default 0) — id of the owning row in `dl_folders`; **0 = root**. Not a
  Drupal entity reference — it points at the custom folder table.
- `downloads` (integer, read-only) — download counter, incremented by the download route.
- `status` (boolean, default TRUE) — published flag (`entity_keys.published`).
- `created` / `changed` — timestamps. Owner `uid` comes from `ownerBaseFieldDefinitions()`.

Configurable fields (shipped in `config/install/`, created for upgraders by `dl_update_9005`):
- `field_file` — **required** core File field. Settings: `uri_scheme: public`,
  `file_extensions: txt pdf doc docx xls xlsx ppt pptx odt ods odp rtf zip rar 7z tar gz`,
  `max_filesize: 50 MB`, `file_directory: documents/[date:custom:Y]-[date:custom:m]`.
- `field_description` (text_long), `field_version` (string, default `1.0`),
  `field_tags` (string, cardinality -1).

`preSave()` sets `created` on new entities, always bumps `changed`, and defaults the owner to the
current user. `postDelete()` deletes the referenced File entity (and thus the physical file) and
purges the document's rows from `dl_versions`, `dl_downloads` and `dl_favorites`.

## Routes (entity)

`DocumentHtmlRouteProvider extends AdminHtmlRouteProvider`:
- `entity.document.canonical` — `/documents/{document}` → overridden to
  `DocumentLibraryController::viewDocument` (adds version history, favorites, breadcrumbs).
  Requirement `_permission: access document library`; `viewDocument` additionally throws 404 for
  unpublished documents (published view is open to that permission).
- `entity.document.edit_form` `/documents/{document}/edit`, `entity.document.delete_form`
  `/documents/{document}/delete`, `entity.document.add_form` `/documents/add`,
  `entity.document.collection` `/admin/content/documents` — from the parent provider, gated by
  entity access (`update`/`delete`/`create`) below.
- `entity.document.settings` — `/admin/structure/document/settings`, the Field-UI base route
  (`field_ui_base_route`), form `DocumentSettingsForm`, permission `administer document library`.

Edit/add forms use `DocumentForm` (`src/Form/DocumentForm.php`, extends `ContentEntityForm`):
pre-fills `folder_id` from a `?folder=` query param on new entities and redirects to the canonical
route after save. Delete uses core `ContentEntityDeleteForm`. `hook_form_document_form_alter` in
`dl.module` turns `folder_id` into a hierarchical select via `_dl_get_folder_options()`.

## Access control (`src/DocumentAccessControlHandler.php`)

- **view**: published → `access document library`; unpublished → `administer document library`.
- **download**: published → `download documents`; unpublished → `administer document library`.
  (Note: the standalone `dl.document.download` route in `dl.routing.yml` enforces
  `download documents` via `_permission` and checks `status == 1` in the controller; it does not
  invoke this handler's `download` op.)
- **update**: allowed for `administer document library`; or `edit own documents` **and** owner;
  or `edit documents` (any). Otherwise neutral.
- **delete**: allowed for `administer document library`; or `delete own documents` **and** owner;
  or `delete documents` (any). Otherwise neutral.
- **create** (`checkCreateAccess`): `upload documents` or `administer document library`.

(`edit own documents` / `delete own documents` are referenced here but are **not** declared in
`dl.permissions.yml`; only `edit documents`, `delete documents`, and the `manage all documents`
override used by the controllers exist — the "own" branches are effectively inert.)

## Permissions (`dl.permissions.yml`, 12 total)

`access document library`, `upload documents`, `edit documents`, `delete documents`,
`download documents`, `administer document library` (restricted), `manage all documents`
(restricted), `create folders`, `edit folders`, `delete folders`, `manage all folders`
(restricted). Controllers gate ownership with `uid == currentUser` OR `manage all documents`
(documents) / `manage all folders` (folders).
