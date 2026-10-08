<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Sections Access (layout_builder_sections_access) — agent index

Adds two per-section options to core **Layout Builder**: **deactivate** a whole section, or
**restrict its rendering to selected roles**. Everything lives in `layout_builder_sections_access.module`
(no routes, services, controllers, or config entities). Mechanism: `hook_form_FORM_ID_alter` on the
core section form `layout_builder_configure_section` injects an `Access` fieldset with a
`disable_section` checkbox and a multi-select `visibility_roles`; a prepended submit handler writes
them into the section's layout **configuration** under the key `layout_builder_sections_access_config`.
Enforcement is at render time in `hook_preprocess_layout`: when the layout is **not** in preview
(`in_preview === FALSE`) and the section is disabled — or the current user matches none of the allowed
roles — the code does `unset($variables['content'])` so the section's content is never built into the
HTML. This is genuine **server-side** removal (confirmed by the module's own functional test), not a
CSS/JS hide; the CSS opacity and the `(Disabled)`/`(Role Access)` label are applied **only** in the
Layout Builder editing UI (`in_preview === TRUE`) as an editor cue.

Understand the layer: this is **section-render visibility by role**, not entity/field access control.
A restricted section is skipped only on the themed layout render path; any block inside it keeps its own
access, and content that is also reachable another way (its own URL, JSON:API/REST, or a second
placement) is not protected by the section restriction. Back genuinely sensitive content with the
block's or entity's own access.

- **Depends on:** `drupal:layout_builder` (core).
- **Core:** `^10 || ^11`.
- **Package:** Layout Builder.
- **Settings page / configure route:** none. Options appear inside the Layout Builder section form.
- **Permissions:** none of its own — who can set the options is governed by core LB permissions
  (`configure any layout` / `configure all layouts`) that gate `layout_builder_configure_section`.
- **Drush:** none. **Plugin types:** none. **Config schema:** none (values ride in the layout config).
- **Install:** `hook_install` sets the module weight to `100` so it runs after other modules that add to
  the layout `content` array.

## What you'd do → where
- Set/read the per-section options, and do it programmatically on a `Section` → [configure/section-access.md](configure/section-access.md)
- Understand the render/enforcement mechanism, hooks, cache contexts, the UI library and data attributes → [api/render-behavior.md](api/render-behavior.md)

## Key facts (real machine names)
- Module file: `layout_builder_sections_access.module`.
- Hooks: `hook_help` (route `help.page.layout_builder_sections_access`),
  `hook_form_layout_builder_configure_section_alter`, submit handler
  `_layout_builder_sections_access_submit_form`, `hook_preprocess_layout`, `hook_install`.
- Altered core form id: `layout_builder_configure_section`.
- Config key (in the section's layout configuration): `layout_builder_sections_access_config`
  → sub-keys `disable_section` (0/1) and `visibility_roles` (array of role machine names).
- Library: `layout_builder_sections_access/ui` (`css/layout_builder_sections_access.css`,
  `js/layout_builder_sections_access_ui.js`; deps `core/drupal`, `core/jquery`, `core/once`).
- Preview-only markup: attributes `data-layout--disable-section` / `data-layout--role-access`; JS adds
  suffix `(Disabled)` / `(Role Access)` to the configure link and class `layout-builder__section__disabled`.
