<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alt Text Generator adds a "Generate Alt Text" button to image-field widgets that fills the alt attribute using an external AI vision service.

---

Alt Text Generator integrates with Drupal's core image widget: when an image field is rendered with the alt field enabled and an image already uploaded, the module attaches a button that sends the file to the Alt Text Generator service (alttextgeneratorai.com) and writes the returned description straight into the field's alt input, which the editor can then keep or edit. Generation runs through a module route that base64-encodes the managed image and calls the vendor API with the site's stored API key and a chosen language. A settings form at `/admin/config/content/alt-text-generator` holds the API key and default language (34 languages available) and shows the remaining credit balance the service reports. The module depends on core Image, needs an API key from the vendor, and supports Drupal 10 and 11.

---

- Generate descriptive alt text for uploaded images with AI.
- Add a "Generate Alt Text" button next to the alt field on image widgets.
- Populate the alt attribute automatically instead of writing each one by hand.
- Let editors accept, tweak, or overwrite the generated text.
- Speed up alt-text authoring across a large media library.
- Improve accessibility of images for screen-reader users.
- Support alt-text SEO for image-heavy pages.
- Choose a default generation language from 34 options (English, Spanish, French, German, Chinese, Japanese, Arabic, and more).
- Generate alt text per image directly on the node/entity edit form.
- Work with core image fields on any content, media, or custom entity.
- Store the vendor API key and language on a single admin settings page.
- See remaining API credits reported by the service on the settings form.
- Verify the configured API key against the vendor before saving work.
- Handle common image formats (JPEG, PNG, GIF, WEBP, AVIF, SVG).
- Show a throbber and disable the alt field while a generation runs.
- Fall back to a warning message if the service is unreachable.
- Configure once and reuse the button across every image field on the site.
- Reduce manual accessibility remediation effort for editors.
- Fill missing alt text when migrating or bulk-editing image content.
- Depend only on core Image, with no extra contrib modules required.
