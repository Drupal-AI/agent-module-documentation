<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Table Bootstrap Filter is a text-format filter that automatically adds Bootstrap table classes (and a responsive wrapper) to every `<table>` in filtered content, so tables authored in the WYSIWYG render with Bootstrap styling without manual class editing.

---

The module provides a single filter plugin (`@Filter(id = "table_bs_filter")`, type
`TYPE_TRANSFORM_REVERSIBLE`) that you enable on a text format. On output it rewrites each opening
`<table>` tag: it preserves any existing `id`, `class`, `style` and `dir` attributes, wraps the table
in `<div class="table-responsive">`, and appends the base `table` class plus whichever Bootstrap
modifier classes the filter's checkbox settings turn on. The five settings are `table_bordered`
(adds `table-bordered`, otherwise `table-borderless`), `table_condensed` (`table-condensed`),
`table_row_hover` (`table-hover`), `table_striping` (`table-striped`) and `remove_width_height`
(strips inline `width`/`height` from the table and its cells so Bootstrap controls sizing). It
depends on core `editor` and `filter`. Because it is a text-format filter, an administrator enables
and configures it per format (a trusted, `administer filters` operation), and it acts on the same
authored HTML the format already governs — order it appropriately relative to the HTML-restriction
filter.

---

- Auto-apply Bootstrap `table` styling to WYSIWYG-authored tables.
- Wrap tables in a `table-responsive` div for horizontal scrolling on small screens.
- Add zebra striping to content tables (`table-striped`).
- Add row hover highlighting (`table-hover`).
- Add borders to tables (`table-bordered`) or force borderless.
- Make tables more compact with `table-condensed`.
- Strip hardcoded cell `width`/`height` so Bootstrap governs layout.
- Standardize table appearance across all rich-text content on a format.
- Style imported/pasted tables without hand-editing markup.
- Give editors Bootstrap tables without teaching them CSS classes.
- Configure different table styling per text format.
- Keep existing table `id`/`class`/`style`/`dir` attributes intact while adding classes.
- Improve mobile readability of data tables.
- Retrofit legacy content tables with a modern responsive wrapper.
- Pair with a Bootstrap-based theme for consistent table design.
- Apply consistent striping/hover to documentation or spec tables.
- Enable responsive tables on a specific "Full HTML" format only.
- Reduce editor effort when publishing tabular data.
- Ensure printed/exported content tables carry Bootstrap classes.
- Toggle individual Bootstrap table features per format via checkboxes.
