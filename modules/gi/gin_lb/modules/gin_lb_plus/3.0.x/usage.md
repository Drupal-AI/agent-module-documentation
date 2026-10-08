<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Layout Builder Plus is an opinionated add-on to gin_lb that reshapes Layout Builder's "Add block" and "Add section" pickers into tabbed, icon-driven off-canvas UIs and wires the Section Library into them, adding an "Add to library" button to the layout form.

---

The submodule sits on top of gin_lb (and requires it), field_group and section_library. Its core piece is a kernel `VIEW` event subscriber (`LayoutBuilderBrowserEventSubscriber`, weight 45) that rebuilds two controller results: on `layout_builder.choose_section` it wraps the layout list plus a new "Library" tab in `field_group` horizontal tabs and gives every section an icon (theme hook `gin_lb_plus_icon`); on `layout_builder.choose_block` it turns the block categories into horizontal tabs with per-block icons and strips the `layout-builder-browser` classes. The "Library" tab lists every `section_library_template` entity via `SectionLibraryTemplate::loadMultiple()`, each as an off-canvas AJAX link that imports the template into the current section storage. A `hook_form_alter()` adds an "Add to library" link button to a node's `..._layout_builder_form` (pointing at `section_library.add_template_to_library`) and applies the `glb-form` / `#gin_lb_form` treatment to the section-library add forms so they inherit Gin styling. `hook_page_attachments()` attaches the module's own `gin_lb_plus/core` CSS library on valid Layout Builder routes (reusing gin_lb's `gin_lb.context_validator`). It ships no configuration, no settings form, no permissions, no Drush commands and no plugins — it is purely a UI layer, and Section Library / Layout Builder Browser are the optional integrations it plays well with.

---

- Turn Layout Builder's flat "Add block" list into Gin-styled horizontal tabs grouped by category.
- Turn the "Add section" (choose layout) screen into tabs with a preview icon per layout.
- Show a dedicated "Library" tab when adding a section, listing reusable Section Library templates.
- Let editors insert a saved `section_library_template` straight from the section picker via an off-canvas link.
- Add an "Add to library" button to a node's Layout Builder form so a whole layout can be saved as a template.
- Give each block in the picker a visual icon instead of a plain text link.
- Give each layout in the section picker a visual icon (falling back to a bundled empty-section SVG).
- Provide a consistent, opinionated Gin look for the block/section browsing experience.
- Style Section Library's "Add section to library" and "Add template to library" forms with the Gin LB treatment.
- Reuse gin_lb's `gin_lb.context_validator` so the extra styling only loads on real Layout Builder routes and non-Gin themes.
- Render a fallback SVG icon (`block-empty-icon.svg` / `section-empty-icon.svg`) for blocks/sections that have no image.
- Use the `gin_lb_plus_icon` theme hook / template to render block and section icons.
- Combine with Layout Builder Browser to get icon-driven block categories in the picker.
- Combine with Section Library to expose a per-storage "Library" import list inside the section picker.
- Attach the `gin_lb_plus/core` CSS (which pulls in field_group's horizontal-tabs behaviour) only where Layout Builder is being edited.
- Present block categories through field_group horizontal tabs rather than vertical accordions.
- Offer a one-click "Add to library" flow from the layout edit toolbar/actions area.
- Keep the "move sections" action button visually consistent with the Gin LB button styling.
- Give a small agency site a friendlier, more visual Layout Builder authoring UI out of the box.
- Standardise the block/section-adding UX across content types that use Layout Builder overrides.
- Let a site builder curate reusable sections and surface them directly where editors add sections.
