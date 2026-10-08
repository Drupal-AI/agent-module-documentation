<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Copyright Footer provides a single configurable block that renders a "Copyright © <year> <organization> <version>" notice, with the current year filled in automatically.

---

The module ships exactly one thing: a Block plugin with id `copyright_footer` (admin label "Copyright Footer", category "Custom"). It defines no settings page, no permissions, no services, no routes and no configure route — you place the block through the normal Block layout UI and configure it in the block's own form. The block form exposes six fields stored in the block's configuration: `organization_name`, `organization_url`, `year_origin`, `year_to_date`, `version` and `version_url`. At render time `build()` computes the current year with PHP `\DateTime`; if `year_origin` is empty or equals the current year it prints a single year, otherwise it prints a `year_origin-year_to_date` range (where an empty `year_to_date` falls back to the current year). When `organization_url` is set the organization name becomes a link, and when `version` is set it renders as `ver.<version>`, optionally linked via `version_url`. Because the current year is recomputed on every build, the notice stays up to date without editor intervention. The block label is hidden by default (`label_display` = FALSE). Config is validated by `block.settings.copyright_footer` schema.

---

- Show a "Copyright © 2026 <Company>" notice in the site footer region.
- Automatically keep the copyright year current without editing content each January.
- Display a copyright year range such as "2010-2026" by setting a start year.
- Link the organization name in the footer to the corporate homepage.
- Append an application/version string like "ver.3.1.1" to the footer notice.
- Link the version string to a changelog or release-notes page.
- Place the copyright notice only on specific pages using core block visibility conditions.
- Restrict the copyright block to certain roles or content types via block visibility.
- Add a per-language copyright block by placing separate block instances per language.
- Provide a legal/branding line in a theme footer without writing custom Twig.
- Show a fixed single year (e.g. a launch year) by setting origin and to-date to the same value.
- Render multiple copyright blocks (e.g. one per site section) with different organizations.
- Give a subsite or microsite its own copyright organization and start year.
- Surface a copyright notice on an admin theme footer for internal tools.
- Replace a hardcoded theme copyright line with editable block configuration.
- Export the configured block via configuration management for consistent deployment.
- Display copyright with no organization (just "Copyright © 2026") by leaving fields blank.
- Combine with a footer menu block so legal text sits alongside footer navigation.
- Use block placement weight to position the copyright line at the very bottom of the footer.
- Show the copyright block only to anonymous visitors using role visibility conditions.
