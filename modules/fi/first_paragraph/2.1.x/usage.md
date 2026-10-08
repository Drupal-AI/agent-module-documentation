<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
First Paragraph provides a field formatter to allow teasers to show the first paragraph of text.

---

First Paragraph provides a field formatter (`text_first_para`, "First Paragraph") that displays only the first
paragraph of a text field — so teasers/summaries can show the opening paragraph automatically instead of a
manually-written summary or a character truncation. It applies to `text`, `text_long`, and `text_with_summary`
fields and depends on core Field. Branch 2.1.x (release 2.1.0) is compatible with Drupal 10.3, 11, and 12.

The formatter renders the field value through its assigned text format, extracts the first `<p>` element, and
re-emits that paragraph through the same text format — so the output keeps the field's normal sanitization. If
the content has no paragraph, the field renders empty. Use it to auto-generate teaser summaries from the first
paragraph. It is a content-display/formatter feature; the text is authored content rendered (as the first
paragraph) and it has no access-control role. Select the formatter on the text field for teaser displays.

---

- Show the first paragraph of text.
- Auto-generate teaser summaries.
- Display the opening paragraph.
- Depend on core Field.
- Avoid manual summaries.
- Show a paragraph for teasers.
- Render authored content.
- Have no access-control role.
- Select the formatter on a display.
- Handle first-paragraph display.
- Show teaser text.
- Configure the formatter per view mode.
- Display teasers.
- Handle teasers.
- Show summaries.
- Render first paragraph.
- Configure teaser display.
- Show opening text.
- Handle summaries.
- Display first paragraph.
- Apply to text, text_long, and text_with_summary fields.
- Run on Drupal 10.3, 11, or 12.
- Keep the field's text-format sanitization.
- Render empty when there is no paragraph.
