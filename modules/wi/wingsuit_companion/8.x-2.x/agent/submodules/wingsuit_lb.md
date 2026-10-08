<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `wingsuit_lb` — Layout Builder browser reskin

Reskins the Layout Builder "choose section / choose block" browser to the Wingsuit UI and adds a
section-library "Add to library" button. Dependencies:
`layout_builder_browser (>=1.7)`, `field_group`, `gin_lb (>=1.0.0-rc7)`, `section_library`.

## Mechanism

- **`LayoutBuilderBrowserEventSubscriber`** (`src/EventSubscriber/`, service tag `event_subscriber`,
  listens on `KernelEvents::VIEW` priority 45). On route `layout_builder.choose_section` it rebuilds
  the render array into `horizontal_tabs` with a "Sections" tab and a "Library" tab; the Library tab
  is built by `getLibrarySectionLinks()`, which loads all `SectionLibraryTemplate` entities and
  renders each as an off-canvas AJAX link to
  `section_library.import_section_from_library`. On `layout_builder.choose_block` it converts block
  categories to `horizontal_tabs` and swaps in `wingsuit_lb_icon` theming. Both attach the
  `wingsuit_lb/core` library.
- **`wingsuit_lb.module`**
  - `hook_page_attachments` — attaches `wingsuit_lb/core` on valid Layout Builder routes (checked via
    `gin_lb.context_validator`).
  - `hook_form_alter` — on a node's `*_layout_builder_form`, adds an "Add to library" link to
    `section_library.add_template_to_library` (rendered with `#access` = the URL's own access check);
    styles `section_library` add-to-library forms with the gin_lb form treatment.
  - `hook_ui_patterns_layouts_display_settings_form_alter` — hides `field_templates` and containerizes
    the settings form.
  - `hook_theme` + `hook_preprocess_wingsuit_lb_icon` — defines the `wingsuit_lb_icon` theme hook
    (template `templates/wingsuit-lb-icon.html.twig`), defaulting to bundled
    `images/block-empty-icon.svg` / `section-empty-icon.svg` when no icon URI is given.

## Notes for agents

- Section labels loaded from `SectionLibraryTemplate` entities are rendered into the browser via
  `Markup::create()`. These come from users with permission to add templates to the section library
  (a privileged Layout Builder editor role). Treat label content as trusted-editor input.
- Everything here runs inside Layout Builder routes, which are access-controlled by core Layout
  Builder / `layout_builder_browser` / `section_library` permissions.
