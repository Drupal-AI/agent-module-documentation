Media Library Edit adds a per-item "Edit" button to Drupal's core Media Library form widget, opening the selected media entity's edit form in a modal so editors can fix metadata without leaving the content form.

---

The core `media_library_widget` (used on entity-reference-to-media fields) lets you add, remove, and reorder media but has no way to edit an already-selected item. Media Library Edit fills that gap using third-party widget settings and field-widget alter hooks — no admin config page or routes of its own. You enable it per widget under **Manage form display → the media field's gear/settings**, where it adds a **"Show edit button"** checkbox and a **"Form mode"** select (choose which media form mode the edit modal renders). When enabled, each selected media item that the current user can `update` gets a pencil edit link that opens the media entity's `edit-form` in an AJAX modal dialog (via `core/drupal.dialog.ajax`). The module passes `media_library_edit=ajax` and `media_library_form_mode=<mode>` query parameters on the edit URL; `hook_form_alter` strips the delete action and rewires the save button to an AJAX callback that closes the dialog and re-renders the updated item in place, while `hook_entity_form_display_alter` swaps in the chosen form mode. Access is respected per item — the button only appears when `$media->access('update')` is TRUE and the media type exposes an `edit-form` link template. Settings are stored as `field.widget.third_party.media_library_edit` config on the form-display, so they export and deploy with configuration. It is a small, dependency-light companion to core Media Library.

---

- Let editors fix a media item's alt text or name directly from the media reference widget.
- Add an inline edit button to a media field on a content type's form.
- Correct media metadata without navigating away from the node/entity edit form.
- Edit a selected image's fields in a modal and see the thumbnail refresh in place.
- Choose a dedicated "media library" form mode for the quick-edit modal.
- Restrict the edit modal to a trimmed-down set of fields via a custom form mode.
- Enable the edit button only on the widgets where editors need it (per form display).
- Keep the full media edit form for admins while exposing a lighter one in the widget.
- Respect media update permissions so only authorized users see the edit button.
- Update caption/credit fields on an embedded media asset during article authoring.
- Re-crop or re-focus an image via image fields exposed in the edit modal.
- Fix a mislabeled document title on a file media item inline.
- Provide a smoother editorial workflow for teams heavily using Media Library.
- Avoid opening a second browser tab just to change one media field.
- Deploy the "show edit button" setting between environments as exported config.
- Swap the modal's rendered fields per bundle using bundle-specific form modes.
- Edit media on remote-video or audio bundles from the reference widget.
- Reduce editor friction on landing pages built from many referenced media items.
- Let the save button in the modal close the dialog and update the item without a page reload.
- Hide the delete action inside the quick-edit modal to prevent accidental deletion.
- Turn the edit button on for a gallery field but leave it off elsewhere.
- Give content editors self-service media metadata corrections without site-builder help.
- Standardize a "quick edit" media form mode across all media reference fields.
- Show a form mode label summary on the widget settings so builders see what's active.
