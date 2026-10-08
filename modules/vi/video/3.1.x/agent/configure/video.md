# Configure the video field, widgets & formatters

Video has **no global admin settings page** (`video.info.yml` declares no `configure` route).
All configuration happens on the field and its form/display in Field UI, or via config.

## Add the field

Structure → *content type* → Manage fields → Add field → choose **Video** (category
"reference"). Field type id `video` (extends core `FileItem`, stores a `target_id` file
reference plus a `data` metadata column). Default widget `video_embed`, default formatter
`video_embed_player`.

Field settings (`field.field_settings.video`): `file_directory`
(default `videos/[date:custom:Y]-[date:custom:m]`), `file_extensions`, `max_filesize`,
`handler` / `handler_settings`. Storage settings add `default_video` (uuid + data).

## Widgets (Manage form display)

| Widget id | Label | Use | Key settings |
|---|---|---|---|
| `video_embed` | Video Embed | Paste a provider URL | `allowed_providers` (default `youtube`), `file_directory` (thumbnail dir, default `video-thumbnails/[date:custom:Y]-[date:custom:m]`), `uri_scheme` (default `public`) |
| `video_upload` | Video Upload | Upload a file | `file_extensions` (default `mp4 ogv webm`), `file_directory`, `max_filesize`, `uri_scheme` (default `public`), `progress_indicator` |

`video_embed` validates the pasted URL against the enabled providers and, on save, creates a
managed `file` entity under the provider's stream wrapper (e.g. `youtube://<id>`), storing the
regex match data serialized in the field's `data` column. `allowed_providers` unchecked = all
providers allowed.

## Formatters (Manage display)

| Formatter id | Label | For | Settings |
|---|---|---|---|
| `video_embed_player` | Embedded Video Player | remote embeds | `width` (854), `height` (480), `autoplay` (true), `related_videos` (false) |
| `video_embed_thumbnail` | (thumbnail) | remote embeds | `image_style`, `link_image_to` |
| `video_player` | HTML5 Video Player | uploaded files | `width`, `height`, `controls` (true), `autoplay` (false), `loop` (false), `muted` (false), `preload` (`none`) |
| `video_player_list` | HTML5 Video Player (list) | uploaded files | same as `video_player` |
| `video_url` | (raw URL) | uploaded files | — |

The HTML5 formatters render the `video_player_formatter` theme hook
(`templates/video-player-formatter.html.twig`). Embed formatters delegate to the matching
provider plugin's `renderEmbedCode()`.

## Config & schema

All widget/formatter/field settings are covered by `config/schema/video.schema.yml`
(`provides_config_schema: true`), so field and display config export/deploy with
`drush config:export`. There is no standalone settings config object.

## Multiple videos

Raise the field's cardinality (Storage settings → Allowed number of values) to upload several
files, e.g. multiple HTML5 `<source>` formats for one clip.
