<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Blogspot Archive renders a view as a collapsible year-and-month archive tree, the navigation pattern Blogspot popularised and blogs have used ever since.

---

An archive of a thousand posts needs navigation that is neither a thousand links nor a hundred pages of pagination, and the year/month tree is the pattern that solved it: years collapsed, one expanded, months beneath it, counts beside each. It works because it matches how people remember dated content — roughly when, not exactly which — and because it is compact enough to sit in a sidebar on every page. This module supplies it as a Views **style plugin**, which is the right layer since the style governs how the whole result set is wrapped, so the archive inherits the view's filters, its access checking and its language handling rather than reimplementing them. Install it, add a view, and set **Format** to *Views Blogspot Archive*; in the style options give it the machine name of the **date field** to group on (for example `created`) and, optionally, turn on **Link archive items** and pick a view page display so the year and month labels link to a filtered result page. The example view shipped in `config/optional` shows the intended pairing of a Block display (the archive) with a Page display (the results). Two facts govern whether the result is right. First, **the tree and its counts are built in PHP from the rows the view returns** — the module counts the loaded result set rather than running its own `GROUP BY`, so the view must return the *whole* set (set the pager to display all items); a paged view produces a truncated archive, and the real cost is loading every matching entity. Second, **timezone decides which month a post falls in** — a post published at 23:30 on the 31st can land in a different month depending on the timezone used to format its date, which matters when reconciling an archive against a report. Version **2.0.2** on core `^10 || ^11`, depending only on core `views`.

---

- Build a blog archive by year and month.
- Add archive navigation to a sidebar.
- Show post counts per month.
- Navigate a large news archive.
- Add a collapsible year tree.
- Browse historical content.
- Build a newsletter archive.
- Navigate meeting minutes by date.
- Add a classic blog archive widget.
- Browse a publications history.
- Show an events archive.
- Navigate a press release archive.
- Add a date-based sidebar block.
- Link year/month labels to a filtered results page.
- Group an archive on a custom date field.
- Browse a long-running blog.
- Show content volume over time.
- Navigate an annual report archive.
- Build a diary archive.
- Add archive links to a footer.
