# Configuration

File Upload Secure Validator validates every upload automatically — there is
nothing to turn on per field. The one thing you configure is the list of **MIME
type equivalence groups**: sets of MIME types that should be treated as
interchangeable, so a legitimate file whose sniffed content type differs from its
extension's type is not wrongly rejected.

## How the check works, briefly

For each uploaded file the module compares two things: the MIME type guessed from
the filename's extension, and the MIME type sniffed from the actual bytes with
`fileinfo`. If they match, the file passes. If they differ, the module checks
your equivalence groups — and passes the file only if *both* types appear in the
same group. Otherwise the upload is rejected and the mismatch is logged.

## Open the settings form

1. Log in as a user with the **Administer File Upload Secure Validator
   configuration** permission (this is a security‑sensitive permission — grant it
   only to trusted admin roles).
2. Go to **Configuration → Media → File Upload Secure Validator**, or navigate
   directly to `/admin/config/media/file_upload_secure_validator`.

## The equivalence groups field

The form has a single textarea, **MIME types equivalence group(s)**, in a simple
CSV format:

- **One group per line.**
- **MIME types separated by commas** within a line.

For example:

```
text/csv,text/plain,application/csv
text/xml,application/xml
image/svg+xml,image/svg
```

Each line says "these types are equivalent — if a file's extension type and its
sniffed type both appear here, allow it." Click **Save configuration** to store
the list. The settings live in the exportable `file_upload_secure_validator.settings`
config object, so they deploy with the rest of your configuration.

## Default groups (shipped ready to use)

Out of the box the module pre‑seeds groups so common legitimate files pass
without any tuning:

- **CSV** — includes `text/csv`, `text/plain`, `application/csv`,
  `application/vnd.ms-excel`, `application/octet-stream`, and several other
  spreadsheet/plain‑text variants.
- **XML** — `text/xml`, `text/plain`, `application/xml`.
- **SVG** — `image/svg+xml`, `image/svg`.
- **gettext `.po`** — `text/x-po`, `application/octet-stream`.
- **Certificates / PKCS** — `.pem`, `.crt`, `.p12`, PGP keys and related
  certificate types that resolve to generic MIME types.
- **Office (DOCX/XLSX)** — the OpenXML Word and Excel types plus
  `application/octet-stream`, which is how many Office files sniff.

## Whitelisting a wrongly‑rejected file type

If a valid file is being blocked:

1. Try to upload it once so the rejection is logged.
2. Read the log entry on the **`file_upload_secure_validator`** channel (Reports →
   Recent log messages, if the Database Logging module is on). It reports both
   MIME types — the one guessed from the extension and the one sniffed from the
   content.
3. Add **both** of those MIME types to the same line (group) on the settings
   form, and save.

That file type will now pass validation. Take care to only group types you truly
consider equivalent — the whole point of the module is to reject disguised files,
so overly broad groups weaken the protection.

## Who can edit this

Editing the groups is gated by the **Administer File Upload Secure Validator
configuration** permission (machine name
`administer file upload secure validator configuration`), which is flagged as
security‑sensitive. The upload‑time validation itself is *not* permission‑gated —
it runs for every user and every upload. This permission only controls who may
change the equivalence groups.
