<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Format Bytes registers a single Twig filter, `format_bytes`, that turns a raw byte count into a human-readable size string (e.g. `1048576` → "1 MB") for use in any Twig template.

---

The module is a one-class Twig extension and nothing else: no admin UI, no configuration, no permissions, no services beyond the Twig extension, no config schema, and no dependencies outside Drupal core. Its service `format_bytes.twig_extension` (`Drupal\format_bytes\Twig\ByteConversionTwigExtension`) is tagged `twig.extension` and exposes exactly one filter named `format_bytes`. That filter maps directly to Drupal core's `Drupal\Core\StringTranslation\ByteSizeMarkup::create()`, so the output is the same translatable, locale-aware markup core uses for file sizes (bytes, KB, MB, GB, TB, PB), including decimals for non-round values (e.g. `1234567890` → "1.15 GB"). You use it inside a template by piping a numeric byte value through it: `{{ node.field_file.entity.filesize.value | format_bytes }}`. Because it is purely presentational and stateless, it changes nothing about how data is stored — it only formats a number at render time. It is effectively a convenience shortcut that saves theme developers from having to preprocess a filesize value in PHP just to display it.

---

- Display a managed file's raw `filesize` value as a friendly "2.4 MB" in a node template.
- Show the size of an attachment next to its download link in a field template.
- Render media entity file sizes in a media template without a preprocess hook.
- Format the total size of a multi-file upload summary in a custom Twig template.
- Present image dimensions/weight in a gallery template so editors see file heft.
- Convert a byte count stored in a computed field into a readable label in Twig.
- Show quota usage ("You have used 512 MB") by piping a stored byte total through the filter.
- Display disk-usage figures pulled into `drupalSettings` or a custom variable in a template.
- Label backup/export file sizes in an admin listing template.
- Format a `content-length` value in an API-response preview template.
- Show per-user storage consumption in a profile template.
- Render the size of a video or audio media asset in a player wrapper template.
- Add readable file weights to a search result row template.
- Present the size of a document in a document-library view row.
- Format byte totals in a dashboard block built with a Twig template.
- Avoid writing a custom Twig extension when all you need is a byte formatter.
- Reuse core's exact `format_size()` output (and translations) inside your theme.
- Show attachment sizes in an email/HTML template rendered through Twig.
- Display the size of a generated PDF or ZIP in a confirmation page template.
- Keep templates locale-aware by delegating size formatting to core's `ByteSizeMarkup`.
- Format a filesize inside a Paragraphs or Layout Builder component template.
- Present cache or log file sizes in a custom reporting template.
- Show the weight of a remote/downloaded file in an integration's display template.
- Provide a consistent, human-readable size format across an entire theme with one filter.
