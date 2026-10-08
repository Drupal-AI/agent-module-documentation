<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — MIME type equivalence groups

The module's only configuration is a list of "equivalence groups": sets of MIME types that
should be treated as interchangeable so legitimate files whose sniffed type differs from
their extension's type are not rejected (see `api/file_upload_secure_validator.md` for how
groups are consulted during validation).

## Admin form

- Route: `file_upload_secure_validator.file-upload-secure-validator-settings`
- Path: `/admin/config/media/file_upload_secure_validator`
  (Administration → Configuration → Media → File Upload Secure Validator)
- Permission: `administer file upload secure validator configuration`
- Form class: `Drupal\file_upload_secure_validator\Form\SettingsForm`

The form has a single textarea, **MIME types equivalence group(s)**, in CSV format: one
group per line, MIME types separated by commas. Example:

```
text/csv,text/plain,application/csv
text/xml,application/xml
image/svg+xml,image/svg
```

On submit the textarea is decoded with Symfony's `CsvEncoder` and written to config.

## Config object

- Name: `file_upload_secure_validator.settings`
- Key: `mime_types_equivalence_groups` — a sequence of sequences of strings
  (schema: `config/schema/file_upload_secure_validator.schema.yml`).

Read / edit with Drush:

```bash
drush config:get file_upload_secure_validator.settings
drush config:set file_upload_secure_validator.settings mime_types_equivalence_groups.0.0 text/csv -y
```

Or export/import the object as part of your site config. There are no other settings keys.

## Default groups (shipped in config/install)

Groups pre-seeded so common legitimate files pass out of the box:

- **CSV**: `text/csv`, `text/plain`, `application/csv`, `text/comma-separated-values`,
  `application/excel`, `application/vnd.ms-excel`, `application/vnd.msexcel`,
  `text/anytext`, `application/octet-stream`, `application/txt`
- **XML**: `text/xml`, `text/plain`, `application/xml`
- **SVG**: `image/svg+xml`, `image/svg`
- **gettext .po**: `text/x-po`, `application/octet-stream`
- **Certificates / PKCS**: `text/plain`, `application/pkix-cert`, `application/pkix-crl`,
  `application/x-x509-ca-cert`, `application/x-x509-user-cert`, `application/x-pem-file`,
  `application/pgp-keys`, `application/x-pkcs7-certificates`,
  `application/x-pkcs7-certreqresp`, `application/x-pkcs7-crl`, `application/pkcs7-mime`,
  `application/pkcs8`, `application/pkcs10`, `application/x-pkcs12`
- **Office (DOCX/XLSX)**: `application/octet-stream`,
  `application/vnd.openxmlformats-officedocument.wordprocessingml.document`,
  `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`

(Also installed by update hook `file_upload_secure_validator_update_8001` for sites
upgrading from an older release.)

## Tuning

If a valid file is wrongly rejected, read the logged mismatch (`file_upload_secure_validator`
channel) to learn the two MIME types, then add both to the same group on the settings form.
