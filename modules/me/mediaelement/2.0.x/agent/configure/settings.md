# MediaElement global settings

Form: `MediaElementConfigForm` at **`/admin/config/media/mediaelement/config`** (route
`mediaelement.config`, permission *administer mediaelement*). Edits config object `mediaelement.settings`.

## Library source

Radio `library_source` (required):

| Value | Behavior |
|---|---|
| `local` (default) | Loads `mediaelement/mediaelement_local` → assets from `/libraries/mediaelement/build/…` (you must self-host the library there). |
| `cdnjs` | Loads a dynamically-built library from `//cdnjs.cloudflare.com/ajax/libs/mediaelement/<version>`. The version `<select>` options are fetched **live from the CDNJS API** (`https://api.cdnjs.com/libraries/mediaelement`) when the form builds. |

The CDN library is assembled in `hook_library_info_build()` for the selected version; `iconSprite`
(controls SVG) URL is derived from the same base in `hook_preprocess_html()`.

## Global settings

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `attach_sitewide` | checkbox | `0` | Attach the player library on **every** page so any `<audio>`/`<video>` tag is upgraded. |
| `player_settings.class_prefix` | textfield | '' (placeholder `mejs__`) | Class prefix for player elements. |
| `player_settings.set_dimensions` | checkbox | on | Set dimensions via JS instead of CSS. |
| `video_settings.default_video_width` / `_height` | number | 480 / 270 (placeholders) | Used when the `<video>` tag omits the dimension. |
| `video_settings.video_width` / `video_height` | number | -1 | If set, **override** the video dimensions. |
| `audio_settings.default_audio_width` / `_height` | number | 400 / 30 | Defaults when omitted. |
| `audio_settings.audio_width` / `audio_height` | number | -1 | Override audio dimensions. |

`submitForm` only persists non-empty values (0 is kept). On save the settings are grouped under
`library_settings` and `global_settings.{player,video,audio}_settings`.

## How settings reach JS

`hook_preprocess_html()` runs `mediaelement_parse_config()` → `mediaelement_flatten_config()` (deep-flattens
the nested arrays) then camel-cases each key, and exposes the result as
`drupalSettings.mediaelement` (e.g. `default_video_width` → `defaultVideoWidth`). When
`attach_sitewide` (flattened to `attachSitewide`) is truthy, the `mediaelement/mediaelement_<source>`
library is attached globally.

## Default install config

```yaml
# config/install/mediaelement.settings.yml
library_settings:
  library_source: 'local'
global_settings:
  attach_sitewide: 0
```

`hook_update_8101` sets `attach_sitewide` FALSE on existing sites. Because the default source is
`local`, players do nothing until you either place the library at `/libraries/mediaelement/build` or
switch the source to `cdnjs`.
