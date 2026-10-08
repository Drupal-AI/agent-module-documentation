<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Columns / Container adds a Paragraphs type that lays other paragraphs out in a one-to-six column CSS grid (one column = a plain container/section), with per-layout column-width presets, an equal-height toggle, and the EPT family's shared per-paragraph design settings.

---

Component-built pages need a way to sit several paragraphs side by side, or to wrap a run of paragraphs in a single styled container — a job the flat paragraph list cannot do on its own. EPT Columns answers that by giving the `ept_columns` Paragraphs bundle a repeatable Paragraphs reference field (`field_ept_columns`, cardinality unlimited, target bundle `ept_columns`) into which an editor nests any other paragraphs, and an `ept_settings_columns` widget (a subclass of ept_core's default settings widget) that adds four choices on the Settings tab: a **layout** radio (1-6 columns; "One column" is a plain Container), a **column-width** select whose options depend on the chosen layout (two columns: 50/50, 33/67, 67/33, 25/75, 75/25; three columns: 25/50/25, 33/34/33, 25/25/50, 50/25/25; four columns: 25/25/25/25, 40/20/20/20, 20/20/20/40), and an **equal-height** checkbox. The module ships no rendering PHP beyond that widget — the layout is expressed purely as CSS classes (`column-N`, `columns-<preset>`, `columns-equal-height`) written onto the wrapper by `templates/paragraph--ept-columns--default.html.twig`, and the shipped `css/styles.css` maps those classes to `display:grid` with the matching `grid-template-columns` (e.g. `.column-2.columns-33-67` -> `1fr 2fr`). The bundle also carries an optional `field_ept_title` (text_long, rendered as a configurable heading), `field_ept_text` (text_long), and `field_ept_settings` — the shared ept_core Design tab (margin/padding/border, background color/image/video, edge-to-edge, container width) emitted as a scoped inline `<style>` block. Because nested items are themselves `ept_columns` paragraphs and any other paragraph type, columns can be nested to build multi-row / multi-column page structures. Version **2.0.0**; core requirement `^10.1 || ^11 || ^12`; hard dependencies on `ept_core` and `paragraphs`. The layout and width choices are constrained selects/radios, so the grid is predictable across breakpoints defined by the CSS and ept_core's responsive settings.

---

- Place two paragraphs side by side in a 50/50 two-column row.
- Build a 67/33 main-content-plus-sidebar row inside a page.
- Lay out a three-column feature strip (33/34/33).
- Create a four-column row of cards or stats (25/25/25/25).
- Wrap a run of paragraphs in a single styled container (one-column layout).
- Nest columns inside columns to build a multi-row grid section.
- Give a column group a shared background color or image via the design settings.
- Make a full-width, edge-to-edge banded section with inner columns.
- Add a heading above a column group via the title field.
- Add intro text above the columns via the text field.
- Force all columns in a row to equal height for aligned cards.
- Build an asymmetric 25/75 layout for a caption-and-media pairing.
- Assemble a landing page from stacked column sections.
- Constrain a section's inner content to the container max-width.
- Apply per-section margin, padding, or border around a column group.
- Use a 40/20/20/20 four-column layout to emphasise the first column.
- Group related call-to-action paragraphs into a tidy multi-column block.
- Create a responsive card grid that collapses on mobile per the CSS breakpoints.
- Reuse the same layout paragraph type site-wide instead of bespoke layouts.
- Compose editorial pages without Layout Builder, staying inside Paragraphs.
- Add a container section purely to apply a background/spacing to nested paragraphs.
- Mix native EPT paragraph types (image, text, button) inside a column layout.
