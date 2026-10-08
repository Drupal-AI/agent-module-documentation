<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brandfolder deeply integrates Drupal with the Brandfolder Digital Asset Management (DAM) platform, letting editors browse Brandfolder assets, generate Drupal media/files on demand, and serve image-style derivatives straight from the Brandfolder Smart CDN.

---

Brandfolder bridges the Brandfolder DAM into Drupal's Media system. It adds a `brandfolder_image` media source, a live JavaScript asset browser (usable via Media Library and the Entity Browser module), and a `bf://` stream wrapper plus a custom `brandfolder` image toolkit so standard Drupal image styles (crop, scale, convert, quality, WebP/format-auto) are applied by rewriting Brandfolder CDN URLs rather than processing local files. Assets browsed by editors become real Drupal `file` and `media` entities on selection, backed by a `brandfolder_file` mapping table. API access is provided by the bundled `brandfolder/brandfolder-sdk-php` SDK; API keys are held via the Key module (three roles: admin, collaborator, guest). A one-way (Brandfolder → Drupal) metadata sync keeps alt text and mapped fields up to date, driven both on media presave and by an incoming webhook listener that dispatches `BrandfolderWebhookEvent`s. Configuration lives at `/admin/config/media/brandfolder` (`brandfolder.settings`): Brandfolder ID, key references, metadata sync mode, an alt-text custom-field mapping, CDN delivery options (format=auto, auto-WebP, quality), and verbose logging.

---

- Connect a Drupal site to a Brandfolder organization/Brandfolder using API keys stored via the Key module.
- Use separate admin, collaborator, and guest Brandfolder API keys for least-privilege access.
- Add a `brandfolder_image` media source and create one or more custom media types for image assets.
- Browse and search Brandfolder assets inside the Media Library "insert media" dialog.
- Use the Brandfolder asset browser through the Entity Browser module (`brandfolder_browser` widget).
- Restrict a media type to specific Brandfolder collections, sections, or labels via the Gatekeeper.
- Filter the browser by collection, section, label, tag, aspect ratio, file type, and date ranges.
- Auto-generate Drupal `file` and `media` entities for selected Brandfolder attachments.
- Serve images directly from the Brandfolder Smart CDN instead of storing originals in Drupal.
- Apply standard Drupal image styles (crop, scale, resize, scale-and-crop, convert) via CDN URL rewriting.
- Deliver optimized formats with `format=auto`, automatic WebP, and a configurable JPEG/compression quality.
- Reference Brandfolder images from ordinary core Image fields (not only media reference fields).
- Map Brandfolder metadata (including a custom alt-text field) onto Drupal media/image fields.
- Keep Drupal alt text and mapped fields in sync one-way from Brandfolder on media presave.
- Receive Brandfolder webhooks to react to asset create/update/delete events.
- Let other modules react to Brandfolder events by subscribing to `BrandfolderWebhookEvent` (`asset.update`, etc.).
- Alter generated Brandfolder file/CDN URLs with `hook_brandfolder_file_url_alter()`.
- Preview a Brandfolder collection from the settings form to verify connectivity.
- Provide a Brandfolder-aware MIME-type guesser for `bf://` files.
- Grant browsing/creating rights with the `read brandfolder assets` and `create brandfolder assets` permissions.
- Enable verbose logging to debug API traffic (API keys are redacted in SDK logs).
- Maintain a `brandfolder_file` table mapping Drupal file IDs to Brandfolder asset/attachment IDs.
- Set image alt text inline in the browser via an AJAX command.
