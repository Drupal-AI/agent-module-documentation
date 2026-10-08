<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Target Styles adds HTML ID and CSS class text fields to Layout Builder blocks and sections so a themer can target them with custom CSS.
---
The module hooks the Layout Builder add/update-block forms and the configure-section form (`hook_form_alter` / `hook_form_FORM_ID_alter`) to inject a "Block layout target styles" details group with two textfields: **Block HTML ID** (`layout_target_styles_html_id`) and **Block HTML Classes** (`layout_target_styles_html_classes`). Custom submit handlers are unshifted before Layout Builder's own so the values persist into the component/section configuration before it is written to tempstore/section storage. At render time, a `BlockComponentRenderArraySubscriber` applies the stored id/classes to block components, and `hook_preprocess_layout` merges the class onto the section's `attributes['class']` and sets its `attributes['id']`. It also ships a `RouteSubscriber` and a `ConfigureSectionForm` subclass that exposes the layout plugin object (working around core issue 3044117).

Setup is essentially zero-config: enable the module (Layout Builder must be on) and the fields appear automatically wherever blocks/sections are configured. Values are entered by editors who already hold Layout Builder configuration access, and the entered strings become element attributes rendered through Drupal's attribute system. Security posture: there are **no routes, permissions or config entities of its own** — the only surface is the Layout Builder forms, which are gated by Layout Builder's existing access control (site builders/editors). Because the id/class strings are author-supplied and land in HTML attributes, restrict Layout Builder access to trusted roles as you already would.
---
- Enable the module (requires `layout_builder`).
- Add a custom HTML ID to a Layout Builder block for CSS/JS targeting.
- Add one or more CSS classes to a Layout Builder block.
- Add an HTML ID or classes to a Layout Builder section (layout).
- Target a specific block from a theme's CSS by its assigned ID.
- Apply utility/framework classes (e.g. spacing helpers) to blocks per-instance.
- Give a section a landmark ID for in-page anchor links.
- Distinguish otherwise-identical blocks for styling without a new block type.
- Combine with a component/utility CSS library to style Layout Builder output.
- Persist styles as part of the layout's section storage (travels with the layout).
- Style blocks without writing preprocess code or template overrides.
- Scope JS behaviours to a block via its custom ID.
- Group multiple blocks under a shared class for consistent styling.
- Add animation or transition hooks to a section via its ID.
- Keep per-instance styling in config so it exports with the layout.
- Avoid creating extra block types just to vary appearance.
