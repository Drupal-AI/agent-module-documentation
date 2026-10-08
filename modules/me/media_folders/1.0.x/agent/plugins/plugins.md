<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins (widget, formatter, CKEditor, action)

Media Folders defines no plugin *type*; it ships these plugin *instances*.

## Field widget — `media_folders_widget`

`src/Plugin/Field/FieldWidget/MediaFoldersWidget.php` (`#[FieldWidget(id: 'media_folders_widget',
field_types: ['entity_reference'])]`). Use on an `entity_reference` field that targets Media (Manage
form display → Widget → "Media Folders"). Lets editors pick media through the folder browser; renders
selected items with label/access checks (`view label`).

## Field formatter — `media_folders`

`src/Plugin/Field/FieldFormatter/MediaFoldersFormatter.php` (`#[FieldFormatter(id: 'media_folders',
field_types: ['entity_reference'])]`, extends core `ImageFormatter`). Displays an
entity-reference-to-media field via the module's rendering.

## CKEditor 5 plugin — Media Folders

`src/Plugin/CKEditor5Plugin/MediaFolders.php` (`@internal`, extends `CKEditor5PluginDefault`). Adds a
button/flow to embed media from folders into rich text. Globally toggled off by the
`media_folders.settings:disable_ckeditor` flag.

## Action — `AddToFolder` (derived)

`src/Plugin/Action/AddToFolder.php` (extends `MediaFoldersActionBase`, `deriver:
AddToFolderActionDeriver`). Derives one action per folder to bulk-file selected media; the optional
`system.action.media_add_to_folder_action` config makes the generic action available. Backed by
`MediaFoldersUiActions` (validation, file→bundle mapping, saving) and `MediaFoldersUiBuilder` (render +
access). Access to running it goes through `canEditMedia()` (see permissions doc).
