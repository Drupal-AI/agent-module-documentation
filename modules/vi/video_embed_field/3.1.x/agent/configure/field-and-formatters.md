# Field, widget & formatters

Add a **Video Embed** field (`video_embed_field`) to any entity in Field UI. The widget is a
single text box (`VideoTextfield`) where editors paste a provider URL; a validation constraint
rejects URLs no provider matches.

## Field settings
- `allowed_providers` (sequence of provider ids) — restrict which hosts are accepted. Empty = all.

## Formatters (Manage display)
| Formatter | id | Purpose |
|---|---|---|
| Video | `video_embed_field_video` | Full responsive/​fixed iframe embed |
| Thumbnail | `video_embed_field_thumbnail` | Local preview image, optionally linked |
| Lazy load | `video_embed_field_lazyload` | Thumbnail that swaps to the iframe on click |
| Colorbox | `video_embed_field_colorbox` | Thumbnail opening the video in a Colorbox modal |
| Video URL | `video_embed_field_url` | Raw URL output |

## Common formatter settings (`defaultSettings`)
- `responsive` (bool, default TRUE) — fill container width; hides width/height.
- `width` / `height` (default 854 / 480) — used when not responsive.
- `autoplay` (bool, default TRUE) — bypassed for roles with `never autoplay videos`.
- `loading` (`lazy`|`eager`, default `lazy`) — iframe `loading` attribute.
- `title_format` / `title_fallback` — iframe title text.
- Thumbnail/Colorbox add: `image_style`, `link_image_to` (`content`|`provider`|nothing),
  and Colorbox adds `modal_max_width`.

Formatter config is stored as `core.entity_view_display.*` with these keys under
`settings`; schema in `config/schema/video_embed_field.schema.yml`.
