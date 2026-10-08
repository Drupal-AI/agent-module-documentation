<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor BiDi Buttons adds RTL and LTR text-direction buttons to the CKEditor 5 toolbar, letting editors set the HTML `dir` attribute on block-level elements for bi-directional (e.g. Hebrew/Arabic + English) content.

---

The module ships a single CKEditor 5 plugin (`ckeditor_bidi_ckeditor5`, class `Bidi`) that registers a `direction` toolbar item. Once you drag that button into a text format's CKEditor 5 toolbar (at *Configuration → Text formats and editors*), editors can toggle the writing direction of the current block (paragraph, heading, list item, table, …); the plugin adds `dir="ltr"` or `dir="rtl"` to those elements and declares the matching allowed elements (`<$text-container dir="ltr rtl">`, `<li dir="ltr rtl">`) so the values survive filtering. It has one configurable option, `switch_only` ("Never remove direction, only switch"), exposed on the plugin's settings in the text-format form and stored on the `editor` config entity under `settings.plugins.ckeditor_bidi_ckeditor5.switch_only`. By default (switch_only off) clicking a direction button that matches the editor's own default direction removes the `dir` attribute to avoid redundant markup; the downside is you cannot force, say, `dir="ltr"` on content authored in an LTR admin UI, so that content inherits the wrong direction when later shown on an RTL page. Turning `switch_only` on makes the buttons always set an explicit direction and never strip it, guaranteeing correct rendering across mixed-direction contexts. The module has no routes, permissions, services, or Drush commands of its own — it is purely a CKEditor 5 toolbar plugin plus one per-editor setting, and it requires the core `ckeditor5` module.

---

- Add RTL/LTR direction buttons to a rich-text format's CKEditor 5 toolbar.
- Let editors mark a specific paragraph as right-to-left (Hebrew/Arabic) inside otherwise LTR content.
- Set `dir="ltr"` on an English quotation embedded in an RTL article.
- Author bi-directional content (mixed Hebrew and English) with correct per-block direction.
- Apply direction to list items so each `<li>` flows the right way.
- Change the direction of a table or heading block in the editor.
- Force an explicit `dir` attribute (via switch_only) so content renders correctly in email clients that default to LTR.
- Prevent English paragraphs authored in an LTR admin from inheriting `dir="rtl"` on an Arabic-facing site.
- Prevent Hebrew paragraphs authored in an RTL admin from inheriting LTR when viewed on an LTR page.
- Keep the `dir` attribute out of markup when it matches the default (leave switch_only off) for cleaner HTML.
- Give a specific text format bidi support while leaving others unchanged.
- Support multilingual editorial teams working across LTR and RTL languages in one WYSIWYG.
- Toggle direction without editing source HTML by hand.
- Ensure quoted RTL snippets display correctly inside an LTR newsletter.
- Provide direction control for content that will be syndicated to differently-directioned sites.
- Configure bidi behaviour per text format (e.g. strict switch_only on the "Full HTML" format only).
- Let editors correct the flow of pasted mixed-direction text.
- Standardise direction handling across a site that publishes in both Arabic and English.
- Add direction support to a webform or comment text format that uses CKEditor 5.
- Preserve author-set direction through Drupal's HTML filtering via the plugin's declared elements.
