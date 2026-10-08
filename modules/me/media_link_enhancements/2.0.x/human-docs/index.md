# Media Link Enhancements — manual setup guide

**Media Link Enhancements** (`media_link_enhancements`) changes how links to core
**Media** entities behave. Out of the box, a link to a media item points at its
`/media/{id}` page. This module can instead point that link straight at the
underlying file, append the file's type and size to the link text (for
accessibility), add a `download` attribute, redirect the media page to the source
file, or serve the raw file directly as a binary response.

It bundles five independent features, each turned on separately and scoped to the
media bundles (and optionally file extensions) you choose:

- **Direct linking** — rewrite media links to the file path (for example
  `/sites/default/files/report.pdf` instead of `/media/1234`), optionally adding a
  `download="report.pdf"` attribute.
- **Type/size appending** — add text like ` [PDF/12KB]` to link text, useful for
  508 / WCAG accessibility, with configurable prefix, separator, suffix, and case.
- **Redirection** — make the `/media/{id}` page issue a 303 redirect to the source
  file.
- **Binary response** — stream the source file inline at `/media/{id}` instead of
  showing the media page.
- **Content parsing** — apply the direct-linking and type/size logic to media links
  embedded inside WYSIWYG text fields.

Only **published** media in an allowed bundle are affected, and each feature
respects your extension allow-lists. One prerequisite: core Media's **Standalone
media URL** setting must be enabled. There is also an optional **Linkit** matcher so
media picked via Linkit can carry the direct-link flag.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and turn on the Standalone media URL prerequisite.

## Where it lives in the admin menu

All five features are configured on a single settings form at **Configuration →
Media → Media Link Enhancements** (`/admin/config/media/media_link_enhancements`),
gated by the **Administer media link enhancements** permission.

## How to use it

Every feature ships **off** by default. On the settings form, tick the enable
checkbox for the feature you want, then scope it:

1. **Choose the feature(s)** — direct linking, type/size appending, redirection,
   binary response, and/or content parsing. They are independent and can be
   combined (for example appending *and* direct linking on the same field gives a
   described, direct-download link).
2. **Scope to bundles** — each feature has a checkbox list of media types it applies
   to (some features, like type/size appending and binary response, are limited to
   file-based bundles such as image, file, audio, and video).
3. **Scope to extensions** — each feature has a comma-separated, case-insensitive
   extension list (for example `pdf,doc,zip`); leaving it empty means all
   extensions.
4. **Tune the details** — type/size appending lets you set the prefix, separator,
   suffix, and an uppercase option (so `[PDF/12KB]` rather than `[pdf/12kb]`);
   direct linking lets you add the `download` attribute and limit it to certain
   extensions; content parsing lets you pick which text field types are scanned.

Note that **Redirection takes precedence over Binary response** if both are enabled
for the same media. After changing settings, clear caches (`drush cr`) for some
changes to take effect. And remember the whole module depends on core Media's
**Standalone media URL** being enabled — the form warns you if it is off.
