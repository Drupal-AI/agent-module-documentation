UI Skins lets themes declare editable CSS custom properties ("CSS variables") and body/html attribute presets ("themes"/skins) as YAML plugins, then exposes them in the theme settings UI and injects the chosen values into every page.

---

The module defines two YAML-discovered plugin types. **CSS variable** plugins
(`{provider}.ui_skins.css_variables.yml`, managed by `CssVariablePluginManager`) each declare a CSS
custom property with an id, a form widget `type` (e.g. `textfield`, `color`, `ui_skins_alpha_color`),
label/description/category, and per-scope `default_values` (a "scope" is a CSS selector such as `:root`).
**Theme** plugins (`{provider}.ui_skins.themes.yml`, managed by `ThemePluginManager`) each declare an
attribute preset: a `target` (`body`→`attributes` or `html`→`html_attributes`), a `key` (default
`class`), a `value`, an optional attached `library`, and optional `dependencies` on other theme plugins.
A new theme settings screen at `/admin/appearance/css-variables/{theme}`
(`CssVariablesThemeSettingsForm`) lets admins set variable values per scope (adding extra scopes at
will), and a select added to each theme's own settings form (`hook_form_system_theme_settings_alter`)
picks the active skin. Values are saved into the theme's `*.settings` config under third-party settings
key `ui_skins`. At render time `hook_page_top` emits an inline `<style>` block building `selector{--var:
value;}` rules from the saved CSS variables, and `hook_preprocess_html` merges the selected theme's
attributes (and its dependency chain) onto the `<body>`/`<html>` element and attaches any declared
libraries. A custom `ui_skins_alpha_color` form element adds an RGBA (color + 0–255 alpha) picker. The
module has no permissions of its own — everything is gated by core `administer themes` — and no Drush or
services beyond the two plugin managers; it requires PHP 8.3 and Drupal 11.4+/12.

---

- Let site admins edit a theme's brand colors as CSS variables without touching CSS.
- Expose spacing, font-size, or radius design tokens as editable theme settings.
- Define a `--color-primary` custom property with a default and let it be overridden in the UI.
- Provide an RGBA color picker (with alpha channel) for a CSS variable via `ui_skins_alpha_color`.
- Set different values of a variable for different scopes/selectors (`:root`, `.dark`, `body`).
- Add extra scopes on the fly in the settings form to target more selectors.
- Ship a base theme's design tokens and let sub-themes inherit and override them.
- Offer selectable "skins" that toggle a body class (e.g. `theme-dark`, `theme-compact`).
- Attach a CSS/JS library automatically when a particular skin is selected.
- Chain skin dependencies so selecting one applies several coordinated presets.
- Add attributes to the `<html>` element (e.g. `data-theme`) instead of `<body>`.
- Group CSS variables into categories that render as vertical tabs in the settings form.
- Let editors preview default values alongside their overrides in the form.
- Keep theme customizations in exportable config (theme `*.settings`) for deployment.
- Provide a per-theme "CSS variables" admin screen linked from Appearance.
- Build a light/dark mode toggle backed by scoped CSS variable overrides.
- Centralize inline CSS-variable output so custom properties load on every page via `hook_page_top`.
- Localize/skin only specific themes because plugins are filtered to the theme (and its base themes).
- Define CSS variables or skins from a module (not just a theme) by shipping the YAML in the module.
- Reuse the `ui_skins_alpha_color` render element in custom forms needing hex+alpha input.
- Reset a variable to its default simply by matching the default value (the form drops unchanged values on save).
