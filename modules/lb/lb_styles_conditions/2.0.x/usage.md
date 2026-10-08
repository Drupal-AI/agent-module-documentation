<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Styles Conditions lets you attach Drupal Conditions-API rules to individual Layout Builder Styles so a style option only appears in the Layout Builder UI when its conditions (user role, node type, request path, etc.) are met.

---

The module extends the `layout_builder_styles` contrib module using the `conditions_helper` module's form builder and evaluator. On a Layout Builder Style add/edit form it injects a "Condition restrictions" details section (`hook_form_layout_builder_style_(add|edit)_form_alter` → `FormAlters::layoutBuilderStylesFormAlter`) whose conditions are stored in the style entity's third-party settings (`layout_builder_styles.style.*.third_party.lb_styles_conditions`). When an editor opens the Layout Builder block or section style dropdowns (`hook_form_layout_builder_(add|update)_block_alter`, `hook_form_layout_builder_configure_section_alter`), `FormAlters` walks the relevant styles (respecting Layout Builder Styles' own block/layout restrictions), evaluates each style's conditions via `conditions_helper.evaluator`, and removes the whole style group element (`layout_builder_style_<group>`) from the form when the conditions fail — so disallowed styles simply aren't offered. A site settings form at `/admin/config/user-interface/lb-styles-conditions` (`lb_styles_conditions.settings`, permission `administer lb_styles_conditions`, `restrict access: true`) controls which condition plugins are available (`enabled_conditions`), and `hook_lb_styles_conditions_available_conditions_alter` lets other modules add/remove conditions. This governs style **availability in the authoring UI only** — it is a content-authoring convenience, not a security/access boundary on rendered output.

---

- Show a Layout Builder Style option only for specific user roles.
- Restrict a "brand/hero" style to certain content types (node bundles).
- Offer a style only on certain paths using the request-path condition.
- Limit decorative section styles to a particular theme or context.
- Reduce clutter in the Styles dropdown by hiding irrelevant options per context.
- Enforce editorial guidelines by exposing approved styles only where appropriate.
- Attach conditions to a component (block) style so it appears only for matching blocks.
- Attach conditions to a section style so it appears only for matching layouts.
- Respect Layout Builder Styles' block/bundle restrictions and layer conditions on top.
- Provide different style palettes to different editor roles on the same layout.
- Limit which condition plugins editors can use via the admin allow-list.
- Add or remove available conditions programmatically via the alter hook.
- Curate style options per landing-page campaign using path conditions.
- Keep style configuration exportable (stored in the style entity's third-party settings).
- Hide experimental styles behind a role/condition until they're ready for everyone.
- Simplify the authoring experience for non-technical editors by narrowing style choices.
- Combine multiple conditions on a single style for fine-grained availability.
- Reuse the same Conditions API blocks used elsewhere (block visibility) for style gating.
