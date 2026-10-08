<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — field formatters & library

## Formatters

Both plugins live in `src/Plugin/Field/FieldFormatter/`, extend a thin `VideoJsPlayerFormatterBase` (which extends core `FileFormatterBase`), and apply to `file` and `video` field types.

| Formatter id | Class | Applies when | Output |
|---|---|---|---|
| `videojs_player` | `VideoJsPlayerFormatter` | field is **not** a list (`!isList()`) | one `<video>` per item |
| `videojs_player_list` | `VideoJsPlayerListFormatter` (extends the above) | field **is** a list | one `<video>` with one `<source>` per item |

Select on *Manage display* (`/admin/structure/types/manage/<bundle>/display`) for the video/file field, or set the display component's `type` in the `core.entity_view_display.*` config.

## Formatter settings (`defaultSettings()`)

| Setting | Default | Widget | Notes |
|---|---|---|---|
| `width` | `854` | textfield (required) | pixels; written to inline `style`. |
| `height` | `480` | textfield (required) | pixels; written to inline `style`. |
| `controls` | `TRUE` | checkbox | adds `controls` attribute. |
| `autoplay` | `FALSE` | checkbox | adds `autoplay` attribute. |
| `loop` | `FALSE` | checkbox | adds `loop` attribute. |
| `muted` | `FALSE` | checkbox | adds `muted` attribute. |
| `preload` | `none` | select | `none` \| `metadata` \| `auto`. |

`viewElements()` builds `#theme => 'videojs'`, passes `#player_attributes => $this->getSettings()`, sets `#items` to absolute file URLs (`FileUrlGenerator::generateAbsoluteString()`), and attaches the `videojs/videojs` library. `settingsSummary()` prints a one-line `HTML5 Video (WxH, controls, ...)` summary.

## Rendered markup

`templates/videojs.html.twig` produces:

```html
<video data-setup="{}" class="video-js vjs-default-skin vjs-big-play-centered"
       preload="none" controls style="width:854px;height:480px;">
  <source src="<absolute-file-url>"/>
</video>
```

Attributes (`controls`, `autoplay`, `loop`, `muted`) are emitted only when their setting is truthy. `data-setup="{}"` lets Video.js auto-initialize.

## Library location (`videojs.settings`)

Config object (schema `config/schema/videojs.schema.yml`, defaults `config/install/videojs.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `videojs_location` | `cdn` | `cdn` or local; where the library is served from. |
| `videojs_directory` | `//vjs.zencdn.net/5.0` | path/URL root that contains `video.js`. |

There is **no admin form** — set these via config or drush:

```bash
drush config:set videojs.settings videojs_location local -y
drush config:set videojs.settings videojs_directory 'libraries/video-js' -y
```

The actual asset that loads is the `videojs/videojs` library in `videojs.libraries.yml`, which hard-codes the Video.js 5.x CDN (`//vjs.zencdn.net/5.0/video.min.js` + `video-js.min.css`). To self-host, override that library (e.g. via `hook_library_info_alter` or a `libraries-override` in your theme) to point at a local copy. `videojs_get_version($path)` (`videojs.module`) fetches the first 400 bytes of `<path>/video.js` and regex-matches a version string; it's a helper, not called during normal rendering.
