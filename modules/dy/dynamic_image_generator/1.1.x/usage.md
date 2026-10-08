<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Image Generator turns HTML/CSS "Image Template" entities into rendered images, filled from Drupal tokens and Twig, and stores each result as a media entity.

---

The module defines a custom content entity `poster_entity` ("Image Template") with HTML, CSS, template-image, target-content-type and target-field fields. When an image is generated for a node, the template's `[node:*]` tokens, uploaded-image tokens (`[image_1]`, `[image_2]`, `[image_random]`), site-defined custom tokens and Twig markup are resolved, then the combined HTML/CSS is rendered to a PNG/JPEG. Rendering uses one of two providers chosen on the settings form: the external HTML/CSS-to-Image API (htmlcsstoimage.com / `hcti.io`, using an API user ID + key) or, if the bundled `image_creating_engine` submodule is enabled, a local `wkhtmltoimage` binary ("Built-in Image Engine"). Generated images become `dynamic_image` media entities; editors can have a template auto-write its image into a node image/media field by ticking a checkbox added to the node edit form. The module also ships a Views gallery of generated images, an admin overview/example/diagnostic pages, and a settings form for API credentials, custom-token definitions and debug logging. Core deps: file, image, media, node, user, views, field, system. The Token module is suggested for the in-form token browser.

---

- Render a styled "poster" / social-share image from a node's title and fields whenever content is saved.
- Design an image layout once as HTML + CSS and reuse it across many nodes of a content type.
- Insert live content into images with Drupal tokens such as `[node:title]`, `[node:body]`, `[node:field_subtitle]`, `[node:author:name]`, `[node:created:medium]`, `[site:name]`.
- Reference uploaded template background/foreground images via `[image_1]`, `[image_2]`, ... or a random one via `[image_random]`.
- Use Twig conditionals and loops inside a template for richer, data-driven layouts.
- Define reusable "Custom Dynamic Tokens" in settings that pull a chosen field (or a sub-field of a referenced entity) from the node at generation time.
- Pick a random value from a multi-value field for a custom token (e.g. rotate a quote or speaker).
- Auto-generate and save an image into a node's image field on save via the per-template "Auto-generate Image" checkbox on the node form.
- Save generated images into a media-reference field instead of a plain image field.
- Generate business-card, event-banner, quote-card or social-media-post images from structured content.
- Switch between an external rendering API and a local `wkhtmltoimage` engine without changing templates.
- Store every generated image as a reusable `dynamic_image` media entity with source-node and template references.
- Browse all generated images in the admin gallery at Content → Generated Images, sorted by date.
- Preview a template with sample data or with a selected real node before committing to a field.
- Configure the external API provider, user ID, key and endpoint from a single settings form.
- Set the module to log detailed request/response info by enabling Debug Mode for troubleshooting.
- Run built-in diagnostics to test Chrome/Chromium and `wkhtmltoimage` availability on the server.
- Automatically clean up preview-only generated images via cron (removed after 24 hours).
- Restrict who can manage templates, generate images and view the gallery through dedicated permissions.
- Produce consistent, on-brand imagery for many pages without a designer touching each one.
- Extend the token set for image generation from custom code via the module's service API.
