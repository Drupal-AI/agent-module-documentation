<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flickr Integration Suite Filter lets an editor drop Flickr content into body text, expanding a token at render time through a text-format filter.

---

This is the editor's option. An author writing an article wants a photoset *here*, between two paragraphs, without leaving the editor or asking for a new field. A text-format filter gives them that: they write the token, and the filter expands it when the text is rendered.

Doing it as a filter rather than as stored markup is the correct choice and worth understanding. The stored text keeps the token, so the rendering can change — a new template, a different photo size, a switch to a lightbox — without rewriting content. It also means the expansion happens under the text format's rules, so which roles can use it is a text-format permission question, which is where that decision belongs.

Because it is per text format, a site can offer it in the full HTML format used by trusted editors and withhold it from a restricted format used for comments or user-submitted content. That is the control to use if the embed should not be available everywhere.

The nested `flickr_integration_suite_filter_colorbox` submodule extends it to open the embedded images in a Colorbox lightbox.

---

- Embed a photoset inline in an article.
- Let an editor add photos without a new field.
- Place photos between paragraphs.
- Keep a token in stored text rather than markup.
- Change photo rendering without rewriting content.
- Offer the embed only in trusted text formats.
- Withhold the embed from a restricted format.
- Control access by text format permission.
- Switch to a different photo size site-wide.
- Open embedded photos in a lightbox.
- Support editors writing long-form articles.
- Avoid pasted Flickr markup in body text.
- Standardise inline photo embedding.
- Audit which formats allow the filter.
- Migrate pasted embeds to tokens.