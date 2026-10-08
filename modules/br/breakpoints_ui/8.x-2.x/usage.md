<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Breakpoints UI provides a read-only admin overview that discovers and displays every breakpoint defined across installed themes and modules by parsing their `*.breakpoints.yml` files. Core has no UI for breakpoints, so this fills that gap for site builders and themers.

Use it to quickly audit which breakpoint groups and media queries exist on a site without opening YAML files by hand.
---
Enable with `drush en breakpoints_ui`; it depends on core `breakpoint`. View the overview at `/admin/config/media/breakpoints` (route `breakpoints_ui.overview`).

Note the access requirement: the route is gated by the core `access content` permission, which is granted to anonymous users by default — so the breakpoint listing is effectively public. The listing exposes only breakpoint metadata (names, media queries, multipliers) read from code, not sensitive data. A service `breakpoints_ui` (`BreakpointsUiService`) reads the YAML, and a Drush command class (`src/Commands/BreakpointsUiCommands.php`) is provided.
---
- See every breakpoint defined by themes and modules in one table.
- Audit responsive media queries without reading YAML.
- Verify a theme's breakpoint group loaded correctly.
- Check breakpoint multipliers (1x/1.5x/2x) for retina images.
- Debug responsive image style mappings.
- Confirm a module's breakpoints registered as expected.
- Document a site's responsive breakpoints for a team.
- Compare breakpoints across multiple installed themes.
- Inspect labels and machine names of breakpoints.
- List breakpoints from the command line via Drush.
- Onboard a new themer to a site's responsive setup.
- Spot duplicated or conflicting breakpoint definitions.
- Validate a newly added *.breakpoints.yml file.
- Reference exact media-query strings when writing CSS.
- Review breakpoint groups before configuring Responsive Image.
- Provide a quick reference during front-end QA.