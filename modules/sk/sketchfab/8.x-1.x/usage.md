<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sketchfab adds a dedicated field type for embedding Sketchfab 3D models. Editors paste a Sketchfab model URL into the field's URL widget, and the formatter renders it as a responsive `<iframe>` pointing at the model's `/embed` view.

Use it to embed interactive 3D models on nodes or other entities without hand-writing iframe markup.

---

Install the module and add a "Embed Sketchfab" field to any entity/bundle. The field uses the "URL of the target" widget (an HTML5 url input) to capture the model URL, and the "Iframe" formatter to display it.

On display, the formatter emits a fixed 640x480 iframe with `src="{{ url }}/embed"` (the stored value with `/embed` appended) inside a `.sketchfab-embed-wrapper`. The URL is rendered through a Twig inline template (auto-escaped in the attribute). No routes, permissions, services or settings are added.

---

- Embed Sketchfab 3D models on content.
- Provide a dedicated Sketchfab field type.
- Capture the model URL via an HTML5 url widget.
- Render the model in an iframe `/embed` view.
- Support multi-value fields (multiple models).
- Wrap each embed in a styled container div.
- Reuse the field on any entity type/bundle.
- Allow fullscreen and VR iframe attributes.
- Store the URL as a text column.
- Treat empty values as an empty field.
- Require no configuration or permissions.
- Work on Drupal 8, 9 and 10.
- Keep markup lightweight (single iframe per value).
- Let site builders control field cardinality.
- Integrate with the standard Field UI.
- Display a settings summary describing the formatter.
