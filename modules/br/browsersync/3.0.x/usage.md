Browsersync injects the Browsersync (Node.js) client `<script>` just before `</body>` so a running Browsersync server can live-reload and CSS-inject your Drupal site during theme development. It is a developer/theming tool; it does not run Browsersync for you.

---

Configuration is per theme, exposed on the theme settings form (Appearance → Settings → <theme>) via
`hook_form_system_theme_settings_alter`: an "Enable Browsersync" checkbox plus optional Host and Port
overrides, saved as theme third-party settings (`third_party_settings.browsersync.enabled|host|port` in
`<theme>.settings` or `system.theme.global`; schema `theme_settings.third_party.browsersync`).
`hook_page_bottom` adds the `browsersync_snippet` render element to the bottom of the page only when the
setting is enabled **and** the current user has the `use browsersync` permission — so the client script
is normally shown only to authenticated developers, not anonymous visitors. The Twig template
`browsersync-snippet.html.twig` writes a `<script async src="//HOST:PORT/browser-sync/browser-sync-client.js">`,
with `HOST` replaced client-side by `location.hostname` (defaults host `HOST`, port `3000`), overridable
via the Host/Port settings. `hook_css_alter` disables CSS aggregation for non-core files while
Browsersync is enabled and core CSS preprocessing is off, because Browsersync's CSS injection does not
work with `@import`-aggregated stylesheets. You still run Browsersync yourself from the CLI / Gulp /
Grunt. Maintainers note it is meant for local development, not production. No Drush, no config UI route
of its own (settings live on the theme form).

---

- Live-reload the browser when Twig, CSS, or JS files change during theme work.
- Inject changed CSS without a full page reload while styling a theme.
- Enable Browsersync only for a specific theme (e.g. your custom front-end theme).
- Restrict the injected client script to developers via the `use browsersync` permission.
- Override the Browsersync host when the auto-detected IP is wrong (e.g. Docker/DDEV).
- Override the Browsersync port when not using the default 3000.
- Keep the snippet out of anonymous page loads by not granting anonymous the permission.
- Force non-core CSS to load as `<link>` (unaggregated) so CSS injection works.
- Pair with a Gulp or Grunt Browsersync task for a full front-end workflow.
- Sync scroll/clicks across multiple devices pointed at the dev site (Browsersync feature).
- Toggle Browsersync per environment by enabling it only in the local theme settings.
- Add live-reload to an existing Drupal theme without editing template files.
- Use the global theme settings to enable it across the default theme.
- Provide a consistent live-reload setup for a team via committed theme third-party settings.
- Debug responsive layouts with Browsersync's multi-device mirroring during development.
