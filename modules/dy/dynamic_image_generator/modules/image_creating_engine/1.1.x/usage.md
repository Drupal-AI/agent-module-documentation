<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Creating Engine is the local, wkhtmltoimage-based rendering backend for Dynamic Image Generator.

---

This submodule lets Dynamic Image Generator render images on the server instead of calling an external API. When enabled, the parent module's settings form gains a "Built-in Image Engine (Local)" provider option. Choosing it routes generation to the `image_creating_engine.generator` service (class `InbuiltImageGenerator`), which builds a complete HTML document from the parent module's rendered HTML/CSS, writes it to a temp file, and runs the `wkhtmltoimage` binary to produce a PNG/JPEG, saved as a managed Drupal file. It requires the wkhtmltopdf/wkhtmltoimage package to be installed on the host. It depends on the parent `dynamic_image_generator` module and adds no routes, permissions or config of its own.

---

- Generate template images locally without an external HTML/CSS-to-image API or API key.
- Avoid per-image API costs and outbound calls by rendering with wkhtmltoimage on the server.
- Keep image generation working on networks where outbound API access is blocked.
- Serve as the `inbuilt` provider selected on the Dynamic Image Generator settings form.
- Render the same token/Twig-resolved HTML+CSS templates the parent module produces.
- Produce PNG or JPEG output at a requested width/height (and JPEG quality).
- Use the parent module's diagnostics pages to confirm `wkhtmltoimage` is installed and working.
- Provide an `inbuilt` ImageGenerator plugin for the parent module's plugin structure.
- Fall back cleanly (logs an error, returns nothing) when the binary is missing.
