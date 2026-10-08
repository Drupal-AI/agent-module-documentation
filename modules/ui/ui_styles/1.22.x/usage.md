<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles lets modules and themes declare reusable, named sets of CSS classes ("styles") in a YAML plugin file, then exposes them as a reusable form element so site builders can pick and apply those classes to blocks, Layout Builder sections, views, regions, CKEditor content and more.

---

At its core UI Styles is a **style plugin manager** (`plugin.manager.ui_styles`) that discovers style definitions from any `*.ui_styles.yml` file shipped by an enabled module or theme (Drupal `YamlDiscovery`). Each definition has an id, a human label, an optional category, and an `options` map whose keys are the actual CSS classes to add and whose values are the labels shown in the UI. A **Source** plugin type (`select`, `checkbox`, `toolbar`) controls the widget used to choose an option, and the `ui_styles_styles` render/form element renders the whole grouped selector. Selections are stored as a small `{ selected: {...}, extra: "free classes" }` mapping (config schema `ui_styles.selected_mapping`) wherever the integrating submodule keeps its config. At render time `StylePluginManager::addClasses()` walks a render array and injects the chosen classes onto the first element that accepts attributes (wrapping it if needed). A separate **StylesheetGenerator** service (route `/ui_styles/stylesheet`) can parse the active themes' CSS libraries and emit a stripped-down stylesheet containing only the rules for declared style-option classes, so previews and the CKEditor iframe can show the styles. The base module ships no admin UI of its own; the many submodules (`ui_styles_block`, `ui_styles_layout_builder`, `ui_styles_views`, `ui_styles_page`, `ui_styles_entity_status`, `ui_styles_ckeditor5`, `ui_styles_ui_patterns`, `ui_styles_library`) wire the selector into each integration point.

---

- Declare a design system's utility classes (e.g. Bootstrap `text-primary`, `bg-dark`, `rounded`) once and reuse them everywhere.
- Give site builders a curated dropdown of "approved" CSS classes instead of a free-text class field.
- Group related classes into categories (Colors, Spacing, Shadows) that render as collapsible detail groups in forms.
- Apply background/text/border utility classes to individual blocks in the block layout.
- Add spacing or colour classes to Layout Builder sections and to the regions inside a section.
- Style a view's rows, exposed filter form, or pager with utility classes without writing a template.
- Attach classes to theme regions (header, content, footer) per theme via the regions-styles settings.
- Add a visual treatment to unpublished content so editors can spot it in preview.
- Let content authors wrap a paragraph or an inline span in a named style from the CKEditor 5 toolbar.
- Expose UI Styles class selection as a UI Patterns source for the `attributes` prop of any component.
- Ship theme-specific styles that only appear when that theme (or a subtheme) is active.
- Generate a preview stylesheet so the CKEditor iframe and library page can render the real look of each class.
- Provide a "styles library" page listing every declared style and option for documentation/QA.
- Enforce a governed set of classes so editors can't type arbitrary or broken class names.
- Add an `extra` free-text escape hatch for one-off classes alongside the curated selector.
- Define styles that carry an SVG/emoji icon or a live preview snippet in the selector.
- Restrict which styles apply to which element via `previewed_with` example markup.
- Let a distribution ship a ready-made palette of styles for its base theme.
- Migrate hard-coded template classes into configurable, per-instance style selections.
- Weight and sort styles so the most common options float to the top of the selector.
- Build an atomic/utility-first workflow inside Drupal's admin without custom code.
- Filter available styles to the current front-end theme using `getDefinitionsForTheme()`.
- Add classes programmatically to any render array from custom code via `addClasses()`.
- Prefix generated CSS selectors so preview styles are scoped to a container.
- Document link references (external docs URLs) alongside each style definition.
