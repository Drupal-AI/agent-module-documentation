# MediaElement field formatters

Two formatters for **`file`** fields, set on an entity's *Manage display* tab. Both extend the
corresponding core file formatter and mix in `MediaElementFieldFormatterTrait`.

| Formatter id | Extends | Field type |
|---|---|---|
| `mediaelement_file_video` | core `FileVideoFormatter` | `file` |
| `mediaelement_file_audio` | core `FileAudioFormatter` | `file` |

## Shared settings (trait)

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `preload` | select | `none` | HTML `preload` attribute: `auto` / `metadata` / `none`. |
| `download_link` | checkbox | `false` | Render a download link near the player. |
| `download_text` | textfield | '' | Link text (visible only when `download_link` is on). |

`viewElements()` (trait) sets the `preload` attribute, passes `#download_link`/`#download_text` to the
template, adds the `mediaelementjs` class, and attaches `mediaelement/mediaelement_<library_source>`
(source read from `mediaelement.settings`).

## Video-only settings (`MediaElementVideoFieldFormatter`)

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `poster_image_field` | select | `none` | Another **image** field on the same bundle to use as the poster/thumbnail. Options come from `entity_field.manager` image fields for the bundle. |
| `poster_image_style` | select | `raw` | Image style for the poster (`raw` = original), applied via `image_style` storage / `file_url_generator`. |

When a poster field is set and non-empty, the built file URL (transformed relative) is set as the
`<video poster="…">` attribute. The formatter injects `entity_type.manager`, `entity_field.manager`,
and `file_url_generator` services.

## Config schema

- `field.formatter.settings.mediaelement_file_video` / `…_audio` (see `config/schema/mediaelement.schema.yml`);
  video adds `poster_image_field` / `poster_image_style`.

## D7 migration

`hook_field_migration_field_formatter_info()` maps legacy D7 `file` formatters
`mediaelement_video`→`mediaelement_file_video` and `mediaelement_audio`→`mediaelement_file_audio`.
