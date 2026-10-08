<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Live Preview lets editors preview microsite design changes live — opening the microsite's design form in an off-canvas settings tray and reflecting changes on the page before anything is saved.

---

The base module does very little on its own: it only ships shared theming for the off-canvas tray, acting as a home for functionality common to future submodules. The actual feature lives in the `localgov_live_preview_microsites` submodule, which depends on `localgov_microsites_group` and the microsites colour-picker fields. It adds an "Edit Microsite Design" local task to node pages (visible to authenticated users), and a `LivePreviewRouteSubscriber` that clones the existing `entity.group.edit_form` route into a new `entity.node.group_live_preview` route so the group's design form can be opened in-context from a node. When the form is loaded in the off-canvas dialog (or re-submitted via AJAX, detected by a hidden `localgov_live_preview_mode` marker), `hook_entity_form_mode_alter` switches the group form to the dedicated `localgov_live_preview` form mode, and the bundled JavaScript applies edits to the live page. Nothing is visible to other users until the editor saves.

Because it is scoped to LocalGov microsites, it is only useful on a LocalGov Microsites platform with the group stack installed. On the security side the cloned live-preview route is a copy of the group edit form's route, so it inherits that form's access requirements (group update access) — the preview does not widen access, and no unpublished content is exposed beyond what a user could already edit on the group. The version is an experimental 1.1.x beta. Typical setup: install on a LocalGov Microsites site, enable the microsites submodule and its dependencies, then use the "Edit Microsite Design" tab on a microsite node.

---

- Preview microsite design changes before saving them
- Open the microsite design form in an off-canvas settings tray
- See colour-picker changes reflected live on the page
- Access the preview from an 'Edit Microsite Design' tab on node pages
- Keep unsaved changes private until the editor saves
- Switch the group form to the dedicated `localgov_live_preview` form mode in the tray
- Re-apply the live-preview form mode across AJAX resubmissions
- Theme the off-canvas tray via the base module's CSS library
- Install only the base module to share tray theming with future submodules
- Enable the microsites submodule for the actual live-preview feature
- Rely on the cloned group edit-form route inheriting the original's access control
- Restrict preview to users who can already edit the microsite group
- Use on a LocalGov Microsites platform with the group stack installed
- Depend on localgov_microsites_group and the colour-picker fields module
- Understand it exposes no new anonymous or mutating endpoints
- Treat it as an experimental (beta) editing convenience
