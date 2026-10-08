Signature (sign_widget) lets a user draw a signature on an HTML5 canvas and stores it as a PNG or SVG file, exposed as an image-field widget, an image-field formatter, and a CKEditor 5 toolbar button.

---

Capturing a hand-drawn signature is a recurring need — consent forms, delivery confirmations, agreements, registration flows — and it takes two things: a drawing surface in the browser and somewhere to keep the result. sign_widget supplies both on top of Drupal core's image field. Add a normal image field to any entity, then on *Manage form display* pick the **Sign** widget: editors get a canvas (powered by szimek/signature_pad) instead of a file upload, and the drawing is saved as a PNG image file referenced by the field. On *Manage display* the matching **Sign** formatter renders stored signatures and can also show a live canvas so a signature can be added straight from the rendered entity. A separate CKEditor 5 integration adds a **Signature** toolbar button that lets an author draw a signature and insert it into rich text as an inline SVG. Per-display settings tune the pen (dot size, min/max stroke width, pen and background colour, velocity smoothing), the canvas width, an optional colour toolbox, a remove/reset button, and whether the signature_pad library loads from a CDN or a locally installed copy. The module depends only on core's image module and needs no extra configuration objects; each behaviour is configured on the individual field display or text-format editor.

---

- Add a signature canvas to a content type's edit form via an image field.
- Let a user draw a signature with a mouse, stylus, or touchscreen.
- Store a captured signature as a PNG image file on an entity.
- Display a stored signature with the Sign image formatter.
- Draw over a default background image (e.g. sign an existing document scan).
- Capture a signature on a consent or agreement form.
- Record a delivery-confirmation signature against an order or record.
- Collect a signature during a registration or onboarding flow.
- Add a Signature button to a CKEditor 5 toolbar for rich-text authoring.
- Insert an inline SVG signature into body text from the editor.
- Capture multiple signatures in one multi-value image field.
- Add a signature directly from a rendered entity display (formatter canvas).
- Customise pen colour and stroke width per field display.
- Set a fixed canvas width for consistent signature sizing.
- Show a colour/size toolbox so signers can adjust the pen live.
- Offer a clear/reset button so a signer can redo a signature.
- Choose a transparent background so a signature overlays cleanly.
- Serve the signature_pad library from a CDN with zero local install.
- Serve signature_pad from a locally hosted copy for offline/air-gapped sites.
- Store CKEditor signatures under a configurable subdirectory (e.g. inline-images).
- Support Drupal 8 through 12 with a single release.
- Reuse core image-field settings (alt/title fields, resolution, file directory).
