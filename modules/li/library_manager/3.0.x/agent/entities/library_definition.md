<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `library_definition` config entity

`Drupal\library_manager\Entity\LibraryDefinition` (interface `LibraryDefinitionInterface`) is the
one entity the module provides — a `ConfigEntityBase` implementing
`EntityWithPluginCollectionInterface`. Config prefix `library_manager.library_definition.`,
`admin_permission = "administer libraries"`, entity keys `id` + `uuid`. Schema:
`config/schema/library_manager.schema.yml`.

## Stored properties (`config_export`)

`id`, `status` (enabled), `target` (the `extension/library` this definition overrides, or empty
for a brand-new library), `remote` (project URL), `version`, `license` (`{name, url,
gpl-compatible}`), `js` (list), `css` (list), `library_dependencies` (list of `extension/library`
strings), `load` (auto-attach a new library by visibility), `override_by_visibility`, and
`visibility` (condition-plugin configuration).

Each **JS** file entry: `file_name`, `code`, `preprocess`, `minified`, `typemodulecheck`
(→ attribute `type="module"`), `nomodulecheck` (→ attribute `nomodule`), `attributes`, `weight`
(−10…0), `external` (bool), `url`, `code_type` (`code` | `file_upload`), `file_upload` (managed
file id), `header` (load in `<head>`). Each **CSS** file entry is the same minus the module
attributes, plus `group` (`base` | `layout` | `component` | `state` | `theme`).

## Forms (declared in the entity annotation `handlers`)

| Op | Class | Route |
|---|---|---|
| add / edit | `LibraryDefinitionForm` | `entity.library_definition.add_form` / `edit_form` |
| delete | `LibraryDefinitionDeleteForm` | `.delete_form` |
| duplicate | `LibraryDefinitionDuplicateForm` | `.duplicate_form` |
| build (seed) | `LibraryDefinitionBuildForm` | `library_manager.library_build` |
| add/edit/delete JS | `LibraryDefinitionJsForm` / `…JsDeleteForm` | `.add_js_form` / `edit_js_form` / `delete_js_form` |
| add/edit/delete CSS | `LibraryDefinitionCssForm` / `…CssDeleteForm` | `.add_css_form` / `edit_css_form` / `delete_css_form` |

List builder: `LibraryDefinitionListBuilder` (route `entity.library_definition.collection`,
`/admin/structure/library/definition`) — columns machine name, New/Override, version, load,
override-by-visibility, enabled, plus a Duplicate operation.

### `LibraryDefinitionForm` (main add/edit)

Top-level fields: machine `id`; `mode` radios (**Register new library** vs **Override existing
library**); `target` (autocomplete against `library_manager.library_autocomplete`, shown only in
override mode); `remote` URL; required `version`; a `license` fieldset (name with a `datalist` of
GPL-2.0/MIT/Public Domain, url, gpl-compatible). JS and CSS are shown as **tables** of the current
files with Edit/Delete operations and an "Add JS/CSS file" button (button only appears once the
entity is saved). A `dependencies` fieldset builds an AJAX-growable list of library autocomplete
fields. `override_by_visibility` (override mode) and `load` (new mode) checkboxes; a
`status` "Enabled" checkbox; and a **Visibility** vertical-tabs section built from every condition
plugin returned by `conditionManager->getFilteredDefinitions('library_manager')`
(`buildVisibilityInterface()`), validated/submitted in `validateVisibility()` /`submitForm()`.
Saving redirects to the definition collection.

### Per-file JS / CSS forms

`LibraryDefinitionJsForm` and `LibraryDefinitionCssForm` (both extend `EntityForm`) edit a single
file entry keyed by the `file_id` route param (`is_new` marks the add route). Fields: `external`
checkbox → shows `url`; otherwise a `code_type` radio chooses **Code** (a `textarea` with a
`#codemirror` mode of `javascript`/`css`, plus `file_name`) or **File Upload** (a `managed_file`
with `#upload_validators` restricting extensions to `js`/`css`, `#upload_location`
`public://libraries/file_upload`). JS adds `header`, `preprocess`, `minified`, `typemodulecheck`,
`nomodulecheck`, `weight` (select −10…0); CSS adds `group` and a `weight` element.
`validateForm()` requires the code-mode `file_name` to match `^\w[\w\-\.\/]*\.(js|css)$` and reject
`..`. `save()` assigns the next integer `file_id` (`max(ids)+1`), marks any uploaded managed file
permanent, folds `typemodulecheck`/`nomodulecheck` into an `attributes` array, writes the entry back
into the entity's `js`/`css` array, and redirects to the edit form.

### Build / duplicate

- `LibraryDefinitionBuildForm` (route `.../{extension}/{library}/build`) seeds a new definition
  from an existing library: `updateLibraryDefinition()` reads
  `libraryDiscovery->exportLibraryByName()`, sets `target`, `remote`, `version`
  (`processLibraryVersion()`), `license`, dependencies, and converts each source JS/CSS file into a
  definition entry via `createFileDefinitions()` (inlining local file contents with
  `file_get_contents(DRUPAL_ROOT.'/'.$local_path)`, marking `//host` and `scheme://` paths
  external).
- `LibraryDefinitionDuplicateForm` calls `createDuplicate()` with a new machine id.

## Entity lifecycle (`LibraryDefinition`)

- `getVisibility()` / `getVisibilityConditions()` / `setVisibilityConfig()` manage a
  `ConditionPluginCollection` (plugin manager `plugin.manager.condition`); `getPluginCollections()`
  exposes `visibility` so config dependencies track the condition plugins.
- `postSave()` reconciles `file.usage` for uploaded managed files (add for new upload ids, delete
  for removed ones), then clears the core `library.discovery` cache, resets the
  `library_manager_build_libraries` static, and re-primes the library by name.
- `postDelete()` recursively deletes the on-disk directory `libraries_path/{id}` for each removed
  definition.

## Registering & attaching (summary)

Enabled definitions become libraries under the `library_manager/{id}` namespace via
`hook_library_info_build()`; override targets are applied via `hook_library_info_alter()`; new
libraries with `load = TRUE` (and override-by-visibility overrides) auto-attach through
`hook_page_attachments()` when their visibility conditions pass. Full mechanics in
[../api/discovery-and-hooks.md](../api/discovery-and-hooks.md).
