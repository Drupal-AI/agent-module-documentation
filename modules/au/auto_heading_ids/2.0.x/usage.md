<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto heading ids provides a text-format filter that automatically adds `id` attributes to h2–h6 headings in rendered content, so headings become anchor targets.

---

Auto heading ids ships a single text-format filter plugin (`heading_id_filter`,
`HeadingIdFilter`) that parses the rendered HTML of a field, finds every `h2`–`h6` heading, and
sets an `id` attribute derived from the heading's text (transliterated to ASCII, reduced to
lowercase dash-separated tokens, deduplicated per fragment, truncated to 128 chars). This turns
each heading into an in-page anchor target, enabling "jump to section" links, tables of contents,
and deep links to specific sections. The filter is a `TYPE_TRANSFORM_IRREVERSIBLE` display filter:
it changes only the rendered output, never the stored value, and plays no role in access control.
It has no configuration UI, no settings, no permissions, no routes, and no dependencies beyond
Drupal core's `filter` module. Enable it per text format on the Text formats and editors admin
page (`/admin/config/content/formats`).

---

- Add `id` attributes to h2–h6 headings automatically.
- Make every heading in a body field an anchor target.
- Enable in-page "jump to section" links without manual anchors.
- Support automatically generated tables of contents that link to headings.
- Provide deep links (URL fragments) to specific sections of a page.
- Derive readable, slug-style IDs from the heading text.
- Transliterate accented and non-ASCII heading text to ASCII IDs (e.g. "Ä Ö Ü" → `a-o-u`).
- Guarantee unique IDs within a rendered fragment (duplicate headings get `-2`, `-3`, … suffixes).
- Truncate very long heading IDs to 128 characters.
- Leave the stored field value unchanged (display-only transformation).
- Apply the filter to a specific text format such as Full HTML or Basic HTML.
- Skip `h1` headings (only h2–h6 are processed).
- Let JavaScript or CSS target headings by their generated IDs.
- Support anchor-link/scrollspy widgets that need heading IDs to function.
- Improve accessibility and shareability of long-form content sections.
- Add heading anchors to node bodies, custom blocks, and any filtered text field.
- Combine with other filters in a format (it runs at filter weight 10).
- Provide stable anchors for documentation-style content.
- Avoid hand-authoring `<h2 id="...">` markup in the editor.
- Work with WYSIWYG-authored content where editors cannot set IDs.
- Enable "copy link to this section" affordances built on the generated IDs.
