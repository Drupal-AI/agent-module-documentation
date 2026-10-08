<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Image ID Scan (amazon_image_id_scan) — agent index

Validates images uploaded through a Drupal image field by sending them to **AWS Rekognition**
(`DetectLabels` + `DetectText`) and rejecting the upload when the response does not match an
admin-defined rule set (required labels + confidence %, forbidden labels, regex on OCR text).

## What it provides

- **Field widget** `ImageScanWidget` (plugin id `image_widget`, label "Mi Widget Imagen"),
  `src/Plugin/Field/FieldWidget/ImageScanWidget.php`. Extends core
  `Drupal\image\Plugin\Field\FieldWidget\ImageWidget`; `field_types = { image }`. Runs the scan in
  an `#element_validate` callback (`validateScan()`) on the AJAX upload button.
- **Service** `amazon_image_id_scan.rekognition` → `Drupal\amazon_image_id_scan\Services\Rekognition`
  (`src/Services/Rekognition.php`), constructor arg `@config.factory`. Wraps the AWS SDK
  `RekognitionClient`.
- **Settings form** `ConfigurationForm` (`src/Form/ConfigurationForm.php`), route
  `amazon_image_id_scan.admin_settings` at `/admin/config/amazon_image_id_scan/configuration`,
  permission `administer site configuration`, menu link under Configuration → Media.
- **Config object** `amazon_image_id_scan.settings` (created on first save; the module ships
  **no `config/install` or `config/schema`**).
- **Permission** `amazon_image_id_scan load_s3` (declared in `*.permissions.yml`, `restrict access: true`)
  — declared but **not referenced anywhere in code** (dead).
- **Library** `amazon_image_id_scan.main` (css/main.css only, admin-form styling).

## Dependencies

- Composer: `aws/aws-sdk-php: ^3.294` (bundled AWS SDK; provides `Aws\Rekognition\RekognitionClient`).
- Core `image` module (widget extends the core image widget) — not declared in info.yml but required
  in practice. No other Drupal module dependencies.

## Solution docs

- [config/settings.md](config/settings.md) — the settings form, the `amazon_image_id_scan.settings`
  config shape (credentials + validation profiles), routes & permissions.
- [api/rekognition.md](api/rekognition.md) — the `Rekognition` service: `connect()`, `document()`,
  `text()`, the AWS calls and the label/confidence/regex validation logic.
- [fields/widget.md](fields/widget.md) — `ImageScanWidget`: settings, `formElement()`,
  `validateScan()` and how a validation profile is bound to a field widget.
