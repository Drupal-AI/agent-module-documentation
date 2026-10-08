<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Expand link formatter renders a long text field as a short collapsed excerpt with a 'read more' link that expands the rest.

---

It is a field formatter for `text_long` and `text_with_summary` fields. The text is split into a
collapsed portion and an expanded portion in one of two ways: (1) an explicit **separator** placed in the
body (default `<hr>`) marks where the fold is, or (2) if there is no separator and a **maxlength** > 0 is
set, the text is auto-trimmed at a word boundary (using Views' `trimText`) and the remainder becomes the
expandable part. When there is an expanded part it renders through the `expand_link_formatter` Twig
template and attaches the `expand_link_formatter/expand` JS library plus the expand/collapse labels via
`drupalSettings`; otherwise it just renders the processed text.

Configure it per display on **Manage display**. Settings are: *Separator*, *Expand link label*
(default "Read more"), *Collapse link label* (default "Read Less"), and *Maximum characters before
trimming* (0 = off). Both parts are rendered as `#type => processed_text` with the field's own text
format, so the site's filter pipeline sanitises the content; the link labels are additionally run through
`Xss::filter`. Note it depends on the Views module's `FieldPluginBase::trimText`, so Views must be present
for the auto-trim path.

---

- Show a short teaser of a long body with a 'read more' toggle.
- Split body text at an explicit separator such as <hr>.
- Auto-trim text at a word boundary when no separator is present.
- Set the character threshold before auto-trimming kicks in.
- Customise the expand link label (default 'Read more').
- Customise the collapse link label (default 'Read Less').
- Choose a custom separator string for the fold point.
- Apply to text_long fields on any entity display.
- Apply to text_with_summary (body) fields.
- Keep the field's text format filtering via processed_text.
- Render collapsed and expanded parts from one Twig template.
- Attach the expand JS library only when there is content to expand.
- Fall back to plain processed text when nothing needs expanding.
- Reduce initial page length on content-heavy listings.
- Provide inline expand/collapse without a separate page load.
- Disable auto-trim by setting maxlength to 0.
- Sanitise custom link labels through Xss::filter.
- Override the expand-link-formatter template in a theme.
