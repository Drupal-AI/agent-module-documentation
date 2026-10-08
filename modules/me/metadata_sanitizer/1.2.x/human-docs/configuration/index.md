# Configuration

Metadata Sanitizer works as soon as it is enabled — by default it sanitizes files
on upload. The settings form lets you tune that behaviour, and a Drush command
cleans files you already have.

## Open the settings form

1. Log in as a user with the **administer metadata sanitizer** permission (not
   granted by default — assign it at **People → Permissions**).
2. Go to **Configuration → Media → Metadata Sanitizer**, or navigate directly to
   `/admin/config/media/metadata-sanitizer`.

The form first confirms whether the **exiftool binary** is available; if it is not,
install it (see [Installation](../installation/index.md)) before continuing.

## Settings

- **Automatic sanitization on upload** — the core behaviour, on by default. When
  enabled, every matching file is stripped of metadata as it is uploaded, and
  re-sanitized on file replacement when the underlying URI changes. Turn it off if
  you would rather clean only on demand via Drush.
- **File extensions** — the list of extensions to sanitize. Limit it to the file
  types you care about (for example `jpg,jpeg,png,pdf`) so unrelated uploads are
  left untouched.
- **Preserve timestamps** — when enabled, exiftool keeps the file's original
  modification time (`exiftool -P`) instead of updating it during sanitization.

Save the form to apply your choices.

## Bulk-cleaning existing files (Drush)

New uploads are handled automatically, but files already in your library need a
one-time pass. The `metadata_sanitizer:clean` Drush command does this, with
filters so you can target exactly the files you want:

```bash
drush metadata_sanitizer:clean --extensions='jpg,jpeg,png,pdf'
drush metadata_sanitizer:clean --mime='image/jpeg,application/pdf'
drush metadata_sanitizer:clean --pattern='/^invoice_/'
drush metadata_sanitizer:clean --field=field_document
```

> **Bulk cleaning is irreversible** — removed metadata cannot be recovered. For
> large libraries, run it from the CLI rather than the UI, since a web request may
> time out. (Prefix with `ddev` if you run it from your DDEV host.)

## A note on privacy

Stripping this metadata is a data-minimisation measure: GPS coordinates, camera
identifiers, and author names embedded in uploads are personal data, and removing
them before storage or delivery helps meet GDPR and similar obligations. Once
sanitized, the data is gone from the file for good.
