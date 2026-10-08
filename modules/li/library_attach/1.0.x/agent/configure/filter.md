<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling the "Library scanner" filter on a text format

There is **no settings page and no `configure` route** for this module. All "configuration" is
turning the filter on for the text formats where you want automatic library attachment, and (for the
libraries themselves) declaring selectors in `*.libraries.yml` — see
[../api/library-selectors.md](../api/library-selectors.md).

## Steps

1. Go to **Administration › Configuration › Content authoring › Text formats and editors**
   (`/admin/config/content/formats`) and edit the format used by the content that should auto-attach
   libraries (e.g. Full HTML, Basic HTML).
2. Under **Enabled filters**, check **"Library scanner"** (filter id `library_attach`).
3. This filter has **no settings** of its own — there is no settings fieldset under "Filter settings"
   for it (the plugin defines no settings form).
4. **Filter order matters for what gets scanned.** The filter reads the HTML as it exists at its
   position in the processing pipeline, so place "Library scanner" **after** any filter that
   generates or embeds the markup you want to match (e.g. "Convert line breaks into HTML", media/
   entity embed filters). Its own output equals its input, so nothing downstream is affected by where
   you put it beyond what HTML it can see.
5. Save the format, then rebuild caches after any later change to a library's `filter-selector-*`
   key (`drush cr`) — the selector map is cached under the `library_info` tag.

## What it does once enabled

- On every render of content in that format, the filter matches the HTML against the discovered
  selector map and attaches matching libraries via `FilterProcessResult::addAttachments()`; the
  stored/displayed text is unchanged.
- The full text-format help ("About text formats", long tips) lists the libraries currently
  attachable, via `tips($long = TRUE)` — useful to confirm a new selector was picked up.

## Notes / caveats

- Attachable libraries are limited to those a developer opted in with `filter-selector-css` /
  `filter-selector-xpath`; enabling the filter does not let editors name or load arbitrary
  libraries — content can only trigger one of the pre-declared selectors.
- Only `core`, enabled modules, and the active theme are scanned for selectors (see the API topic),
  so a library must live in an enabled/active extension to be attachable.
