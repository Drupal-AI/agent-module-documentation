<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DAB component management — routes, controllers, forms, services & access

All UI lives under `/admin/dab/components`. Component discovery is core SDC: everything reads
`plugin.manager.sdc` → `getAllComponents()` and each component's `getPluginDefinition()`.

## Permissions (`dab.permissions.yml`)
`access dab components`, `administer dab components`, `administer dab configuration` — all
`restrict access: true`. Only the first two are actually referenced by routes/access logic.

## Routes (`dab.routing.yml`)
| Route | Path | Handler | Requirement |
|---|---|---|---|
| `dab.menu` | `admin/dab/components` | `DabComponentListController::build` | `_permission: access dab components` |
| `dab.component_type_list` | `/admin/dab/components/{component_type}` | `DabComponentListController::build` | `_permission: access dab components` |
| `dab.component` | `/admin/dab/components/{component_type}/{provider}/{machine_name}` | `DabComponentController::build` | `_permission: access dab components` |
| `dab.component_embed` | `…/{…}/embed` | `DabComponentController::embed` | `_permission: access dab components` |
| `dab.component_documentation` | `…/{…}/documentation` | `DabComponentController::documentation` | `_permission: access dab components` |
| `dab.add_component` | `/admin/dab/components/add` | `AddComponentForm` | `_crud_component_access_check: 'TRUE'` |
| `dab.edit_component` | `…/{…}/edit` | `AddComponentForm` | `_crud_component_access_check: 'TRUE'` |
| `dab.duplicate_component` | `…/{…}/duplicate` | `ConfirmationComponentForm` (`action: duplicate`) | `_permission: administer dab components` |
| `dab.delete_component` | `…/{…}/delete` | `ConfirmationComponentForm` (`action: delete`) | `_crud_component_access_check: 'TRUE'` |
| `dab.components_types_configuration` | `/admin/dab/components/settings` | `ConfigureComponentsTypesForm` | `_permission: administer dab components` |

Local tasks (`dab.links.task.yml`) attach View/Documentation/Edit/Duplicate/Delete tabs to `dab.component`
and Components/Add/Settings tabs to `dab.component_type_list`.

## Access check — `CrudComponentAccessCheck` (`src/Access/CrudComponentAccessCheck.php`)
Registered as `dab.crud_component_access_check` with tag `access_check, applies_to: _crud_component_access_check`.
The `_crud_component_access_check` routes are the create/edit/delete operations. The check keys off the
`administer dab components` permission and additionally treats components whose `path` matches the
core/contrib regex `((core)+\/(modules|themes))|((modules|themes)\/(contrib)+)` as read-only
(`forbidden()`), so bundled core/contrib SDCs cannot be modified through the UI.

## Controllers
- **`DabComponentListController`** (`src/Controller/…`): `build()` iterates all SDCs, computes `group`
  (`Html::getId()` of the plugin `group`, default `other`) and `origin` (custom/contrib/core via `preg_match`
  on the plugin `path`), builds per-group link lists, applies `isComponentExcluded()` (group + query filters
  `filter`/`extension_type`/`origin`), and renders `#theme => 'dab_component_list'` with a `ComponentFilterForm`.
- **`DabComponentController`** (`src/Controller/…`):
  - `build()` → render array `#theme => 'dab_renderer'` with the embed iframe URL, a `CacheClearForm`
    reload button, and responsive/template/version selects; `#cache max-age: 0`.
  - `embed()` → returns a raw `Response` of `templates/embed.html.twig` rendered with `twig->renderInline()`,
    injecting the component's CSS/JS (from its library plus `ComponentFileManager::getLibrariesFilesFromExtension()`)
    and the selected example "version" data. Throws `NotFoundHttpException` for unknown component/provider.
  - `documentation()` → converts the plugin's `documentation` string to HTML via `MarkdownService`.

## Forms
- **`AddComponentForm`** (create & edit; `use DabComponentTrait`): fields name, machine_name
  (`#type machine_name`, validated `^[a-z]+(?:_[a-z]+)*$`), group (from settings), description, provider
  (custom modules/themes only via `getExtensionsOptions()`), and add/remove JS/CSS checkboxes. `create` path
  calls `ComponentFileManager::createComponentFolder/createComponentFile/createReadmeFile/createTwigFile` and
  optional `createJsFile`/`createCssFile`; `edit` path loads+updates the `.component.yml`, adds/deletes assets
  and `moveComponentFolder()` on rename. `submitForm()` calls `drupal_flush_all_caches()` then redirects to
  the component view.
- **`ConfirmationComponentForm`** (delete/duplicate; `ConfirmFormBase`): validates `action ∈ {delete,duplicate}`,
  deletes via `fileSystem->deleteRecursive($path)` or duplicates via `ComponentFileManager::duplicateComponent()`
  (writes a `replaces:` key into the copy's `.component.yml`), then `drupal_flush_all_caches()`.
- **`ComponentFilterForm`**: search + extension_type + origin selects; AJAX `clearFilter` / submit redirect
  carrying the filters as route params.
- **`CacheClearForm`**: `↻` submit that clears JS/CSS collection optimizers, resets the asset query string and
  `twig->invalidate()`.

## Services / helpers
- **`ComponentFileManager`** (`src/Service/…`): all filesystem work — builds
  `<providerPath>/components/<group>/<machine_name>` paths, scaffolds YAML/Twig/README/JS/CSS, loads/saves the
  discovered `.component.yml` (`_discovered_file_path`), deletes single asset files, duplicates and moves folders
  (`RecursiveDirectoryIterator` + `file_system` copy/move), and flattens provider/base-theme library files for
  the embed preview.
- **`MarkdownService`** (`src/Service/…`): league/commonmark converter (`CommonMarkCoreExtension` + `TableExtension`).
- **`DabComponentTrait`** (`src/Traits/…`): `getComponentData()` groups SDCs by provider for a machine name,
  `getComponentVersions()` derives preview "versions" from prop/slot `examples`, and builds the
  template/provider/version selects and the custom-only extension options.
- **`AtomicComponentMenuLinkDeriver`** (`src/Plugin/Derivative/…`): derives menu links per group and per component
  (View + Edit/Delete/Duplicate) under the `dab.menu` tree.

## Operating notes
- CRUD only affects **custom** modules/themes; core/contrib components are view-only by design.
- New component provider options come from `getExtensionsOptions()` which lists only extensions whose path
  matches `^(modules|themes)/custom`.
- The site codebase must be writable for scaffolding to succeed; this is a development-time tool.
