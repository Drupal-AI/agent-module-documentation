<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsites live preview

**Requirement:** a LocalGov Microsites platform — the submodule depends on
`localgov_microsites_group` and `localgov_microsites_colour_picker_fields`.
Enable `localgov_live_preview_microsites` (the base `localgov_live_preview`
only carries tray theming).

**Using it:** with the `localgov_live_preview_microsites` library attached (on
node pages, for authenticated users), an "Edit Microsite Design" local task
appears. Clicking it opens the microsite group's design form in an off-canvas
settings tray via `entity.node.group_live_preview` (a clone of
`entity.group.edit_form`). Colour-picker and design changes preview live on the
page; nothing is public until you press save.

**Form-mode mechanism:** `hook_entity_form_mode_alter` sets the group form mode
to `localgov_live_preview` when the request is the off-canvas dialog
(`_wrapper_format = drupal_dialog.off_canvas`) or an AJAX resubmit carrying the
hidden `localgov_live_preview_mode` field (added by
`hook_form_group_microsite_edit_form_alter`). This keeps the trimmed
design-only form mode on both initial load and subsequent AJAX submits.

**Access:** because the preview route is a clone of the group edit form route,
access is exactly the group edit-form's access (group update). There is no
separate permission grant and no widening of access.
