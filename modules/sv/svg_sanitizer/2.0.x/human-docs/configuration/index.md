# Configuration

SVG Sanitizer has no global settings page — all of its configuration is
per‑field, on the **Manage display** tab, by choosing its formatter. What you
"configure" is which displays render SVGs through the sanitizer and, optionally,
which extra tags and attributes to allow.

## Select the formatter

1. Go to **Structure**, pick the entity type and bundle whose field holds SVG
   files, and open **Manage display**.
2. Pick the view mode you want to secure (Default, Full, Teaser, and so on — each
   view mode is configured separately).
3. Find the SVG field (a core **File** field, or an `svg_icon` / `svg_image_field`
   field) and set its **Format** to **SVG Sanitizer**.
4. Save.

From now on, that field renders its SVG **inline** on that view mode, cleaned by
the sanitizer.

## The two settings

Click the formatter's gear icon to reveal its settings. Both are optional and both
**add to** the library's built‑in allow‑lists (they never remove anything):

- **Allowed Tags** — a comma‑separated list of extra SVG element names to permit
  beyond the library defaults. Use this when a legitimate SVG feature you need
  (for example a filter or animation element) is being stripped.
- **Allowed Attributes** — a comma‑separated list of extra attribute names to
  permit beyond the defaults.

Because these are per‑formatter, you can even use different allow‑lists on
different view modes of the same field (a stricter list on teasers, a looser one
on full pages, say).

## Security notes — read these

SVG Sanitizer is a security tool, so how it works matters:

- **Display‑time only.** Sanitization happens only when this formatter renders the
  file. There is no upload‑time cleaning — the original file on disk is unchanged.
  Any other display of the same file (a download link, a plain image formatter,
  another SVG renderer) serves the **original, unsanitized** bytes. Apply this
  formatter on **every** display where an untrusted SVG is shown inline.
- **Widening the allow‑lists reduces safety.** The cleaned output is marked as
  trusted markup and is not re‑escaped, so its safety depends entirely on the
  allow‑lists. Adding dangerous items — re‑allowing `script`, or `on*` event
  handler attributes — reintroduces the exact XSS risk you installed this module
  to prevent. Only add elements and attributes you genuinely trust.
- **Consider upload‑side controls too.** For defense in depth, pair this with a
  module that validates file extensions and scans uploads, so untrusted content is
  caught before it is stored, not only when it is displayed.
