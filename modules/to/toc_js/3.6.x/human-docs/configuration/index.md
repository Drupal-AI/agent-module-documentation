# Configuration

Toc.js has no standalone settings page. You configure a table of contents in one
of two places, and both offer the **same options**:

- The **Table of contents** section on a content type's edit form (under
  *Additional settings*), for a TOC that appears on every node of that type.
- The **Toc.js block** configuration form, for a TOC you place in a region.

There are a lot of options (around forty), but you only ever need a handful to get
a good result. They're grouped below by what they do. Everything has a sensible
default, so you can enable the TOC and adjust from there.

## Which headings to include

- **Selectors** — the headings the TOC is built from, as a CSS selector list.
  Default `h2,h3`. Add `h4` (`h2,h3,h4`) for deeper tables, or narrow it to
  `h2` for a shorter one.
- **Container** — the CSS selector for the region whose headings are scanned.
  Default `.node`, i.e. the node's rendered content. Change it if your headings
  live in a different wrapper.
- **Selectors minimum** — the minimum number of matching headings required
  before a TOC is shown at all (default 0). Raise it to, say, 3 so short pages
  with only a heading or two don't get a table of contents.

## Title and markup

- **Title** — the heading shown above the table of contents (default "Table of
  contents"). There are companion options for the title's HTML tag and CSS
  classes.
- **List type** — whether the TOC renders as an unordered (`ul`, default) or
  ordered (`ol`) list.
- **List / item / heading classes** — several fields for adding your own CSS
  classes to the list, its items, and headings, so you can style the TOC to match
  your theme.

## Scrolling and highlighting behavior

- **Smooth scrolling** — on by default; clicking a TOC link glides to the
  section instead of jumping. There's a companion **scroll offset** to stop the
  target sitting under a fixed header.
- **Highlight on scroll** — on by default; the TOC entry for the section you're
  currently reading is highlighted as you scroll, with a **highlight offset** to
  fine-tune when the switch happens.
- **Sticky** — keep the TOC pinned in view as the reader scrolls, with a
  **sticky offset** for spacing.

## Collapsing, "back to top" and "back to the TOC"

- **Collapsible items** — let nested sections of the TOC collapse and expand,
  with a setting for whether they start expanded.
- **Back to top** — adds a "back to top" link after each section, with options
  for its label and which element it targets.
- **Back to the table of contents** — similar links that return the reader to the
  TOC, with their own label and classes.

## Heading cleanup and accessibility

- **Skip invisible headings** — leave headings that aren't visible out of the
  TOC.
- **Use heading HTML** — keep inline markup from the heading text in the TOC
  entry rather than plain text.
- **Heading cleanup selector** — strips helper markup (default
  `.visually-hidden, .sr-only`) out of the generated entry text so screen-reader
  helper text doesn't leak into the TOC.
- **Heading focus** — move keyboard focus to the target heading when a TOC link
  is followed, which helps keyboard and screen-reader users.

## Dynamic pages

- **AJAX page updates** / **observable selector** — rebuild the table of contents
  when page content changes dynamically (for example content loaded via AJAX),
  watching the element you specify.

## Save

Save the content type (or the block). The options you set are turned into
`data-*` attributes on the rendered table-of-contents element, which the Toc.js
JavaScript library reads to build and behave as configured. Reload a page with
headings to see your changes.
