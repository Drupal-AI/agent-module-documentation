<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Layouts lets site builders create Layout API layouts **through the admin UI** as configuration entities — rows, columns, widths and CSS classes — instead of declaring each layout in a theme's or module's `*.layouts.yml` and deploying code for every new arrangement.

---

Drupal's layout system is code-first: a layout is a plugin declared in YAML with a Twig template beside it, which suits a fixed design system but frustrates a site builder who needs a new three-column variant without a release. Dynamic Layouts adds the UI path. You save global settings once (a frontend library — Bootstrap v4 or a custom 6/8/12-column grid, with a column-class prefix), then build layouts at `/admin/config/dynamic-layouts`: add rows, add columns, set each column's width class, give columns names (which become the layout's region machine names), and attach default or custom CSS classes to rows and columns. Each saved layout is a `dynamic_layout` config entity that a deriver turns into a core `@Layout` plugin (`dynamic_layout:<id>`), so it becomes selectable anywhere layouts are consumed — Layout Builder sections, Display Suite, Panels. Because the layouts are config entities they export with `drush cex` and deploy through configuration like anything else, keeping environments in step. Dependencies are core `layout_discovery` and `system` only; a single permission, `admin dynamic layouts`, gates all of it. The trade-off is the familiar one for UI-built structure: a layout created this way has no dedicated template to hang bespoke markup on, so anything past region arrangement and classes still needs theme work, and freely created layouts can accumulate into an uncurated catalogue.

---

- Create a new layout without writing code or deploying a theme release.
- Add a three-column variant on demand from the admin UI.
- Let trusted site builders define page arrangements themselves.
- Export UI-created layouts as configuration and deploy them via `drush cim`.
- Keep the same layouts in step across dev/stage/prod through config sync.
- Provide custom layouts to Layout Builder sections.
- Supply layouts to Display Suite or Panels display setups.
- Build a responsive grid layout using a Bootstrap v4 column grid.
- Build a custom 6, 8, or 12-column grid with your own column-class prefix.
- Set a per-column width class from a dropdown driven by the grid size.
- Attach default CSS classes applied to every row and every column of a layout.
- Add custom CSS classes to an individual row or column.
- Name each column so its region shows a meaningful label in the layout picker.
- Group related layouts under a free-text category in the layout selector.
- Prototype a layout in the UI before committing it to code.
- Reduce developer round-trips for one-off arrangement requests.
- Stand up a one-off layout for a marketing campaign or landing page.
- Standardise a shared set of layouts across a multisite via exported config.
- Reorganise a layout's rows/columns after the fact without a code change.
- Adjust column widths automatically as columns are added or removed.
