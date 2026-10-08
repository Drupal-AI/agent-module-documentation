# Browsersync — agent index

Developer/theming tool. Injects the Browsersync client `<script>` before `</body>` for live-reload /
CSS-injection during theme development. Does not run the Browsersync server itself. No config route of
its own (settings live on the theme settings form), no Drush.

- **Per-theme settings, the `use browsersync` permission, the injected snippet, CSS handling** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Settings on Appearance → Settings → <theme> (`hook_form_system_theme_settings_alter`), stored as theme
  third-party settings `third_party_settings.browsersync.{enabled,host,port}` (schema
  `theme_settings.third_party.browsersync`).
- `hook_page_bottom` injects `#theme => browsersync_snippet` only when enabled AND current user has
  `use browsersync`.
- Defaults: host `HOST` (replaced by `location.hostname` in JS), port `3000`.
