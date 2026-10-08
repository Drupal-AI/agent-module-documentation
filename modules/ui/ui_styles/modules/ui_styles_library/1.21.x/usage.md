<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Library adds a "Styles" library page that lists every declared UI Styles style and its options with live previews, acting as a styleguide for the site's design system.

---

This submodule provides a read-only overview page at `/admin/appearance/ui/styles`
(route `ui_styles_library.overview`, controller `StylesLibraryController::overview`), gated by
the module-provided permission **`access_ui_styles_library`**. The controller asks the style
plugin manager for `getGroupedDefinitions()` and renders each category, style and option via the
`ui_styles_overview_page` theme hook (template `ui-styles-overview-page.html.twig`), using each
definition's `previewed_with`/`previewed_as` metadata plus the generated stylesheet so the
sample markup shows the real visual effect. It also registers a menu link and local task under
the *Appearance → UI libraries* section (`ui_suite.index` at `/admin/appearance/ui`). It stores
no configuration; it is purely a documentation/QA surface for the styles defined elsewhere.

---

- Give front-end developers a live styleguide of all available UI Styles.
- Let content editors preview what each style option looks like before applying it.
- QA a design system by checking every declared style renders correctly.
- Document a theme's utility classes for the whole team in one page.
- Verify that a newly added `*.ui_styles.yml` style shows up as expected.
- Review styles grouped by category (Colors, Spacing, Shadows, …).
- Share a URL to the styles library with designers for sign-off.
- Spot styles whose CSS is missing (option shows but no visual effect).
- Onboard new team members to the site's available styling options.
- Audit which styles exist across enabled modules and themes.
- Confirm theme-scoped styles appear only under the intended theme.
- Use the page as a reference while building Layout Builder or block styles.
- Check option labels and previews for consistency.
- Grant designers view-only access to the styleguide via a dedicated role.
- Validate `previewed_with` sample markup for each style.
- Cross-check style ids and classes when writing config.
- Provide a living-documentation page instead of a static styleguide.
- Confirm that disabled styles (`enabled: false`) do not appear.
- Demonstrate the design system to stakeholders.
- Catch duplicate or conflicting utility classes visually.
- Keep a canonical list of approved classes accessible in the admin.
