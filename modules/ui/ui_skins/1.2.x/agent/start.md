# UI Skins — agent index

Themes (or modules) declare editable **CSS variables** and **theme/skin attribute presets** as YAML
plugins; admins set them in the theme settings UI; the module injects an inline `<style>` of CSS custom
properties and merges body/html attributes on every page. Core `administer themes` gates everything; no
own permissions, Drush, or services beyond two plugin managers. PHP 8.3, Drupal ^11.4 || ^12.
No `configure` route (uses derived per-theme routes under `/admin/appearance/css-variables`).

- **The two YAML plugin types (`ui_skins.css_variables`, `ui_skins.themes`), their keys, discovery,
  base-theme filtering, and the `ui_skins_alpha_color` render element** →
  [plugins/plugins.md](plugins/plugins.md)
- **The settings forms, where values are stored (theme `*.settings` third-party `ui_skins`), scopes,
  routes** → [configure/theme-settings.md](configure/theme-settings.md)
- **How values reach the page: `hook_page_top` inline CSS + `hook_preprocess_html` attributes/library,
  and where the inline CSS values come from** → [theming/rendering.md](theming/rendering.md)

Key facts:
- CSS variable YAML: `{id}: {type, label, description, category, default_values: {"<scope>": "<value>"}}`.
- Theme YAML: `{id}: {label, target: body|html, key: class, value, library, dependencies: []}`.
- Plugins are filtered per theme: a plugin applies if its provider is an enabled module or is the theme
  (or one of its base themes).
