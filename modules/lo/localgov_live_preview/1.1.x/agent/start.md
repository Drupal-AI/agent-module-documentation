<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Live Preview (localgov_live_preview) — agent index

**Opens the microsite design form in an off-canvas tray and live-previews design changes before saving. Base module = shared tray theming; feature lives in the microsites submodule.**

- **Version:** 1.1.x (1.1.0-beta4, experimental)  ·  **Core:** ^10 || ^11  ·  **Package:** LocalGov Drupal (Experimental)
- **Base module:** only provides the `localgov-live-preview` CSS library (off-canvas tray theming).
- **Submodule `localgov_live_preview_microsites`** (depends on `localgov_microsites_group`, `localgov_microsites_colour_picker_fields`):
  - `LivePreviewRouteSubscriber` clones `entity.group.edit_form` → `entity.node.group_live_preview`.
  - `LivePreviewLocalTask` adds an "Edit Microsite Design" tab on `entity.node.canonical` (authenticated users).
  - `hook_entity_form_mode_alter` switches the group form to the `localgov_live_preview` form mode in the off-canvas dialog / AJAX resubmit (hidden `localgov_live_preview_mode` marker).

**Security:** the live-preview route is a clone of the group edit-form route and therefore inherits its access control (group update access) — it does not broaden access or expose unpublished content beyond what the underlying group edit form already permits. No new anonymous or mutating endpoints. No security findings.

See [configure/microsites-preview.md](configure/microsites-preview.md).