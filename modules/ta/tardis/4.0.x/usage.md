<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Views style plugin ("TARDIS") that turns a date-bearing view into a compact reverse-chronological archive: a list of years, each expandable to months, linked to date-filtered content pages.

---

Selecting the TARDIS style on a view renders its results as year/month navigation links (e.g. `/tardis/1963/11`) in newest-first order, rather than as a table or unformatted list. The style exposes options for the link **path prefix** (default `tardis`), a PHP **month date format** (default `m`), and whether month links are **nested** inside their year. It is the classic blog/news "archive by month" widget, implemented as a themeable Views style (`views_view_tardis` theme hook, templates in `templates/`).

It is display-only: it depends on `views` and produces links whose target pages you build (typically a companion view or contextual-filter page keyed on the year/month arguments). No routes, permissions or services are added; the trust boundary is whatever content the underlying view already exposes.

---
- Add a "browse by year/month" archive to a blog
- Render a view's results as reverse-chronological date links
- Show a compact year list that expands to months
- Nest month links inside their year headings
- Link each month to a date-filtered content listing
- Customise the link path prefix (e.g. `/archive/2024/03`)
- Set the month label format with a PHP date pattern
- Build a news archive sidebar block from a view
- Provide date-based navigation without a full calendar
- Present publication history newest-first
- Theme the output via the `views_view_tardis` template
- Pair with a contextual-filter view that resolves `/prefix/YYYY/MM`
- Offer an SEO-friendly dated URL structure for archives
- Replace a heavy calendar view with lightweight month links
- Drive a "this month in history" style navigation
