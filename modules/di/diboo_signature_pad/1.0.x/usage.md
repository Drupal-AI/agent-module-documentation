Diboo signature pad turns the image field on Diboo chain links into a hand-drawn signature pad, capturing a PNG the visitor draws instead of an uploaded file.

---

Diboo signature pad is a thin addon for the Diboo ecosystem (it requires `diboo_core` and the `signature_pad` contrib module). It ships no configuration screen, no entities, routes, services, permissions, or config schema. Its only behaviour is a single `hook_entity_form_display_alter()` implementation: when the form display being built is the `diboo_chain_link` form mode and it contains a `diboo_image` component, the module rewrites that component to use the `signature_pad` field widget with a fixed, pre-tuned set of settings (transparent background, black pen, 16:10 aspect ratio, PNG output, randomized filename, a minimum-strokes requirement, undo/reset buttons, a jscolor colour picker and a slider size picker, JSON stroke data saved, and the alt/title/remove/image-link chrome hidden). The result is that drawing a picture replaces file upload for Diboo chain links. The actual capture, decoding and saving of the drawn image is performed by the `signature_pad` widget from its own module — this module only selects and configures that widget.

---

- Let editors "sign" or draw a Diboo chain link image by hand instead of uploading a file.
- Capture a hand-drawn PNG on the `diboo_chain_link` form mode's `diboo_image` field.
- Provide a signature-pad drawing surface inside a Diboo content-entry workflow.
- Standardize the drawing widget settings across every chain-link form without per-field configuration.
- Enforce a minimum number of pen strokes (10) so blank or trivial drawings are rejected.
- Show a helpful "Please add some strokes to give it more detail" message when too few strokes are drawn.
- Draw with a transparent background so the artwork composites cleanly over other content.
- Default the pen to solid black while letting users pick colours via the jscolor colour picker.
- Let users adjust pen thickness with a slider size picker.
- Offer undo and reset buttons on the drawing surface.
- Output the drawing as an `image/png` file with a randomized filename on upload.
- Persist the raw stroke data as JSON alongside the rendered image (`save_json_data`).
- Fix the drawing canvas to a 16:10 aspect ratio for consistent chain-link images.
- Hide the alt-text, title, remove and image-link fields to keep the widget minimal.
- Blank the field label (`<nolabel>`) and remove label for an uncluttered chain-link form.
- Add drawing capability to a site that already runs Diboo without writing custom form-alter code.
- Serve as the first/only "drawing" provider for Diboo, with the roadmap allowing it to be swapped out once other drawing modules exist.
- Reuse the community `signature_pad` widget's rendering while keeping Diboo-specific defaults in one place.
- Enable/disable drawing for chain links simply by enabling or disabling this module.
