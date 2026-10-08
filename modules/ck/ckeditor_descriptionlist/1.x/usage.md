<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Description List adds a Description List (dl/dt/dd) plugin to CKEditor 5, so editors can create semantic definition lists.

---

HTML's description list — `<dl>` with `<dt>` terms and `<dd>` descriptions — is the correct markup for glossaries, metadata pairs, and FAQ-style term/definition content, but CKEditor 5 does not offer it out of the box. Editors end up faking it with bold text and line breaks, losing the semantics. This module adds a Description List button to CKEditor 5 so the real `dl/dt/dd` structure can be authored in rich text.

It depends on core CKEditor 5 and is a content-authoring enhancement. The one recurring consideration for any CKEditor plugin that inserts specific markup is the text format: the format's allowed-HTML filter must permit `<dl>`, `<dt>` and `<dd>`, or the filter strips them on render and the editor's work vanishes. That is the usual reason such a plugin appears not to work — it inserts correctly, the filter removes it.

For sites that publish glossaries, term lists, or structured definitions, it restores the correct semantic element to the editor. Confirm the text format allows description-list tags.

---

- Add description lists to CKEditor.
- Author a glossary in rich text.
- Create dl/dt/dd markup.
- Add semantic definition lists.
- Build a term/definition list.
- Add a description-list button.
- Author metadata pairs.
- Use correct list semantics.
- Avoid faking lists with bold.
- Allow dl/dt/dd in the text format.
- Confirm the filter keeps the tags.
- Publish a glossary.
- Structure FAQ content.
- Add definition lists to articles.
- Improve content semantics.
- Enable in CKEditor 5.
- Create accessible term lists.
- Author structured definitions.
- Restore the dl element.
- Format term-description content.