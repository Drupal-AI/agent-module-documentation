<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSS Grid adds a native CSS Grid layout to Layout Builder, so editors can shape a section with real `grid-template-columns`, `grid-template-rows`, and gap values.

---

Install with Composer (`composer require drupal/css_grid`) and enable the module; it requires core's **Layout Builder** and **Layout Discovery** and works on Drupal 8.8–11. There is **no settings page** — you configure a grid directly on each Layout Builder section. Enable Layout Builder for an entity view display (*Manage display → Use Layout Builder*), then *Add section* and pick **CSS Grid** from the layout chooser. In the section form you build **grid-template-columns** and **grid-template-rows** as repeatable value+unit rows (units `fr`, `auto`, `max-content`, `min-content`, `minmax`, `%`, `rem`, `px`) and set a **row-gap** and **column-gap** (`%`/`rem`/`px`, 0–20); the "Add column"/"Add row"/"Remove item" buttons change the track counts via AJAX, and choosing `minmax` switches the value field to free text (e.g. `200px,400px`). A grid needs at least one column and one row. On save the layout creates one block-drop region per cell (**columns × rows**) and renders the section as `<section class="css-grid-layout">` carrying the computed grid as an inline `style`. Because the grid `display: grid` rule ships in a library that is loaded in the config form, confirm the grid renders as intended on the front end for your theme, and preview across breakpoints.

---

- Add a native CSS Grid section in Layout Builder.
- Build grid-based section layouts without hand-writing CSS.
- Define `grid-template-columns` as repeatable value+unit rows.
- Define `grid-template-rows` the same way.
- Mix track units: `fr`, `auto`, `min-content`, `max-content`, `minmax`, `%`, `rem`, `px`.
- Use `minmax(200px,400px)`-style flexible tracks.
- Set independent row-gap and column-gap values.
- Add or remove columns and rows with AJAX buttons.
- Create asymmetric multi-column, multi-row page sections.
- Get one block-drop region per grid cell (columns × rows).
- Replace fixed one/two/three-column layouts with a real grid.
- Compose dashboard- or card-style content grids.
- Lay out fields or blocks on an entity's Layout Builder override.
- Apply CSS Grid to a content type's default display.
- Preview grid sections across breakpoints before publishing.
- Keep layout logic in the section config rather than custom CSS.
- Restrict who can edit layouts via core Layout Builder permissions.
- Enable only where Layout Builder is in use.
- Confirm the grid displays correctly in your active theme.
- Review grid sections after Drupal or theme upgrades.
