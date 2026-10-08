<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Frontend Editing lets editors change content directly on the rendered page: it opens the entity edit form in a slide-in sidebar and adds inline add/move/delete controls for Paragraphs, with an optional live preview.

---

Frontend Editing wraps the fields of configured entity bundles on their canonical (front-end) display with edit affordances. Clicking a field or an entity's edit control opens that entity's form in a resizable side panel (`frontend_editing.form` route), and on save the rendered content is refreshed in place via AJAX. For Paragraphs it adds up/down move, add-before, delete, and duplicate action links rendered around each paragraph, backed by dedicated routes and access-checked through the `paragraphs_edit` module (a hard dependency). Which entity types and bundles get this treatment is chosen on the "Entity types and bundles" admin form and stored in `frontend_editing.settings` under the `entity_types` map; a broad set of UI options (sidebar vs full width, hover highlight, automatic preview, primary color, a floating on/off toggle button, add-item filtering) lives in the same config object. Five permissions gate access and the paragraph actions (`access frontend editing`, `administer frontend editing`, plus `move`/`add`/`delete paragraphs`). The module exposes three access events (move/add/delete) and two alter hooks (`hook_fe_field_wrapper_exclude_alter`, `hook_fe_allowed_bundles_alter`) for fine-grained control, and a `frontend_editing.paragraphs_helper` service for lineage-aware paragraph operations. It has an optional integration with `all_entity_preview` for previewing unsaved entities.

---

- Let editors fix a typo in a node's body directly on the published page without hunting for the node edit form.
- Open any configured entity's edit form in a slide-in sidebar while keeping the page in view.
- Add a new Paragraph between two existing ones using an inline "add before" control.
- Reorder Paragraphs on a landing page with up/down move links, no drag-and-drop backend needed.
- Delete an unwanted Paragraph from a page in place.
- Duplicate a Paragraph (e.g. a card or stat block) to quickly build repeating layouts.
- Give marketers a live-preview authoring experience on Paragraph-built pages.
- Enable frontend editing only for specific bundles (e.g. `node.landing_page`) via the entity-types/bundles form.
- Refresh edited content on the page via AJAX without a full reload after saving.
- Highlight the editable region on hover so authors see exactly what a field maps to.
- Constrain who can edit on the front end with the `access frontend editing` permission.
- Separate "can edit" from "can add/move/delete paragraphs" using the dedicated paragraph permissions.
- Provide a floating toggle button so editors switch frontend editing on and off per session.
- Set the sidebar width (and full-screen width) to fit a complex form comfortably.
- Brand the editing UI with a custom primary color.
- Exclude specific fields from the editable wrapper via `exclude_fields` config or `hook_fe_field_wrapper_exclude_alter()`.
- Remove certain bundles from the "add paragraph" list with `hook_fe_allowed_bundles_alter()`.
- Filter a long "add paragraph" type list with a search box once it exceeds a threshold.
- Override paragraph move/add/delete access with the module's access events.
- Keep action links inside the viewport for very tall paragraphs using the viewport option.
- Preview unsaved entity changes by pairing with the `all_entity_preview` module.
- Let editors edit taxonomy terms or other content entities inline by enabling those bundles.
- Speed up in-context copywriting review by editing and saving without leaving the page.
- Turn automatic preview on so the sidebar re-renders the entity as fields change.
- Build a click-to-edit workflow for a Paragraphs-based page builder.
