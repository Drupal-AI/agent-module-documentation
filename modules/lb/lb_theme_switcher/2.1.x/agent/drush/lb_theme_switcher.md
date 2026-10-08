<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LB Theme Switcher — Drush: reset LB header/footer

Command `lb_theme_switcher:reset-lb-header-footer` (alias `lbreset`), class
`LbThemeSwitcherCommands`. Resets the `ws_header` and `ws_footer` Layout Builder
sections on nodes back to the section template defined on their entity view
display — useful after a theme switch changes the shared header/footer template.

## Usage
```
drush lb_theme_switcher:reset-lb-header-footer <bundle> [mode] [--dry-run]
drush lbreset all                # process every LB-enabled node bundle/display
```
- `bundle` — content type to reset (or `all` for every LB node display).
- `mode` — view mode holding the LB template (default `default`; some types use `full`).
- `--dry-run` — report what would change without saving.

## Behaviour
- Loads the `node.<bundle>.<mode>` `LayoutBuilderEntityViewDisplay` as the template
  and extracts its `ws_header` / `ws_footer` sections.
- For each node of the bundle, replaces its header/footer sections with the template
  ones **only when they differ**, then saves (unless `--dry-run`).
- Prompts for confirmation (single bundle and `all`); `all` skips displays with no
  header/footer template and bundles with no nodes, and prints a per-bundle summary
  of found vs. updated nodes.
- Uses `entityQuery(...)->accessCheck(FALSE)` — it is an administrative CLI operation
  intended to run with full privileges.
