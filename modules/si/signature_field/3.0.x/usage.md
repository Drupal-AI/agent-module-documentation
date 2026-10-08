Signature Field provides a Field API field type (`field_signature`) that captures a handwritten signature drawn on an HTML5 canvas and stores it as a base64 PNG data URL, displaying it back as an `<img>`.

---

The module ships one field type `field_signature` (stored as a `big` text/BLOB column), one widget `field_signature_field_widget` ("Signature Data"), and one formatter `field_signature_field_formatter`. Add the field via *Manage fields* like any field; there is no global settings page (`configure` is null) and no permissions. The widget renders a `<canvas>` plus a "Clear" button and a hidden/visible textarea; the [signature_pad](https://github.com/szimek/signature_pad) JS library (loaded from a jsDelivr CDN, v4.0.0) turns strokes into a `data:image/png;base64,...` string written into the textarea on each `endStroke`. That string is what gets saved to the field. Per-widget settings (config schema `field.widget.settings.field_signature_field_widget`) control the canvas: `show_data_box`, `show_thumb`, `canvas_width`/`canvas_height`, `min_line_width`/`max_line_width`, `pen_color`, `background_color` (color inputs when the core `color` module is enabled, else plain text). The formatter simply outputs `<img src="{stored value}">`. A standalone `signature` render/form element also exists but is minimal (its value handling is a no-op) — the practical entry point is the field widget. Requires core `field` + `field_ui`; no other Drupal or Composer dependencies.

---

- Capture a customer's handwritten signature on a content-entity form (node, custom entity, etc.).
- Add a signature field to a "contract" or "consent" content type for sign-off.
- Store a signed acknowledgement as an image on a user-facing form.
- Display a previously captured signature as an image on the entity's view page.
- Let signers draw with a mouse, stylus, or finger on touch devices.
- Provide a "Clear" button so a signer can redo their signature.
- Set the canvas width and height to fit your form layout.
- Constrain the pen stroke with minimum and maximum line widths for a consistent look.
- Choose a pen color (e.g. blue ink) for signatures.
- Set a canvas background color to distinguish the signing area.
- Show a live thumbnail preview of the signature as it is drawn (`show_thumb`).
- Hide the raw data-URL textarea from signers while still storing the value (`show_data_box` off).
- Keep the raw data box visible for debugging or manual paste of a signature value.
- Re-sign: when a stored signature loads, the canvas hides and can be swapped back to edit mode.
- Collect signatures on delivery-confirmation or work-order entities.
- Attach a signature to a form built from an existing content type without custom code.
- Render the signature at its native size in any view mode via the formatter.
- Use the color-input pickers for pen/background when the core Color module is enabled.
- Export/import signature values as part of standard entity content (the value is a plain string).
- Add multiple signature fields (e.g. customer + witness) to one entity.
- Reuse the `signature` form element in a custom render array where only a drawing surface is needed.
- Self-host the signature_pad library by overriding the CDN URL if you must avoid external assets.
