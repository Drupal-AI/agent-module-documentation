<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Layout with restricted access (drowl_paragraphs_bs_type_layout_restricted_access) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `layout_restricted_access` Paragraph type
(a Layout Paragraphs layout with a role-based view restriction).

- **Access field**: `field_access_by_role` (field type `entity_access_by_role_field`, cardinality -1),
  settings enforce only `operations.view`; `empty_roles_access_fallback: neutral`; default value
  `role_id: authenticated, access: allowed`. Enforcement lives in the **entity_access_by_role_field**
  contrib module (a server-side entity/paragraph access check), not in this sub-module.
- **Layout**: `behavior_plugins.layout_paragraphs` enables the DROWL 1–6 column layouts;
  `ui_style_options` enables a large set of UI-Styles groups.
- **Other fields**: shared `field_background_media`, `field_resp_imagestyle`, `field_settings` (all hidden
  on default display except background media).
- No routes/permissions/services/schema of its own. Depends on `layout_paragraphs`, `drowl_layouts_bs`,
  `entity_access_by_role_field`, media/media_library.

See [paragraphs/layout-restricted-access.md](paragraphs/layout-restricted-access.md).
