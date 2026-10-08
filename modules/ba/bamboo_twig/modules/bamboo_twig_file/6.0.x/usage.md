<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - File adds a Twig function to build an absolute file URL from a stream URI and a filter to guess a file extension from a MIME type.

---

This submodule of Bamboo Twig registers, on service `bamboo_twig_file.twig.file`, the function `bamboo_file_url_absolute(uri)` — which turns a stream URI (e.g. `public://logo.png`) or shipped path into an absolute web URL via the file URL generator, returning already-absolute or root-relative strings unchanged and FALSE when no stream wrapper matches — and the filter `bamboo_file_extension_guesser`, which returns the best-guess file extension for a MIME type using Symfony's MimeTypes. Together they help templates output correct file links and derive extensions without preprocess code.

---

- Output an absolute URL for an uploaded image's `public://` URI in an `<img>` tag.
- Build absolute file links for emails or feeds where relative URLs fail.
- Generate an absolute URL for a downloadable document field.
- Convert a `private://` or `public://` URI to a browsable URL in a template.
- Leave already-absolute (`http`/`https`) URLs untouched when normalising links.
- Produce canonical absolute media URLs for social sharing meta tags.
- Guess a file extension from a stored MIME type (`'image/png' | ... => png`).
- Label a download link with its file type derived from `filemime`.
- Choose an icon based on a file's guessed extension.
- Display "PDF" / "DOCX" badges computed from MIME types.
- Derive an extension when a filename is missing but the MIME type is known.
- Build absolute URLs for image-style derivatives referenced in templates.
- Provide absolute asset URLs in a decoupled/JSON template context.
- Normalise file URLs across environments with different base paths.
- Show the correct file extension in a media listing.
- Avoid a preprocess hook just to absolutise one file URL.
- Output absolute URLs for RSS enclosure links.
- Compute a file-type CSS class from a MIME type.
