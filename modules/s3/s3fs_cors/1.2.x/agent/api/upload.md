# The direct-to-S3 upload flow

## 1. Form render — presign a POST policy

`S3fsCorsFile` (`@FormElement("s3fs_cors_file")`, extends core `ManagedFile`) is the element behind
both widgets. `processManagedFile()`:

- Reads `s3fs.settings` (bucket, region, folders, credentials) and `s3fs_cors.settings` (ACL).
- Computes the S3 object key from `#upload_location` (maps `public://`/`private://` to the s3fs
  folders, prepends `root_folder`), then rewrites `#upload_location` to `<bucket>::<key>`.
- Resolves credentials (static keys, AWS provider chain, or an STS `getFederationToken` session).
- Builds a **Signature V4 presigned POST policy** (`expiration` = now + 6h; conditions:
  bucket, acl, `starts-with $key`, `starts-with $Content-Type`, `success_action_status=201`,
  `x-amz-algorithm`, `x-amz-credential`, `x-amz-date`, `x-amz-expires=21600`, optional
  `x-amz-security-token`), base64-encodes it, and computes the HMAC-SHA256 signature.
- Emits everything (policy, signature, credential, date, ACL, form action host, max size, extension
  list, element parents) into `drupalSettings.s3fs_cors[<field_name>]`, attaching library
  `s3fs_cors/cors.file`.

## 2. Browser — POST straight to S3

`s3fs_cors.js` reads the drupalSettings, validates extension + size client-side, and POSTs the file
directly to the bucket endpoint (`<scheme>://<bucket>.<host>/`) with the presigned form fields. S3
returns 201 on success.

## 3. AJAX routes back to Drupal

| Route | Controller | Purpose |
|---|---|---|
| `s3fs_cors.cors_key` (`/ajax/s3fs_cors_key/{directory}/{file_name}/{file_size}/{file_index}`) | `AjaxController::getKey` | Sanitizes the filename, checks S3 for an existing object, and returns a (deduplicated/renamed) object key as JSON. |
| `s3fs_cors.cors_save` (`/ajax/s3fs_cors_save/{file_path}/{file_name}/{file_size}/{field_name}`) | `AjaxController::saveFile` | Writes the URI into the s3fs metadata cache (`S3fsStream::writeUriToCache`) and creates a `File` entity (status 0, owner = current user), running `hook_file_validate`. Returns fid/uuid JSON. |

`getKey` dedupes by scanning the `s3fs_file` cache table and probing S3 (`doesObjectExistV2`).
`saveFile` reverses the folder mapping to reconstruct the `public://`/`private://` (or `s3://`) URI
before creating the managed file. Both AJAX routes use `_permission: 'access content'`.
