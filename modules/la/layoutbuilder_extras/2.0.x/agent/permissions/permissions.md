# Permissions & access model

## Defined permission

| Permission | `restrict access` | Gates |
|---|---|---|
| `manage layoutbuilder_extras settings` | not set | The settings form at `/admin/config/content/layout-builder-extras-settings` only. |

That permission controls **only** the cosmetic/UX settings object (`layoutbuilder_extras.settings`):
button position, icon-only CSS, drag handle, empty-div removal, redirect-on-save, and contextual-link
visibility. It grants no ability to edit content, layouts, or other config, so the absence of
`restrict access: true` is not a privilege concern — nothing boundary-crossing sits behind it.

## Relationship to core Layout Builder access (important)

This module extends Layout Builder but does **not** change who may edit a layout:

- The two state-changing custom routes — `layoutbuilder_extras.alter_section` (swap a section's
  layout) and `layoutbuilder_extras.section_actions` (add-section dialog) — declare
  `_layout_builder_access: 'view'`, the same access check core uses for
  `layout_builder.choose_section` / `layout_builder.configure_section` / `.remove_section`. Section
  storage is loaded from the Layout Builder tempstore exactly as core does.
- `enable_redirect_on_save` only adds the post-save redirect if
  `access_manager->checkNamedRoute('layout_builder.overrides.node.view', …)` passes for the current
  user — so it never exposes the LB edit screen to someone who lacks access to it.
- The contextual-link decorator (`ContextualLinkManager`, `contextual_links_only_lb`) can only
  **hide** contextual links for roles not in `contextual_links_roles`; it does not grant access.
  Contextual links are UI shortcuts whose targets still enforce their own route access, so this is a
  visibility preference, not a security control (in either direction).

Net: layout-editing authority is inherited from core Layout Builder unchanged.
