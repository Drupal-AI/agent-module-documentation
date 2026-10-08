# The Brightcove Video media source

Plugin `BrightcoveVideo` (`src/Plugin/media/Source/BrightcoveVideo.php`), a core `@MediaSource`
(`id = "brightcove_video"`, `allowed_field_types = {"entity_reference"}`,
implements `MediaSourceFieldConstraintsInterface`).

## Setup

1. Create a Media type (`/admin/structure/media/add`) and choose **Brightcove Video** as the media
   source.
2. The source field is an `entity_reference` targeting the `brightcove_video` entity type. Let the
   media type create it, or map an existing reference field.
3. Optionally map the exposed metadata attributes to fields on the media type.

No module-specific config, permissions, or Drush — everything is standard core Media UI.

## Metadata attributes (`getMetadataAttributes()`)

`name`, `api_client`, `player`, `video_id`, `duration`, `description`, `long_description`, `poster`,
`thumbnail`, `complete`, `reference_id`, `state`, `tags`, `custom_fields`, `geo`, `geo.countries`,
`geo.exclude_countries`, `geo.restricted`, `schedule`, `starts_at`, `ends_at`,
`picture_thumbnail`, `picture_poster`, `video_source`, `economics`, `partner_channel`.

`getMetadata($media, 'thumbnail_uri')` returns the referenced Brightcove video's thumbnail file URI,
falling back to `media.settings:icon_base_uri`/`no-thumbnail.png` when absent.

## Validation

`BrightcoveVideoConstraint` + `BrightcoveVideoConstraintValidator`
(`src/Plugin/Validation/Constraint/`) are applied to the source field so a media entity must
reference a valid Brightcove video.
