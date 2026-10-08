<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Citation — agent index

`ckeditor_citation` (project **ckeditor_citation**, version **1.0.1**, package `CKEditor5`).
A small **client-side CKEditor 5 plugin** that adds one toolbar button to toggle the semantic
HTML `<cite>` tag around text. No PHP, no routes, no config form, no permissions, no dependencies
beyond Drupal core's CKEditor 5.

`core_version_requirement: ^10 || ^11 || ^12`. `composer require drupal/ckeditor_citation`,
`drush en ckeditor_citation`.

## What it does
Provides a single CKEditor 5 toolbar item, **Citation CKE5** (`citationCke5`). Clicking it toggles
the `<cite>` inline element on the current selection (or, if the selection is collapsed, on the text
typed next until the button is clicked again). Clicking on already-cited text removes the tag. Intended
for citing creative works (books, music, artworks, films). It does NOT open a dialog, insert a source
URL, or add attributes to `<cite>` — it only marks text as `<cite>…</cite>`.

## How it is wired (all declarative + JS)
- `ckeditor_citation.ckeditor5.yml` — defines the CKEditor 5 plugin `ckeditor_citation_citation_cke5`:
  JS plugin `citationCke5.CitationCke5`, label `Citation CKE5`, toolbar item `citationCke5`,
  `elements: false` (the plugin declares no allowed elements of its own), main library
  `ckeditor_citation/citation_cke5`, admin library `ckeditor_citation/admin.citation_cke5`.
- `ckeditor_citation.libraries.yml` — `citation_cke5` (minified built JS `js/build/citationCke5.js`,
  depends on `ckeditor5/ckeditor5`); `admin.citation_cke5` (CSS that sets the toolbar button icon).
- `js/ckeditor5_plugins/citationCke5/src/`:
  - `CitationCke5.js` — the `Plugin`. Registers the `citationCke5` command and a `ButtonView`,
    extends the model schema so `$text` allows the `cite` attribute, and adds an `attributeToElement`
    conversion mapping model attribute `cite` ⇄ view `<cite>` (with `upcastAlso` so existing `<cite>`
    HTML upcasts into the attribute).
  - `CitationCommand.js` — `execute()` toggles the `cite` attribute on the selection or valid ranges;
    `refresh()` sets `isEnabled = true` (always enabled) and `value` = whether the selection is cited.
  - `index.js` — exports `{ CitationCke5 }` for CKEditor 5 discovery.
- `icons/cite.svg`, `css/citation-cke5.admin.css` — toolbar button icon.

## Enabling it
No config page (`configure: null`). Add the **Citation CKE5** button to a CKEditor 5 toolbar at
`admin/config/content/formats` → configure a format → drag the button into the Active toolbar → Save.
For the `<cite>` markup to survive filtering, the format's Allowed HTML tags must include `<cite>`.
The plugin itself does NOT widen the allowed-tags set (`elements: false`), so this is a manual step.

## Notes for agents
- Trivial module: a single `agent/start.md` is the complete agent surface — there are no APIs, blocks,
  services, or config schema to document (`provides_config_schema: false`, `provides_permissions: false`).
- The README claims "Drupal 12 compatibility assumed based on current API usage. Formal testing pending",
  matching `core_version_requirement: ^10 || ^11 || ^12`.
- No access-control role; it is an editor-experience button. Restrict to trusted text formats as with
  any markup-inserting plugin.

## Related docs
- Human setup guide: `../human-docs/index.md`
- Prose overview: `../usage.md`
