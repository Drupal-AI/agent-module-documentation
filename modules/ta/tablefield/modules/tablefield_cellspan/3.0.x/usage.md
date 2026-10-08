TableField Cellspan lets you merge table cells in a TableField by typing `#colspan#`, `#rowspan#`, and `#remove#` markers into cell values, which are turned into real HTML `colspan`/`rowspan` attributes when the table is rendered.

---

TableField Cellspan is a tiny helper submodule of TableField that adds cell-merging to tables without any UI or configuration — the README states plainly that it has no menu, no settings, and nothing to configure. It works by implementing `hook_preprocess_table()` (`tablefield_cellspan_preprocess_table`), which runs on every rendered table but only on front-end (non-admin) routes, checked via the `router.admin_context` service. As it walks the rows and cells, it scans each cell's text content for three literal markers. A cell containing `#colspan#` is dropped and its width is folded into the cell immediately to its left, whose `colspan` attribute grows (consecutive `#colspan#` cells keep widening the same cell). A cell containing `#rowspan#` is dropped and merged upward into the nearest non-empty cell in the same column of a previous row, whose `rowspan` grows. A cell containing `#remove#` is simply deleted from the output so no `<td>` is emitted, which lets you clear the leftover cells a span would otherwise leave behind. Because the transform happens at theme/preprocess time on the rendered `<table>`, the stored TableField value is untouched — editors just type the markers into ordinary table cells (typically via the TableField widget) and the merged layout appears on display. There are no permissions, no config schema, and no plugins; enabling the module is the entire setup.

---

- Merge two adjacent cells horizontally by putting `#colspan#` in the right-hand cell so the left cell spans both columns.
- Span a heading across an entire row by filling every cell after the first with `#colspan#`.
- Merge cells vertically by putting `#rowspan#` in the cell below, so the cell above spans two rows.
- Build a cell that spans three or more rows by repeating `#rowspan#` in each cell underneath.
- Create a spreadsheet-style header where one label covers several sub-columns.
- Lay out an invoice or spec table with a merged "Total" cell spanning multiple columns.
- Produce a schedule/timetable grid where a session block spans several time rows.
- Remove the now-redundant leftover cell after a span using `#remove#`.
- Clean up ragged right edges of a table by deleting trailing empty cells with `#remove#`.
- Add advanced table layouts to content without writing any custom Twig or preprocess code.
- Give editors control over merged cells purely through the normal TableField data entry grid.
- Keep the stored table data intact while only changing how it renders (markers act at display time).
- Restrict cell-merging to the public site only, since the transform is skipped on admin routes.
- Combine colspan and rowspan in one table to build complex, non-rectangular layouts.
- Present a comparison matrix where a category label spans all its feature rows.
- Format a pricing table where a plan name spans two columns of details.
- Merge the first cell of several rows into a single vertical group label.
- Author merged-cell tables in TableField without needing an HTML/WYSIWYG field.
- Enable richer table display on a site that already uses TableField, with zero configuration.
- Ship a fixed, marker-annotated default table so all instances render with the same merged layout.
