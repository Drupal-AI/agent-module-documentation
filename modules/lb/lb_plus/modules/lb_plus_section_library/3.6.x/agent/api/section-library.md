<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_plus_section_library — save & place templates

Bridges contrib **Section Library** into the LB+ editing UI. Templates are stored as
`section_library_template` entities (owned by the `section_library` module); this submodule only adds
the save entry point and the place-back flow inside LB+.

## Save a section / page → template
- The **Section Library tool** (`Plugin/Tool/SectionLibrary`, id `section_library`, hot key `s`) adds a
  "Save to Section Library" button to the global top bar, linking to core
  `section_library.add_template_to_library` (opened as an AJAX dialog).
- `Routing\LBPSLRouteSubscriber::alterRoutes()` re-points that route's `_form` to
  `Form\AddTemplateForm` (extends `section_library`'s `AddTemplateToLibraryForm`) so a successful save
  also rebuilds the LB+ left sidebar (`rebuildLeftSidebar($response, 'section_library')`).
- Per-section save: `EventSubscriber\SectionToolIndicators` listens to lb_plus's
  `SectionToolIndicatorEvent` and injects a `section_library.add_section_to_library` link (keyed by
  section UUID/delta) into the tool indicators.
- `hook_ENTITY_TYPE_presave` (`lb_plus_section_library_section_library_template_presave`) — on a new
  template, removes and re-inserts section 0 with a freshly generated `lb_plus/uuid` third-party
  setting so a placed copy never re-uses the source UUID.

## Place a template → route `lb_plus_section_library.place_template`
Path: `/lb-plus-section-library/place-template/{section_library_template}/{section_storage_type}/{section_storage}`.
Requirement: **`_layout_builder_access: 'view'`** (same gate as every LB+ editing route; authority is
the target section storage's layout access). `section_storage` resolves from the layout tempstore.

`Controller\PlaceTemplate::__invoke()`:
1. Wraps the storage: `NestedAwareSectionStorage::wrap($section_storage)`.
2. Reads query params `section` (reference section UUID), `precedingSection` (or `last`),
   `layoutBlockUuid`, and picks the target section list via `getSectionList()` (nested-aware, falls
   back to root storage).
3. Deep-clones each section of the template (`cloneNestedSections()`), recursively cloning nested
   Layout-Block `block_content` and re-serialising it, and assigns every cloned section a new
   `lb_plus/uuid` (uses `section_library\DeepCloningTrait::cloneAndReplaceSectionComponents`).
4. Inserts the clones, `bubbleChangesToRoot()`, saves to the layout tempstore, and returns a
   `rebuildLayout()` AjaxResponse scoped to the right nested layout block.
`EventSubscriber\ShouldEditMode` stops `ShouldNotEditModeEvent` on this route so the placed markup is
rendered in Edit Mode.

## Palette & template management (`Plugin/Sidebar/SectionLibrary`)
`build()` loads `SectionLibraryTemplate::loadMultiple()` and renders each as a draggable block with its
library image. Edit and Delete context links are added **only** when the current user passes the
template's own entity access: `if ($template->access('update'))` / `if ($template->access('delete'))`.
They open core `entity.section_library_template.edit_form` / `.delete_form` as modals, passing the
`section_storage` in the `destination`/query so the sidebar can rebuild afterward
(`Form\UpdateSidebarFormAlter`). Template create/edit/delete authorization is therefore governed by the
`section_library` module's own permissions and access handlers, not by this submodule.
