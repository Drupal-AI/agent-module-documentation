# MediaElement theming & JS

## Theme hooks (`mediaelement_theme()`)

| Hook | Template | Variables |
|---|---|---|
| `mediaelement_file_video` | `templates/mediaelement-file-video.html.twig` | `files`, `attributes`, `download_link`, `download_text` |
| `mediaelement_file_audio` | `templates/mediaelement-file-audio.html.twig` | same |

Both share the preprocess `mediaelement_preprocess_mediaelement_file()`, which adds the
`mediaelementjs` class to `attributes`. Markup is a `<video>`/`<audio>` tag with one `<source>` per
file; when `download_link` is on, a `<a href="{{ file.source_attributes.src }}">{{ download_text }}</a>`
is emitted after the first source.

## JS (`js/mediaelement.bundle.js`, `Drupal.behaviors.mediaelement`)

- Initializes `mediaelementplayer(settings.mediaelement)` on `audio.mediaelementjs, video.mediaelementjs`.
- If `settings.mediaelement.attachSitewide` is defined (i.e. *attach sitewide* enabled), it **also**
  upgrades plain `audio, video` tags on the page.
- Uses jQuery + `core/once`; options come from `drupalSettings.mediaelement` (the flattened,
  camel-cased global settings — see configure/settings.md).

## Libraries

- `mediaelement_local` (static, `mediaelement.libraries.yml`) → `/libraries/mediaelement/build/…` +
  `js/mediaelement.bundle.js`; deps `core/jquery`, `core/once`, `core/drupal`, `core/drupalSettings`.
- `mediaelement_cdnjs` (built at runtime by `hook_library_info_build()` for the selected CDN version).
