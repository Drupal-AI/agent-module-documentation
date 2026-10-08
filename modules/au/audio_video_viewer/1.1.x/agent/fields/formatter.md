<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Audio Video Viewer" field formatter

## Install & enable

```bash
composer require drupal/audio_video_viewer
drush en audio_video_viewer -y
```

Requires core **`file`** (the plugin extends `FileFormatterBase` and targets file fields). No
sub-modules, no permissions of its own, no Drush commands.

## Enable it on a field

Plugin id **`audio_video_viewer`**, label *"Audio Video Viewer"*, in
`src/Plugin/Field/FieldFormatter/AudioVideoViewer.php`. It applies only to **core file fields**
(`@FieldFormatter … field_types = { "file" }`) — not link, image, or media-reference fields.

UI path: *Structure → (bundle) → Manage display* → set the File field's format to **Audio Video
Viewer** → click the gear to set the options below.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_media.type audio_video_viewer -y
drush cr
```

## Formatter settings

From `defaultSettings()` and `settingsForm()`:

| Setting key | Default | Meaning |
|---|---|---|
| `show_file_link` | `0` | Show the file's name as an `<a href>` link above the player (Twig `show_file_link`). |
| `show_file_size` | `0` | Show the file size in bytes (`file->getSize()`). |
| `max_file_size` | `0` | Max renderable size **in bytes**; `0` = unlimited. Files above it degrade to a download link. `#element_validate` `validateSize()` requires a numeric value ≥ 0. |
| `return_empty` | `0` | If a file is not recognised (or path missing), render **nothing** (`return []`) instead of a link — lets you chain the [fallback_formatter](https://www.drupal.org/project/fallback_formatter) module. |
| `video_original` | `1` | "Autofit video size": emit `<video>` with no inline size (uses available space). When off, apply `video_width`/`video_height`. |
| `video_width` | `320px` | CSS width when not autofit; must match `\d+px` or `\d+%` (`maxlength 10`). |
| `video_height` | `240px` | CSS height when not autofit; same pattern. |
| `video_preload` | `metadata` | `none` \| `metadata` \| `auto` — the `<video preload>` attribute. |
| `audio_original` | `1` | "Auto set by the browser": emit `<audio>` with no inline width. When off, apply `audio_width`. |
| `audio_width` | `320px` | CSS width when not auto; must match `\d+px` or `\d+%`. |
| `audio_preload` | `metadata` | `none` \| `metadata` \| `auto` — the `<audio preload>` attribute. |

`settingsSummary()` always shows *"Display audio/video."* and adds *"Empty if file type is
unrecognized."* when `return_empty` is on.

Width/height are validated by `isValidWidthOrHeight()` (regex `^\d+px$` or `^\d+%$` /
`^\d+\.\d+%$`). Note the checkbox `#states` on the form use a per-render `rand()` marker class
(`video_original-<n>` / `audio_original-<n>`) to show/hide the size fields.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_media:
    type: audio_video_viewer
    label: above
    settings:
      show_file_link: 0
      show_file_size: 0
      max_file_size: 0
      return_empty: 0
      video_original: 1
      video_width: '320px'
      video_height: '240px'
      video_preload: metadata
      audio_original: 1
      audio_width: '320px'
      audio_preload: metadata
```

(No `config/schema/` ships for these formatter settings, so strict config-schema tooling may flag
the view-display config; the settings still save and work.)

## How a file becomes a player (`viewElements()`)

1. Reads site config `audio_video_viewer.settings`: `allow_all_video_extensions`,
   `allow_all_audio_extensions`, and the space-separated `supported_*_extensions` lists
   (`explode(" ", …)`).
2. For each entity from `getEntitiesToView($items, $langcode)` (honors core file access/display):
   - `path = file_system->realpath($file->getFileUri())`; if `FALSE`, markup becomes a "server
     error … file could not be found" message (and `return []` if *return_empty*).
   - `mimetype = $file->getMimeType()`, `filename = $file->getFilename()`,
     `filepath = file_url_generator->generateAbsoluteString($file->getFileUri())`,
     `ext = pathinfo($filename, PATHINFO_EXTENSION)`.
3. **Type decision:**
   - If the extension qualifies as **both** audio and video (or both "allow all" flags are on),
     type = the prefix of the MIME type (`explode("/", $mimetype)[0]`). If that prefix is neither
     `audio` nor `video`, degrade to a download link and push a messenger error.
   - Otherwise type is `audio` or `video` if the extension is in that list (or its "allow all"
     flag is on).
4. Size / validity guards (each degrades to a download link + messenger error):
   `max_file_size > 0` and `file->getSize()` exceeds it; a `video` with autofit off and an invalid
   `video_width`/`video_height`; an `audio` with auto off and an invalid `audio_width`.
5. If type is still empty, degrade to a download link (or `return []` when *return_empty*).
6. Build `$source = ['src' => $filepath, 'mimetype' => $mimetype]` and render:
   - audio → `#theme => 'audio_tag'` with `#sources`, `#show_file_link`, `#show_file_size`,
     `#file_path`, `#file_name`, `#file_size`, `#audio_original`, `#audio_width`, `#audio_preload`.
   - video → `#theme => 'video_tag'` with the analogous video keys (`#video_original`,
     `#video_width`, `#video_height`, `#video_preload`).
   - fallback → `#markup` (the download link / error string).

The `src` is always the **managed file's own URI** turned into an absolute URL — there is no
request- or config-supplied path fetched, and no remote/oEmbed lookup.

## Templates

`templates/audio-tag.html.twig` and `templates/video-tag.html.twig` (theme hooks declared in
`audio_video_viewer_theme()`):

- Optional label block: when `show_file_link`, an `<a href={{ file_path }}>{{ file_name }}</a>`
  (with `( {{ file_size }} bytes)` if `show_file_size`); else just the size line if
  `show_file_size`.
- Player: `<audio controls preload="{{ audio_preload }}">` (or with
  `style="width:{{ audio_width }};"` when `audio_original` is false) / `<video controls
  preload="{{ video_preload }}">` (or `style="width:{{ video_width }}; height:{{ video_height }};"`
  when `video_original` is false), each looping `{% for source in sources %}<source
  src="{{ source.src }}" type="{{ source.mimetype }}"/>{% endfor %}`.

All template variables are Twig auto-escaped. Override either template in a theme to restyle the
players.

## Built-in MIME hints

`getSupportedAudio()` / `getSupportedVideo()` return static maps (`mp3→audio/mpeg`, `ogg→audio/ogg`,
`wav→audio/x-wav`; `mp4→video/mp4`, `ogg→video/ogg`, `webm→video/webm`) but these private methods
are **not called** by `viewElements()` — actual type detection uses the site config lists plus the
file's real MIME type. The default install lists (`mp3 ogg wav` / `mp4 webm ogg`) mirror them.
