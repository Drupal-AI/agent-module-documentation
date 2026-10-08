<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alternative Color lets administrators recolor a supported theme from its theme settings page and injects the chosen colors into every page as CSS custom properties, replacing the legacy core Color module.

---

Alternative Color (altcolor) is a modern, no-code replacement for the deprecated core Color module. A theme opts in by shipping a `THEME.colors.yml` file that declares configurable color variables and optional named schemes; the module then adds a "Color scheme" section (with a live front-page preview iframe) to that theme's settings form under Appearance. Selected colors are stored in the theme's `third_party_settings.altcolor.colors` and, on every request, emitted as `--color-<name>: <value>;` declarations on the `<html>` element's `style` attribute, so they override the defaults the theme defined in CSS. It carries no content model, no routes of its own, no permissions, and no Drush commands — it is purely a theming utility for Drupal 10 and 11. Colors are discovered through an `altcolor:ThemeColors` YAML plugin type, base/sub-theme color definitions are inherited down the theme chain, and a `hook_altcolor_alter_colors` alter hook lets themes or modules add derived colors (e.g. computed lighter/darker shades) before they are written to the page.

---

- Give site editors a UI to recolor a theme without writing CSS.
- Replace the removed core Color module on Drupal 10/11 sites.
- Match a theme to a client's brand or logo colors.
- Define named, one-click color schemes (e.g. "Aqua depths", "Arctic stream") a theme ships.
- Let users pick a shipped scheme or enter fully custom hex colors.
- Preview color changes live against the real front page in an embedded iframe before/after saving.
- Expose theme colors as standard CSS custom properties (`--color-<name>`) for use anywhere in theme CSS.
- Add relative/derived colors (lighter, darker, hue-shifted) via CSS Color 5 `hsl(from …)` syntax.
- Compute derived colors in PHP with a third-party color library through `hook_altcolor_alter_colors`.
- Make a custom theme "recolorable" by adding just a `THEME.colors.yml` — no extra CSS/JS plumbing.
- Inherit color definitions from a base theme into sub-themes automatically.
- Override a base theme's color palette in a sub-theme's own `colors.yml`.
- Store color choices in theme config so they export/import with configuration management.
- Ship default color values as schemes so a fresh install already looks branded.
- Provide seasonal or campaign color variants selectable from the theme settings page.
- Support multi-theme sites where each supported theme has its own independent palette.
- Keep color output cache-aware (theme cache context + theme config dependency) so pages stay cacheable.
- Offer a lightweight alternative to full theme forks just to change colors.
- Let front-end developers standardize on CSS variables while giving admins control of the values.
- Drive dark/light or accent variations from a single admin-chosen base color using relative CSS colors.
