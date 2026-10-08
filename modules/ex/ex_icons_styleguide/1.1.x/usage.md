<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges the ex_icons module with the Styleguide module to preview every available external-use icon on the theme styleguide page.

---

EX Icons Styleguide is a small bridge module that registers a single Styleguide generator plugin (`ExIconsStyleguide`). When Styleguide builds a theme's styleguide, this plugin asks the ex_icons manager (`ex_icons.manager`) for all discovered icon options and renders them in a responsive CSS grid, each cell showing the icon (via the `ex_icon` theme hook at 40x40) plus its machine ID label. It requires no configuration or activation beyond enabling the module: once enabled, the icons appear automatically inside each theme's styleguide at `/admin/appearance/styleguide/THEME_NAME`. Because icons are rendered with the same render arrays the real module uses, the page doubles as a self-documenting catalogue and a fixture for visual-regression testing. It depends on `ex_icons` (^1.6) and `styleguide` (^2.0) and supports Drupal 8 through 11.

---

- Preview every ex_icons icon available on the site on one page.
- Add an "External-use Icons" section to each theme's styleguide.
- Look up an icon's machine ID before referencing it in templates or config.
- Verify that an SVG sprite sheet was discovered and registered by ex_icons.
- Confirm a newly added icon shows up after clearing caches.
- Give themers a visual catalogue during theme development.
- Support icon selection when building components or CTAs.
- Provide a living styleguide for content editors and site builders.
- Use as a training and onboarding reference for available iconography.
- Produce a deliverable/QA page for clients and product owners.
- Support design reviews between designers and front-end developers.
- Serve as a fixture for automated visual-regression tests.
- Detect icon rendering regressions using the module's own render arrays.
- Audit icon coverage across multiple installed themes.
- Compare how the same icon renders under different themes' styleguides.
- Troubleshoot missing or mislabelled icons reported by ex_icons.
- Sanity-check icon dimensions and sprite `<use href>` references visually.
- Integrate icon previews into an existing Styleguide workflow with no extra config.
- Enable and immediately use, with no settings form to configure.
- Document the icon library for handoff without maintaining a separate page.
