<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Assets — the media stack it provisions

Everything below is created by the recipe config (`recipes/foundation/config/**` and
`recipes/default/config/**`), not by PHP. All is standard core Media / Image / Responsive Image
config; Web Assets just ships opinionated defaults.

![Media types provisioned by Web Assets](../../../../../../../screenshots/webassets/12.0.x/media-types.png)

## Seven media types

Five come straight from `recipes/foundation/config/media.type.*.yml`; the other two ship with the
Media Remote Audio / Media Remote Image modules and are re-imported by the recipe (`import: media_remote_audio: '*'`, `media_remote_image: '*'`).

| Type | id | source | source field | notes |
|------|----|--------|--------------|-------|
| Image | `image` | `image` | `field_media_image` | "Use local images for reusable media." |
| Document | `document` | `file` | `field_media_document` | "An uploaded file or document, such as a PDF." |
| Audio | `audio` | `audio_file` | `field_media_audio_file` | local audio |
| Video | `video` | `video_file` | `field_media_video_file` | local video |
| Remote video | `remote_video` | `oembed:video` | `field_media_oembed_video` | providers: YouTube, Vimeo; thumbnails in `public://oembed_thumbnails/[date:custom:Y-m]` |
| Remote audio | `remote_audio` | (media_remote_audio) | — | oEmbed audio providers |
| Remote image | `remote_image` | (media_remote_image) | — | oEmbed image |

All local types set `new_revision: true` and `queue_thumbnail_downloads: false`.

## Fields and allowed file extensions

Each local type has a `field.storage.media.*` + `field.field.media.*.*` pair. Source fields are
`required: true`, `translatable: true`, and store into `[date:custom:Y]-[date:custom:m]` subdirs.
Allowed extensions (from `field.field.media.*`):

- **Image** (`field_media_image`, type `image`): `png gif jpg jpeg`; `alt_field: true`,
  `alt_field_required: true`, `title_field: false`.
- **Document** (`field_media_document`, type `file`): `txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages`.
- **Audio** (`field_media_audio_file`, type `file`): `mp3 wav aac`.
- **Video** (`field_media_video_file`, type `file`): `mp4`.
- **Remote video** (`field_media_oembed_video`, type `string`): holds the oEmbed URL, no extensions.

Form displays (`core.entity_form_display.media.*.default` and `.media_library`) and view displays
(`core.entity_view_display.media.*.default` and `.media_library`) are provided for the local types so
the Add media dialog and Media Library both work immediately.

## Five media view modes

`core.entity_view_mode.media.<mode>.yml` (targetEntityType `media`, `cache: true`):
`origenal`, `square`, `standard`, `traditional`, `ultrawide`. **`origenal` is the module's own
machine name spelled verbatim — do not "correct" it to "original".**

## 35 image styles

`image.style.<family>_<size>.yml` for five families × seven sizes:

- Families: `origenal`, `square`, `standard`, `traditional`, `ultrawide`.
- Sizes: `tiny`, `small`, `medium`, `larg`, `xlarg`, `xxlarg`, `xxxlarg`.

Every style has a single `focal_point_scale_and_crop` effect (`crop_type: focal_point`) with a
family/size-specific width×height — e.g. `standard_medium` = 700×394, `square_tiny` = 200×200 (square
families crop to 1:1). This is why the module depends on Crop + Focal Point. (The site also carries a
few core default styles; Web Assets contributes the 35 listed here.)

![Image styles page](../../../../../../../screenshots/webassets/12.0.x/image-styles.png)

## Five responsive image styles

`responsive_image.styles.<family>.yml` (`origenal`, `square`, `standard`, `traditional`, `ultrawide`),
each `breakpoint_group: webassets` with a `fallback_image_style`. Example — `standard` maps:

| Breakpoint | Image style |
|------------|-------------|
| `webassets.xl` | `standard_xxlarg` |
| `webassets.lg` | `standard_xlarg` |
| `webassets.md` | `standard_larg` |
| `webassets.sm` | `standard_medium` |
| fallback | `standard_small` |

The other families follow the same shape with their own derivatives. These styles depend on the
`webassets` theme breakpoint group, so a theme must expose that group (see below).

## Eight breakpoints

`webassets.breakpoints.yml` registers group `webassets`:

| Key | Media query |
|-----|-------------|
| `webassets.sm` | `all and (min-width: 500px)` |
| `webassets.md` | `all and (min-width: 700px)` |
| `webassets.lg` | `all and (min-width: 1000px)` |
| `webassets.xl` | `all and (min-width: 1300px)` |
| `webassets.nav-md` | `all and (min-width: 500px)` |
| `webassets.nav` | `all and (min-width: 1200px)` |
| `webassets.grid-md` | `all and (min-width: 700px)` |
| `webassets.grid-max` | `all and (min-width: 1440px)` |

All multipliers are `1x`. Themes can declare their own `breakpoints` group named `webassets` to reuse
these queries in custom responsive image styles.

## Display Builder display on Image

`recipes/default/config/core.entity_view_display.media.image.standard.yml` layers a Display Builder
(`third_party_settings.display_builder`, profile `default`) view display on the Image bundle's
`standard` view mode, rendering `field_media_image` with the `responsive_image` formatter (responsive
image style `standard`) and `image_loading: lazy`. This is the only view mode the default recipe
customises beyond what foundation ships.
