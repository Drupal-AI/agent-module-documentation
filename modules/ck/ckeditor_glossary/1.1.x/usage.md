<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Glossary

CKEditor 4 button that links selected text to a glossary page anchor.


## What & when

- Use it to turn a selected term into a link to your glossary page (e.g. `/glossary/a#apple`).
- Targets the legacy CKEditor 4 (`ckeditor`) editor.
- The glossary base path is configurable per text format; defaults to `/glossary`.

---

## Install & configure

- `composer require drupal/ckeditor_glossary` then `drush en ckeditor_glossary -y` (needs CKEditor 4 `ckeditor`).
- In a text format's CKEditor settings, add the **Link to Glossary** button and set **Path to glossary page** (e.g. `/my-glossary`).
- The setting is stored under the format's plugin settings (`plugins.ckeditor_glossary.link`, schema type text).
- Allow the `<a href class>` markup in the text format so the produced link survives filtering.
- No permissions or routes.

---

## Usage & behaviour

- Select a word and click the button to wrap it in `<a class="glossary-entry" href="<base>/<firstLetter>#<slug>">`.
- Build cross-references from body content to a central glossary page.
- The anchor slug is the selection normalised (accents stripped, spaces to dashes, lower-cased).
- The first letter of the selection is used as the path segment for letter-based glossary pages.
- If no base path is configured, it falls back to `/glossary` (Drupal's default glossary page).
- The plugin loads `/css/ckeditor_overrides.css` as contentsCss inside the editor.
- Works on the current selection's extracted HTML.
- The link text is the original selected HTML.
- Output is a standard anchor filtered by the text format on render.
- Useful for wikis, documentation, and term-heavy content.
- Per-format configuration means different formats can point at different glossary pages.
- No server-side glossary is created — you provide the glossary page yourself.
- Compatible with other CKEditor 4 plugins.
- Plugin id is `ckeditor_glossary`.
- The button sits in the `insert` toolbar group.
