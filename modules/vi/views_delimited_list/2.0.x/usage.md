<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Delimited List adds a Views display style that renders a view's results as one inline run of text — "Design, Engineering, and Marketing" — instead of a bulleted list, table, or grid.

---

Install it like any contrib module (`ddev composer require drupal/views_delimited_list` then enable **Views Delimited List**); it only needs core **Views**. To use it, edit a View, set **Format** to **Delimited text list**, and open its **Settings**. There you set the **Delimiter text** (default `, `), a **Conjunctive text** for the word before the final item (default ` and `), a **Prefix** and **Suffix** placed inline around the whole run, and length-dependent rules: **Separator between two items**, a **Long list count** threshold (2 or 3), and **Separator before last item in long list** — each choosing Delimiter, Conjunctive, or Both, which is how you switch between US style ("A, B, and C") and UK style ("A, B and C"). The style must be used with a **Fields** row, and for the items to sit on one line the fields you display should be set to *inline*; the module ships a whitespace-trimmed fields template so rows do not add stray gaps. All text you type into these settings is escaped by Twig on output like any other Views text — so treat the delimiter and conjunctive as literal display text, not as a place to inject markup. Note that the default conjunctive stores the HTML entity `&nbsp;`, which shows literally; use a plain space or a real non-breaking space character if you want that spacing.

---

- Show a node's tags as a comma-separated list.
- List the authors of a paper inline in a byline.
- Render the departments a service belongs to as a sentence fragment.
- Avoid a bulleted list when there are only two items.
- Show taxonomy categories inline under a title.
- Produce a compact related-items line.
- List available file formats after a document title.
- Show a service's locations on one line.
- Render a list of values into a meta line.
- Avoid a per-site template override for a small inline list.
- Show article keywords beneath the body.
- List the speakers at an event.
- Render a compact taxonomy summary.
- Show a product's available sizes.
- List the contributors to a page.
- Produce a pipe-separated or slash-separated run by changing the delimiter.
- Switch a list between US ("A, B, and C") and UK ("A, B and C") punctuation.
- Wrap the list in a prefix/suffix such as "Tags:" and a period.
- Render an inline list inside a teaser or card.
- Show an entity reference field's targets as one readable sentence.
