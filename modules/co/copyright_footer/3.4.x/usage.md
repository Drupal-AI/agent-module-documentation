<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Copyright Footer provides a single configurable block that renders a "Copyright © <year> <organization> <version>" notice, with the current year filled in automatically.

---

The module ships exactly one thing: a Block plugin with id `copyright_footer` (admin label "Copyright Footer", category "Custom"). It defines no settings page, no permissions, no services and no configure route — you place the block through the normal Block layout UI and configure it in the block's own form. The block form exposes these fields, all stored in the block's configuration: `organization_name`, `organization_url`, `year_origin`, `year_to_date`, `version`, `version_url`, `all_rights_reserved_position` (radios: do not display / after organization / after version) and `copyright_format` (an optional custom token format). At render time `build()` computes the current year from the request time in the site's configured timezone; if `year_origin` is empty or equals the current year it prints a single year, otherwise it prints a `year_origin-year_to_date` range (an empty `year_to_date` falls back to the current year). When `organization_url` is set the organization name becomes a link; when `version` is set it renders as `ver.<version>`, optionally linked via `version_url`. "All Rights Reserved." can be appended after the organization name or after the version. The optional `copyright_format` field accepts the tokens `[copyright]`, `[year]`, `[start-year]`, `[end-year]`, `[organization-name]` and `[version]`; unsupported bracketed tokens are rejected on save and plain text is escaped. Year fields must be 4-digit and `year_origin` must be ≤ `year_to_date`; URL fields are validated as absolute URIs. The block's cache max-age is permanent when both years are fixed, otherwise it expires at the start of the next site-local year so the automatic year stays current. The block label is hidden by default (`label_display` = FALSE). Config is validated by the `block.settings.copyright_footer` schema. Branch 3.x supports `^9 || ^10 || ^11 || ^12`.

---

- Show a "Copyright © 2026 <Company>" notice in the site footer region.
- Automatically keep the copyright year current without editing content each January.
- Display a copyright year range such as "2010-2026" by setting a start year.
- Link the organization name in the footer to the corporate homepage.
- Append an application/version string like "ver.3.4.0" to the footer notice.
- Link the version string to a changelog or release-notes page.
- Append "All Rights Reserved." after the organization name or after the version.
- Define a fully custom notice layout with the `[copyright] [year] [organization-name] [version]` tokens.
- Reorder the copyright elements (e.g. version before organization) using the custom format field.
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
- Compute the year in the site's configured timezone for correct year rollover across regions.
- Run the copyright block on a Drupal 9, 10, 11 or 12 site.
