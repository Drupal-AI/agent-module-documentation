# commerce_file — setup & configuration

## 1. Add the file trait to a product variation type

At *Commerce → Configuration → Product variation types → {type} → Edit*, enable the **"Provides a
file for download"** trait (`commerce_file`, plugin `ProductVariationCommerceFile`). This adds a
required, unlimited-cardinality **`commerce_file`** file field to the variation type with defaults:

- `uri_scheme: private` (files are stored privately — configure Drupal's private file path).
- `description_field: 1`.
- extensions: `mp4 m4v flv wmv mp3 wav jpg jpeg png pdf doc docx ppt pptx xls xlsx`.

The form alter auto-selects the **`commerce_license`** trait when you pick the file trait (a file
license needs the license trait) and sets the license type to `commerce_file`, showing a message.

## 2. License type

The module registers the `commerce_file` Commerce **license type** (`LicenseType/File`). Purchasing
a variation that has the file trait causes Commerce License to issue an active File license to the
buyer. Per-license config: an optional **`file_download_limit`** integer field (0 = no limit;
overrides the global limit). Granting a license clears the download log (resets limits);
`grantLicense()` calls `DownloadLogger::clear()`.

## 3. Global download-limit settings

Form **`commerce_file.settings_form`** at `/admin/commerce/config/licenses/file`
(*Commerce → Configuration → License → File download settings*), permission
`administer commerce_license`. Config object **`commerce_file.settings`**:

```yaml
enable_download_limit: false   # master switch for the global limit
download_limit: 100            # applied to every licensed file when enabled
```

Precedence (see `LicenseFileManager::getDownloadLimit()`): start at 0 (unlimited); if
`enable_download_limit` is on use `download_limit`; if the license has a non-empty
`file_download_limit` field, that value wins.

Field formatter setting `field.formatter.settings.commerce_file_download_link` →
`use_description_as_link_text` (bool) controls whether the file description replaces the filename in
the download link.

## 4. Checkout pane & customer view

- **"Files download"** checkout pane (`commerce_file_download`, default step `complete`) embeds the
  `commerce_file_my_files` view (display `checkout_complete`) listing the order's active licenses'
  files.
- A **"My files"** view (`views.view.commerce_file_my_files`) gives customers a page of their
  licensed files.
- The download link field formatter (`commerce_file_download_link`) and the
  `commerce-file-download-link.html.twig` template render links to the download route.

## 5. Amazon S3 / Flysystem (optional)

If a file's stream wrapper is `s3` (or a Flysystem scheme whose driver is `s3` with `config.public`
= true), `FileDownloadController::download()` returns a `TrustedRedirectResponse` to the file's
external S3 URL instead of streaming it — after verifying an active license. Configure via the
`flysystem` key in `settings.php`. Note: a public bucket URL is shareable once issued.

## Config entities installed

`config/install/` ships: the `commerce_file` field storage on product variations, the module
settings, a default license view display, and the `commerce_file_my_files` view.
