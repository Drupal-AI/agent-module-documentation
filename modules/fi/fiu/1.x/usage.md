<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Image Upload (fiu) defines an image widget, providing an enhanced image-upload field widget, with a UI submodule.

---

Uploading images through a nicer widget — drag-and-drop, preview — improves the editorial experience. FIU defines an image widget, with a `fiu_ui` submodule. It is a form-widget for image fields. The security consideration for any upload widget is the underlying field's settings: allowed extensions, max size, and public vs private storage are the real controls, enforced by the field regardless of the widget. So confirm the image field restricts extensions and size appropriately; the widget improves the UX, it does not change what is accepted.

---

- Upload images with a better widget.
- Drag and drop images.
- Preview image uploads.
- Enhance the image field widget.
- Use the FIU widget.
- Confirm field extension limits.
- Confirm max upload size.
- Use private storage if sensitive.
- Improve upload UX.
- Add an image widget.
- Handle image uploads.
- Rely on field-level upload controls.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.