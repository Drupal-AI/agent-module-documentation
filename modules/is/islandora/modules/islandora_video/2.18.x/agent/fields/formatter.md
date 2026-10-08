# Field formatter: `islandora_file_video`

`IslandoraFileVideoFormatter` (`src/Plugin/Field/FieldFormatter/IslandoraFileVideoFormatter.php`), extends core
`\Drupal\islandora\Plugin\Field\FieldFormatter\IslandoraFileMediaFormatterBase` (subclass of Drupal core's
`FileMediaFormatterBase`).

- **id:** `islandora_file_video` · **label:** "Video with Captions" · **field type:** `file`
- **`getMediaType()`** returns `video`, rendering through core's `<video>` HTML5 support.

Assign it on a media type's **Manage display** for the file field you want to play.

## Settings

Adds three settings on top of the base (`defaultSettings()` / `settingsForm()` / `settingsSummary()`):

| setting | default | control |
|---|---|---|
| `muted` | `FALSE` | checkbox (passed through `prepareAttributes(['muted'])`) |
| `width` | `640` | number, pixels, required |
| `height` | `480` | number, pixels, required |

`prepareAttributes()` sets `width`/`height` as attributes on the `<video>` tag. Settings schema:
`field.formatter.settings.islandora_file_video` → core `field.formatter.settings.file_video` (play/download,
preload, multiple-file, etc.).

## Captions

The base formatter's `getTrackFiles()` scans the parent media for `media_track` fields and emits `<track>`
elements (src / `srclang` / `label` / `kind` / `default`). The template `templates/islandora-file-video.html.twig`
(theme hook `islandora_file_video`, vars `files`, `tracks`, `attributes`) renders `<video>` with `<source>` and
`<track>` children — captions display natively in the video's native track UI (no companion JS, unlike the audio
submodule).
