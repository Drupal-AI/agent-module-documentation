# Lottie source, formatter & validator

The module defines three plugins (it does **not** define a new plugin *type* — it implements core
Media/Field/Validation plugin types).

## Media source: `lottie_file`

`Drupal\media_entity_lottie\Plugin\media\Source\LottieFile` extends core `File`.

- `@MediaSource(id="lottie_file", allowed_field_types={"file"}, default_thumbnail_filename="lottie.png")`.
- `createSourceField()` → source field is a `file` field with `file_extensions = 'json'`.
- `getSourceFieldConstraints()` adds the `lottie_file` validation constraint to the source field.
- `prepareViewDisplay()` sets the source field's display formatter to `file_lottie_player`.
- **Metadata attributes** (`getMetadata()` reads the decoded JSON):

  | Attribute | JSON key |
  |---|---|
  | `width` | `w` |
  | `height` | `h` |
  | `name` | `nm` |
  | `version` | `v` |
  | `frames` | `fr` |

- `media_entity_lottie_media_source_info_alter()` ensures the `media_library_add` form is set to
  core's `FileUploadForm`.

## Field formatter: `file_lottie_player`

`FileLottiePlayerFormatter` extends `FileMediaFormatterBase`, HTML tag `<lottie-player>`, media type
`application` (JSON). `isApplicable()` returns TRUE **only** when the field name contains
`field_media_lottie_file`.

Settings (`config/schema`: `field.formatter.settings.file_lottie_player`) and defaults:

| Setting | Default | Effect on `<lottie-player>` |
|---|---|---|
| `background` | `#FFFFFF` | `background` attribute (a `color` element, required) unless transparent. |
| `background_transparent` | `false` | Keeps background transparent (omits `background`). |
| `hover` | `false` | `hover` attribute — play on mouse hover. |
| `play_when_visible` | `false` | Attaches `media_entity_lottie/play_when_visible` (plays on viewport enter). |
| `mode` | `normal` | `mode` attribute (`normal` / `bounce`). |
| `speed` | `1` | `speed` attribute when > 1. |
| `count` | `0` | Loop count; `0` = undefined (infinite). |

`viewElements()` sets `src` to `$file->createFileUrl()` and always attaches
`media_entity_lottie/lottie_player`.

## Libraries (`media_entity_lottie.libraries.yml`)

- `lottie_player` → external `@lottiefiles/lottie-player` from **unpkg** (`latest`).
- `lottie_interactivity` → external `@lottiefiles/lottie-interactivity` from unpkg.
- `play_when_visible` → local `js/media_entity_lottie.play_when_visible.js`, depends on
  lottie_interactivity + core/drupal + core/jquery + core/once.

These are remote CDN libraries; on a locked-down/offline site override them with a local copy.

## Upload validator: `lottie_file` constraint

`LottieFileConstraint` + `LottieFileConstraintValidator` reject the upload when the file is empty,
not valid JSON, or missing required Lottie keys. Required keys checked: `fr`, `ip`, `op`, `w`, `h`,
`ddd`; keys `v` and `nm` are optional (a warning message is shown if absent). Messages: `%value is
empty!`, `%value is not a valid JSON file!`, `%value is not a valid Lottie file!`.
