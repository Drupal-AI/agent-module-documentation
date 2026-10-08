# Theming & rendering

## Theme hook / template

The style renders through the theme hook **`views_timelinejs_view_timelinejs`** (declared on the
`@ViewsStyle` plugin as `theme = "views_timelinejs_view_timelinejs"`). Default template:
`templates/views-timelinejs-view-timelinejs.html.twig`. Override it in your theme as
`views-timelinejs-view-timelinejs.html.twig` (standard Views style suggestion applies, e.g.
`views-timelinejs-view-timelinejs--<view-id>.html.twig`).

`template_preprocess_views_timelinejs_view_timelinejs()` prepares the variables: it attaches the
TimelineJS library variant chosen by `views_timelinejs.settings:library_location`, attaches the
module's `create_timeline` library (`js/views_timelinejs.js`, depends on `core/drupal` +
`core/drupalSettings`), builds a unique wrapper id, and passes the slide/era data and the
sanitized timeline options into `drupalSettings` so the JS can call `new TL.Timeline(...)`.

## Data shape

The plugin's `render()` builds a `Timeline` object from the value objects in
`src/TimelineJS/*` (`Slide`, `TitleSlide`, `Era`, `Date`, `Media`, `Background`, `Text`,
`Timeline`) and calls `->buildArray()`, producing the JSON structure TimelineJS expects
(`{ title, events, eras }`). In a View **preview** the plugin instead dumps that array as
`<pre>` text instead of theming it, which is handy for debugging field mappings.

## Libraries (`views_timelinejs.libraries.yml`)

- `timelinejs.cdn`, `timelinejs.cdn_3.9.7`, `timelinejs.cdn_3.8.18` — external CSS/JS from
  `cdn.knightlab.com/libs/timeline3/...` (MPL, not GPL-compatible; loaded remotely).
- `timelinejs.local` — expects `/libraries/timeline3/{css,js}/timeline.{css,js}`.
- `create_timeline` — the module's own `js/views_timelinejs.js` init script.

There is no separate theme doc needed beyond overriding the one template; the rest is data +
drupalSettings driven.
