# Browsersync — configuration

No dedicated config route. Settings are attached to the **theme settings form**.

## Settings (per theme)

`hook_form_system_theme_settings_alter` (`BrowsersyncFormHooks::systemThemeSettingsAlter`) adds a
"Browsersync settings" details group to Appearance → Settings → <theme> (and the global theme settings):

- **Enable Browsersync** (`browsersync_enabled`) — checkbox.
- **Host** (`browsersync_host`) — override host detection (e.g. a fixed IP). Optional.
- **Port** (`browsersync_port`) — override the auto-detected port. Optional.

On submit (`SettingsForm::submitForm`) these are written to config `<theme>.settings` (or
`system.theme.global` for the global form) under:

```
third_party_settings.browsersync.enabled
third_party_settings.browsersync.host
third_party_settings.browsersync.port
```

Schema: `theme_settings.third_party.browsersync` (`enabled` bool, `host` string, `port` string).
Values are read per active/named theme by `BrowsersyncHelper::browsersyncGetSetting()`.

## Permission

`use browsersync` (`browsersync.permissions.yml`) — controls whether the client script is injected for a
given user. Grant it to developer roles only.

## Snippet injection

`hook_page_bottom` (`BrowsersyncHooks::pageBottom`) adds `['#theme' => 'browsersync_snippet', '#weight'
=> 100]` (plus host/port overrides) **only if** the theme's `enabled` setting is on AND the current user
has `use browsersync`. Template `browsersync-snippet.html.twig` outputs:

```html
<script id="__bs_script__">
  document.write("<script async src='//HOST:3000/browser-sync/browser-sync-client.js'><\/script>"
    .replace("HOST", location.hostname));
</script>
```

Default host token `HOST` is replaced by `location.hostname` in the browser; port defaults to `3000`.
The Host/Port settings replace these defaults.

## CSS handling

`hook_css_alter` (`BrowsersyncHooks::cssAlter`): when Browsersync is enabled and core
`system.performance` `css.preprocess` is OFF, non-core CSS files are set to `preprocess = FALSE` so they
emit as individual `<link>` elements — Browsersync CSS injection does not work with `@import`-aggregated
CSS.

## Note

This is a local-development/theming aid; maintainers state it is not intended for production. You must
run the Browsersync server yourself (CLI / Gulp / Grunt) — the module only injects the client script.
