<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Heading Size lets an editor set a font size on a heading in CKEditor 5 by applying a CSS class, so a heading's appearance can vary without changing its level.

---

The need is real and the usual DIY fix is the problem: an editor wants a heading's *size* to differ from its *level* — an `h2` too large for a short section, or a landing-page subheading that should look prominent without becoming a document-level heading. Most sites solve this by picking the heading level that *looks* right rather than the one that *is* right, producing an outline like `h1, h4, h2, h4` that screen-reader heading navigation, table-of-contents generation and search all misread. This module removes that incentive because of *how* it works: clicking a heading in the editor opens a contextual balloon with a dropdown of configured sizes, and the chosen size is stored as a **CSS class on the correctly-nested heading** (e.g. `h2.heading-size-24px`) — never by changing the tag and never by writing an inline `style="font-size:…"`. The class is applied in the CKEditor 5 model via a `fontSize` attribute (`headingsizeediting.js`), and the module either generates the matching `font-size` CSS in the page `<head>` (its "Size options" mode) or maps each label to a theme-provided class (its "Theme classes" mode). A config-override service also teaches each text format's `filter_html` to allow those specific size classes on heading tags, so the styling survives filtering. It requires the core CKEditor 5 Heading plugin to be enabled on the text format; the size control activates automatically when Heading is present — there is no separate toolbar button to add. Version 1.0.6, core `^9 || ^10 || ^11`, package `Custom`. If your theme already ships a "Styles" dropdown with named heading classes, that expresses the same intent; this module is the better fit when you want editors to pick from a numeric size scale.

---

- Make a heading visually smaller without demoting its level.
- Emphasise a subheading's appearance while keeping it an `h2`/`h3`.
- Offer editors a fixed set of heading sizes (14px–48px by default).
- Keep the document outline correct while varying heading appearance.
- Let a landing-page hero subheading look large without being an `h1`.
- Style a section heading distinctly inside a callout or card.
- Apply a size class to a heading via a click-triggered balloon dropdown.
- Avoid editors misusing heading levels purely to get a size.
- Map editor-facing size labels to your theme's own heading classes ("Theme classes" mode).
- Let the module generate the `font-size` CSS automatically ("Size options" mode).
- Restrict the available sizes site-wide from one settings form.
- Keep chosen sizes intact through `filter_html` (classes are whitelisted per format).
- Support a design's typographic scale from within the editor.
- Give marketing pages flexible heading typography without tag soup.
- Preserve screen-reader heading navigation while restyling headings.
- Add `!important` to generated rules to beat a stubborn theme rule.
- Add an extra ancestor selector for more CSS specificity over the theme.
- Provide consistent heading sizing across many editors and content types.
- Adjust a heading's prominence per context (hero, card, sidebar).
- Match editorial headings to a fixed brand type scale.
- Avoid inline `style` attributes in body content.
- Reuse the same size classes across every text format that has Heading enabled.
