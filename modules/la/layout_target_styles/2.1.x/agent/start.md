<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Target Styles (layout_target_styles) — agent index

**Adds free-text HTML ID and CSS class fields to Layout Builder blocks and sections for CSS targeting.**

- **Version:** 2.1.x  •  core: `^8 || ^9 || ^10 || ^11`  •  depends on `drupal:layout_builder`
- **Mechanism:** `hook_form_alter` on `layout_builder_add_block`/`layout_builder_update_block` and `layout_builder_configure_section` adds a *Block layout target styles* group with fields `layout_target_styles_html_id` and `layout_target_styles_html_classes`; custom submit handlers persist them before Layout Builder's.
- **Render:** `BlockComponentRenderArraySubscriber` applies id/classes to block components; `hook_preprocess_layout` merges class + id onto section attributes.
- **Extras:** `RouteSubscriber`, `ConfigureSectionForm` subclass exposing the layout plugin (core issue 3044117).
- **Routes/permissions/config:** none of its own.

**Security:** no own routes, permissions or config — the only surface is Layout Builder's configure forms, gated by Layout Builder's existing access control. Author-supplied id/class strings render into HTML attributes via Drupal's attribute system; restrict Layout Builder access to trusted roles. No anonymous or mutating endpoint.
