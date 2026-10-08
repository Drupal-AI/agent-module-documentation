<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — default Open Graph image + token

## Settings form
- **Route:** `og_default_image.settings` → path `/admin/config/search/metatag/og-default-image`.
- **Local task:** appears as a "Default OG Image" tab under Metatag defaults
  (`base_route: entity.metatag_defaults.collection`, weight 5).
- **Permission:** `_permission: 'administer metatags'` (Metatag's own permission — the module
  defines no permission of its own).
- **Form class:** `Drupal\og_default_image\Form\OgDefaultImageForm` (extends `ConfigFormBase`).
- **Config object:** `og_default_image.settings`, key `og_default_image` — a sequence whose element
  `0` holds the file ID of the uploaded image (see `config/schema/og_default_image.schema.yml`).

## Upload field
- **Widget:** `managed_file`, single value.
- **Upload location:** `public://og_default_images/`.
- **Allowed extensions:** `gif png jpg jpeg` (the field's `#description` text only mentions
  png/jpg/jpeg, but the validator also permits `gif`).
- **Size limit:** `5600000` bytes (~5.6 MB).
- **Recommended dimensions (help text):** 1200×630 px.

## Submit behaviour
- On save the file is flagged **permanent** (`$file->setPermanent()`), so it survives temporary-file
  garbage collection.
- If a previously saved image existed and the FID changed, the **old file entity is deleted**
  (`$old_file->delete()`), so replacing the image cleans up the prior one.
- The form injects `file.usage` but does not record a usage entry; persistence relies on the
  permanent flag rather than on file-usage tracking.

## Token
- **Type/token:** `og_default_image` / `[og_default_image:og_default_image]`
  (`og_default_image.tokens.inc`, `hook_token_info` + `hook_tokens`).
- **Resolves to:** the absolute URL of the uploaded file, built via the `file_url_generator`
  service.
- **When no image is set:** the helper `get_og_default_image_path()` returns the literal string
  `Please upload an image` (not an empty string) — worth knowing, since that string would appear
  verbatim in any field where the token is placed before an image is uploaded.
- **Usage:** paste the token into Metatag's global Open Graph image field
  (`/admin/config/search/metatag`, Global defaults → Open Graph → Image) so pages without their own
  image inherit this default.
