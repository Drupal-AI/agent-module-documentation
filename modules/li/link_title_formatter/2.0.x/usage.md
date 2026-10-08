<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link title formatter renders the title stored on a link field as text, dropping the anchor entirely.

---

A link field holds two things — a URI and a title — and core's formatters always render them together as a clickable link. There are plenty of displays where only the label is wanted: a teaser that lists related resources by name without inviting a click away, a card where the whole card is already the link and a nested anchor would be invalid markup, a print or email view mode where a link means nothing, or a search index that should contain the label as text rather than as markup.

Doing that without this module means either a Twig template override per view mode or a preprocess function, both of which put presentation logic somewhere harder to find. A formatter is the right layer: choose it in Manage display, per view mode, and the change is visible where a site builder expects to look.

One class, `Plugin/Field/FieldFormatter/LinkTitle`, no configuration beyond selecting it. The `link` module is the only dependency. Worth remembering that if the link field has no title stored, this formatter has nothing to render — so on fields where the title is optional, check what the display should do for the empty case.

---

- Show a link field's title without making it clickable.
- Avoid a nested anchor inside a card that is already a link.
- Render a link label in a print view mode.
- Render a link label in an email view mode.
- List related resources by name without linking away.
- Feed a link title into a search index as text.
- Show the label in a teaser and the link in full view.
- Suppress outbound links in a restricted display.
- Replace a Twig override with a supported formatter.
- Move presentation logic out of a preprocess function.
- Display a link title in a views field.
- Show a partner name without linking to the partner.
- Keep markup valid where anchors cannot nest.
- Decide what a display shows when the title is empty.
- Render a link label inside an accessible card pattern.
- Audit where link fields are rendered as text.
