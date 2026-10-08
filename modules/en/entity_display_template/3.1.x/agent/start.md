<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Display Template (entity_display_template) — agent index

**Adds a per-view-mode Twig editor to Manage Display; the stored Twig replaces default field rendering via an inline_template at render time.**

- **Version:** 3.1.x
- **Core:** ^10 || ^11 — depends on `codemirror_editor`
- **Type:** hook-based, no routes/services of its own.
- **Hooks (.module):** `hook_form_entity_view_display_edit_form_alter()` adds the `enabled`+`twig` fields (stored as third-party settings on the EntityViewDisplay); `hook_entity_display_build_alter()` renders the stored Twig; `entity_display_template_default_context()` supplies context vars.
- **Security — SSTI by design:** the stored template is executed via `#type => 'inline_template'` in `entity_display_template_entity_display_build_alter()` (no Twig sandbox). Anyone who can edit an entity view display can run **arbitrary Twig for all viewers** of that view mode. Gated only by the core display-admin permission (site-builder/trusted-admin), **not anonymous**; no user-input form/route feeds the template. Treat display-admin as PHP-equivalent trust here.

See [configure/templates.md](configure/templates.md).