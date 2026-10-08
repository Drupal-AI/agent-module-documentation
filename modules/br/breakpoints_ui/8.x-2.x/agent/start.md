<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Breakpoints UI (`breakpoints_ui`) — agent index
**Read-only admin overview of all breakpoints from installed themes/modules.**

- **Version:** 8.x-2.x  | **Core:** ^8.8 || ^9 || ^10
- **Depends on:** core `breakpoint`
- **Route:** `/admin/config/media/breakpoints` (`breakpoints_ui.overview`) — gated by `access content` (**effectively anonymous**).
- **Service:** `breakpoints_ui` (`BreakpointsUiService`) parses `*.breakpoints.yml`. Drush in `Commands/BreakpointsUiCommands.php`.

**Security:** the overview route uses only `access content`, so anonymous users can view the breakpoint listing. Content is non-sensitive breakpoint metadata read from code (no entity/DB data), so this is a D1 access-hardening note, not a disclosure of secrets.
