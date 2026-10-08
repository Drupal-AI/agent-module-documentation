<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Table Rowspan merges repeated cells in a grouped table column using `rowspan`, so a listing grouped by category shows the category once against its whole group instead of repeating it on every row.

---

Repetition in a table column is the visual signature of grouped data rendered flat: twelve rows in a report all saying "North region" in the first column, when the useful presentation is one merged cell spanning those twelve. Views can split results into separate tables with headings, which is a different look and often not the one a report wants; `rowspan` keeps one table and one set of column headers while showing the grouping structurally. The module supplies this as a single Views style plugin, `table_rowspan` ("Table Rowspan"), that extends the core table style, so it is chosen in place of the standard table format and everything else about the view is unchanged. Which column merges is driven by the view's own grouping option — set a field as a grouping level and enable "Merge rows in table", and cells with the same value in that group collapse into one. It supports multiple nested grouping levels. There is no settings page, permission, service, or config object of its own; all configuration lives in the view display's style options, and it depends only on core `views` (`^10 || ^11`). Two things to check. Merging follows grouping, so the field you want collapsed must be configured as a grouping level. And accessibility: merged cells change how a screen reader associates data with headers, so a table using `rowspan` should be tested with assistive technology rather than assumed correct, particularly where the merged column carries meaning rather than decoration.

---

- Merge repeated cells in a report column.
- Show a category once per group.
- Present grouped data in one table.
- Avoid repeating a value on every row.
- Improve readability of a data table.
- Keep one set of column headers.
- Show a hierarchy inside a table with nested grouping.
- Present a schedule grouped by day.
- Merge cells in a financial report.
- Group rows without splitting into separate tables.
- Improve a timetable's layout.
- Show a person's multiple roles compactly.
- Present survey results by section.
- Reduce visual noise in a report.
- Build a comparison table with merged headers.
- Merge cells in an admin listing.
- Present a matrix of results.
- Improve a printed report's layout.
- Collapse a repeated region column in a locations list.
- Group a product list by manufacturer.
