# Widget and field formatters

All operate on the media source's `string` field (`src/Plugin/Field/FieldWidget/` and
`FieldFormatter/`). Each `isApplicable()` restricts the plugin to media bundles whose source is an
AV Portal source (video formatters ↔ `MediaAvPortalVideoSource`, photo formatters ↔
`MediaAvPortalPhotoSource`).

## Widget — `avportal_textfield` (`AvPortalWidget`)

Extends core `StringTextfieldWidget`. Label *"AV Portal URL"*.

- Description lists the source plugin's `getSupportedUrlFormats()` so the editor knows what to paste.
- `#element_validate` → `AvPortalWidget::validate()` rejects a value that matches none of the source's
  `getSupportedUrlPatterns()` with *"Invalid URL format specified."*.
- `massageFormValues()` calls `transformUrlToReference()` so the field **stores only the ref**, not the
  full URL.
- On edit, `transformReferenceToUrl()` pre-fills the textfield with the full URL again.
- Config schema `field.widget.settings.avportal_textfield` (inherits `string_textfield`).

## Formatters

| Formatter id | Class | Setting(s) | Output |
|---|---|---|---|
| `avportal_video` | `AvPortalVideoFormatter` | `max_width` (640), `max_height` (390) | `<iframe>` to the corporate player |
| `avportal_photo` | `AvPortalPhotoFormatter` | `image_style` (select, optional) | `image` / `image_style` themed `<img>` |
| `avportal_photo_responsive` | `AvPortalPhotoResponsiveFormatter` | `responsive_image_style` (required select) | `responsive_image` themed `<img>` |

Every formatter resolves the ref via `media_avportal.client` (`getResource($ref)`); a missing resource
is logged to the `media_avportal` channel (*"Could not retrieve the remote reference (@ref)."*) and
renders nothing. As of 2.3.x the formatters inject the `logger.channel.media_avportal` service directly
(via the `DeprecatedLoggerChannelTrait`); passing a logger channel *factory* still works but emits an
`E_USER_DEPRECATED` notice (to be removed in 3.0.0).

### `avportal_video` — video iframe

Builds an `#type => html_tag` `iframe` whose `src` is
`Url::fromUri(iframe_base_uri, ['query' => ['ref' => …, 'lg' => <LANG>, 'sublg' => 'none', 'autoplay' => 'true']])`.
Langcode is mapped through `language.mappings` and upper-cased. Defaults 640×390 (`DEFAULT_WIDTH` /
`DEFAULT_HEIGHT`); `max_width`/`max_height` override. The resource title becomes the iframe `title`
attribute (only when the resource has a title, to preserve title inheritance). Attaches library
`media_avportal/avportal_video.formatter` (see `css/avportal_video.formatter.css`). Schema
`field.formatter.settings.avportal_video`.

### `avportal_photo` — image with optional image style

Renders `#theme => image` (or `image_style` when an `image_style` is selected) with
`#uri => 'avportal://' . $ref . '.jpg'` and `alt` from the source's `thumbnail_alt_value` metadata.
The `avportal://` URI is resolved by the photo stream wrapper (see [../api/client.md](../api/client.md)),
which is what lets core image styles process a remote portal photo. `calculateDependencies()` /
`onDependencyRemoval()` track the selected image style. The image-style option list is now built by a
local `getImageStyleOptions()` (the core `image_style_options()` helper is deprecated in Drupal 11.4).
Schema `field.formatter.settings.avportal_photo` (key `image_style`).

### `avportal_photo_responsive` — responsive image

Same `avportal://REF.jpg` URI, rendered as `#theme => responsive_image` with a required
`responsive_image_style`. `isApplicable()` additionally requires the `responsive_image` module and at
least one responsive image style to exist. Schema `field.formatter.settings.avportal_photo_responsive`
(key `responsive_image_style`).

> Update hook `media_avportal_update_8001` migrated view displays using the old `avportal` formatter id
> to `avportal_video`.
