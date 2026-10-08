Layout Paragraphs adds a drag-and-drop field widget and formatter that let editors arrange Paragraphs inside layouts (from core Layout Discovery) directly on the content form.

---

Layout Paragraphs turns an ordinary `entity_reference_revisions` paragraphs field into a visual, drag-and-drop page builder. It ships a `layout_paragraphs` field widget (an inline builder with a "Choose a component" dialog, live previews, and reordering) plus two formatters — `layout_paragraphs` (renders paragraphs wrapped in their layouts) and `layout_paragraphs_builder` (an experimental front-end editing formatter). Layouts come from Drupal core's Layout Discovery API: any paragraph type that enables the `layout_paragraphs` Paragraphs **Behavior** plugin becomes a "section" whose editor picks one of the configured `available_layouts` and fills its regions with other paragraphs. Nesting is supported up to a configurable `nesting_depth`, and `require_layouts` can force all top-level components to live inside a section. In-progress edits are held in a private tempstore (`layout_paragraphs.tempstore_repository`) and manipulated through a `LayoutParagraphsLayout` domain object and its AJAX builder controllers/forms. As of 2.x the module removed its custom hooks in favor of native hooks plus events: `LayoutParagraphsAllowedTypesEvent` (restrict which components are allowed in a given region/section), `LayoutParagraphsComponentDefaultsEvent` (change the type/default values of a new component), and `LayoutParagraphsUpdateLayoutEvent` (control when the whole builder refreshes). Two submodules extend it: **Layout Paragraphs Library** integrates the Paragraphs Library ("Promote to library" / "Unlink from library"), and **Layout Paragraphs Permissions** adds granular reorder/duplicate/plugin-config permissions.

---

- Give editors a drag-and-drop layout builder inside a paragraphs field on a node or other entity.
- Arrange paragraph components into columns using core Layout Discovery layouts (one/two/three column, etc.).
- Add the `layout_paragraphs` widget to a paragraph reference field via the Manage form display screen.
- Render the arranged layout on the front end with the `layout_paragraphs` field formatter.
- Enable front-end (in-place) editing of a layout with the experimental `layout_paragraphs_builder` formatter.
- Turn a paragraph type into a layout "section" by enabling its `layout_paragraphs` Behavior plugin.
- Restrict which layouts a section paragraph type may use via the behavior's `available_layouts` setting.
- Nest sections inside sections up to a configured maximum nesting depth.
- Require every top-level component to be placed inside a layout section (`require_layouts`).
- Choose which view mode is used for component previews vs. front-end rendering.
- Use a dedicated form display mode for editing components in the builder dialog.
- Show or hide paragraph-type and layout labels in the builder via the module settings form.
- Restrict the paragraph types allowed in a specific region by subscribing to `LayoutParagraphsAllowedTypesEvent`.
- Change the default paragraph type or preset field values for newly inserted components via `LayoutParagraphsComponentDefaultsEvent`.
- Force a full builder refresh after an operation by setting `needsRefresh` in `LayoutParagraphsUpdateLayoutEvent`.
- Duplicate an existing component (and its children) in place from the builder UI.
- Reorder components by dragging them between regions and sections.
- Promote a component to the Paragraphs Library so it can be reused elsewhere (library submodule).
- Unlink a library-referenced paragraph back into an editable local copy (library submodule).
- Grant only certain roles permission to reorder or duplicate components (permissions submodule).
- Gate access to the layout plugin configuration form behind a permission (permissions submodule).
- Configure the builder modal dialog width/height/autoresize via `layout_paragraphs.modal_settings`.
- Manipulate a layout programmatically (insert, delete, reorder, duplicate) through the `LayoutParagraphsLayout` object.
- Alter the component edit form with `hook_form_layout_paragraphs_component_form_alter()`.
- Preprocess the builder or its per-component controls via `hook_preprocess_layout_paragraphs_builder[_controls]()`.
- Adjust a component's build array in `hook_entity_view_alter()` by checking `$build['#layout_paragraphs_component']`.
- Build structured landing pages without granting site builders access to core Layout Builder.
- Replace older Paragraphs "classic" editing with a modern drag-and-drop experience.
