<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Direct browser-to-S3 CORS upload

Lets a `managed_file` field upload straight from the browser to S3, bypassing the PHP/web
server (good for large files). Three things must all be true for it to activate on a field:

1. The target scheme's `config.cors` is `TRUE` in settings.php (see scheme.md).
2. The bucket has CORS rules allowing the site origin (template: `s3-cors-example.json` —
   `aws s3api put-bucket-cors …`, allowing `GET/PUT/POST/DELETE` and headers `Accept`,
   `Content-Type`, `Origin`).
3. The current user has the **`use S3 CORS upload`** permission.

## How it wires into a form element

`hook_element_info_alter()` → `S3CorsManagedFileHelper::alterInfo()` adds pre/post process
callbacks to the `managed_file` element type. On process (`preProcessCors`):

- Skips if `#s3_cors` is explicitly `FALSE` on the element.
- If `#upload_location`'s scheme passes `isCorsAvailable()` (scheme driver `s3` + `config.cors`
  + user has the permission), it sets `#s3_cors = TRUE`, disables the normal progress
  indicator, attaches library `flysystem_s3/drupal.s3_cors_upload`, and sets `#s3_acl`
  (defaults to the scheme's `options.ACL`, else `private`).
- `postProcessCors` adds data attributes read by `flysystem_s3.js`:
  `data-s3-acl`, `data-s3-destination` (the upload location), `data-flysystem-s3-cors`, and
  `data-valid-extensions`.

Element properties you can set: `#s3_cors` (force off with `FALSE`), `#s3_acl` (override ACL).

## Runtime endpoints (POST only, permission `use S3 CORS upload`)

| Route | Path | Controller method | Does |
|---|---|---|---|
| `flysystem_s3.cors_sign` | `/flysystem-s3/cors-upload-sign` | `signRequest` | Builds a presigned `PostObjectV4` policy (acl, bucket, `starts-with $key`, `starts-with $Content-Type`, +5h expiry) and returns form attributes/inputs + the sanitized destination URL. |
| `flysystem_s3.cors_save` | `/flysystem-s3/cors-upload-save` | `saveFile` | After the browser PUT/POSTs to S3, creates a Drupal `File` entity from the posted `url`/`filesize`/`filename`/`filemime`, owned by the current user, and returns its `fid`. |

## JS flow (`flysystem_s3.js`, `Drupal.flysystemS3`)

On file selection the JS POSTs filename/destination/acl/content-type to the sign endpoint,
uses the returned presigned policy to upload the file directly to the S3 bucket, then POSTs the
resulting object info to the save endpoint to obtain a managed File id that the form submits.
