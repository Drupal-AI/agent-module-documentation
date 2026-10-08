# Routes, controller, form and UI integration (API)

Two routes, both bound to a Layout Builder tempstore section storage
(`options.parameters.section_storage.layout_builder_tempstore: TRUE`). Layout changes are staged in
tempstore and only become permanent on **Save layout** — the exception is the inline-block copies,
which are written to the database as new `block_content` entities the moment you clone.

## Routes

| Route | Path | Handler | Access requirement |
|---|---|---|---|
| `layout_builder_section_block_duplicate.clone_section` | `/layout-builder-clone/clone/{section_storage_type}/{section_storage}/{delta}` | controller `CloneSectionController::clone` | `_permission: 'administer node layout'` |
| `layout_builder_section_block_duplicate.clone_block` | `/layout-builder-clone/clone-block/{section_storage_type}/{section_storage}/{delta}/{region}/{uuid}` | form `CloneBlockForm` (`_title_callback` `CloneBlockForm::title`, `_admin_route: TRUE`) | `_layout_builder_access: 'view'` |

The block route's `_layout_builder_access: 'view'` is the identical requirement core Layout Builder
places on its own `layout_builder.update_block`, `layout_builder.remove_block`,
`layout_builder.move_block` and `layout_builder.configure_section` routes. It runs through
`Drupal\layout_builder\Access\LayoutBuilderAccessCheck`, which calls
`$section_storage->access('view', $account)` and — for section storages that do not set
`handles_permission_check` — additionally requires the global `configure any layout` permission. For
the standard override storage (`OverridesSectionStorage`, which *does* handle its own check) that
resolves to the per-entity/bundle layout-edit permissions: `configure any layout`,
`configure all <bundle> <entity_type> layout overrides`, or `configure editable <bundle>
<entity_type> layout overrides` **and** update access to the entity. So block cloning is available to
exactly the users who may edit that layout.

Behavior note on the section route: `administer node layout` is not a permission defined by core
Layout Builder or by this module (core's Layout Builder permissions are `configure any layout`,
`create and edit custom blocks`, and the dynamic `configure … layout overrides` set). Unless some
other contrib/custom module defines and grants `administer node layout`, only user 1 — who bypasses
permission checks — satisfies it, so on a stock site the "Clone section" link is effectively
superuser-only even though it renders for anyone who is editing the layout.

## `CloneSectionController::clone(SectionStorageInterface $section_storage, $delta)`

`src/Controller/CloneSectionController.php`. Uses `LayoutRebuildTrait`. Reads
`getSection($delta)` (errors + redirects to `<current>` if missing), builds a new `Section` with the
same layout id and layout settings, then copies each component. For components whose
`configuration['provider'] === 'layout_builder'` it mints a new component `uuid`, and if the component
carries a `block_serialized` inline block it `unserialize()`s it, `createDuplicate()`s it,
`enforceIsNew()`, assigns a fresh uuid and **`save()`s** it (a new `block_content` row), then
re-serializes and records the new `block_revision_id`. The clone is inserted at `delta + 1`, written
with `layout_builder.tempstore_repository`, and the method returns `rebuildLayout($section_storage)`
(an Ajax response). Injected services: `layout_builder.tempstore_repository`, `uuid`.

## `CloneBlockForm` — form id `layout_builder_section_block_duplicate_block_clone`

`src/Form/CloneBlockForm.php`, extends `FormBase`, implements `WorkspaceDynamicSafeFormInterface`
(traits: `WorkspaceSafeFormTrait`, `LayoutRebuildTrait`, `AjaxFormHelperTrait`,
`LayoutBuilderContextTrait`, `LayoutBuilderHighlightTrait`). `buildForm` throws
`\InvalidArgumentException('CloneBlockForm requires all parameters.')` if any of
`section_storage / delta / region / uuid` is null. The form presents a **Region** select (every
section × region, Ajax-refreshed via `::getComponentsWrapper`) and a draggable weight table of the
blocks in the selected region.

`submitForm` copies the chosen component:

- For `provider === 'layout_builder'` components it duplicates the underlying content block. If the
  component has a `block_uuid`, it loads the `block_content` by uuid
  (`entity_type.manager` → `loadByProperties(['uuid' => …])`) and `createDuplicate()` +
  `enforceIsNew()` + new uuid + `setNewRevision(TRUE)` + clear `revision_id`/`id` + `save()`. If it
  has a `block_serialized`, it `unserialize()`s, verifies `getEntityTypeId() === 'block_content'`,
  then duplicates the same way and re-serializes. It always mints a new component `uuid`.
- Builds a new `SectionComponent($new_uuid, $plugin, $configuration)`, sets region and the original
  weight, `insertComponent(0, …)` into the target section, applies weights from the draggable table,
  and writes tempstore. `successfulAjaxSubmit` calls `rebuildAndClose()` to close the off-canvas
  dialog.

Injected services: `layout_builder.tempstore_repository`, `uuid`, `entity_type.manager`.
`CloneBlockForm::title()` is the route title callback and renders `Clone the @block_label block`.

## How the clone links appear

- **Section link** — `layout_builder_section_block_duplicate.module` implements
  `hook_element_info_alter` (a thin wrapper delegating to the `…hook_manager` service /
  `BlockDuplicateHooks::alterElementInfo`), which appends `LayoutBuilderAlter::addCustomLink` to the
  `layout_builder` element's `#pre_render`. That callback (declared in `trustedCallbacks()`) walks
  each section's render array and, where a `configure` control exists, injects a `#type => link`
  titled `Clone section @num` pointing at the `clone_section` route, carrying the classes
  `use-ajax layout-builder__link` plus `data-dialog-renderer: off_canvas`. It selects
  `layout-builder__link--clone-gin` or `…--clone-claro` depending on whether `gin_lb` is installed.
- **Block link** — the contextual link `layout_builder_section_block_duplicate.clone_block` (group
  `layout_builder_block`) opens the `clone_block` route in an off-canvas dialog.
- **CSS** — `hook_page_attachments` attaches
  `layout_builder_section_block_duplicate/layout_builder_section_block_duplicate_css`.
