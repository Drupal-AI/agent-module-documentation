# Settings and setting up a media type

There is **no admin settings form or route** (`configure` is null). All module-wide settings live in
the config object `media_avportal.settings`, edited via drush/PHP or synced config.

## `media_avportal.settings`

| Key | Default | Purpose |
|---|---|---|
| `client_api_uri` | `https://gfdwwnbuul.execute-api.eu-west-1.amazonaws.com/avsportal/avsportal` | JSON search API endpoint the client queries. |
| `iframe_base_uri` | `https://audiovisual.ec.europa.eu/corporateplayer/index.html` | Base URL used as the video `<iframe>` `src`. |
| `photos_base_uri` | `https://ec.europa.eu/avservices/repository/photo` | Prefix prepended to photo file paths (no trailing slash; the join is slash-normalised). |
| `cache_max_age` | `3600` | Seconds to cache API responses; `0` disables caching. |

Config schema: `media_avportal.schema.yml` → `media_avportal.settings` (a `config_object`; the three
URIs are `uri`, `cache_max_age` is `integer`). Install defaults are in
`config/install/media_avportal.settings.yml`.

```bash
# View / change a value:
drush config:get media_avportal.settings
drush config:set media_avportal.settings cache_max_age 0 -y   # disable response caching
```

```php
$config = \Drupal::configFactory()->getEditable('media_avportal.settings');
$config->set('client_api_uri', 'https://example.test/avsportal')->save();
```

## Update / post-update hooks that touch settings

- `media_avportal_update_8002` — sets `client_api_uri` to the AWS API-gateway endpoint.
- `media_avportal_post_update_iframe_base_uri` — sets `iframe_base_uri` to the corporate-player URL.
- `media_avportal_post_update_enable_response_cache` — sets `cache_max_age` to 3600.
- `media_avportal_post_update_photos_base_uri` *(new in 2.3.x)* — moves `photos_base_uri` to
  `https://ec.europa.eu/avservices/repository/photo`. If the stored value was the old legacy default it
  is migrated silently; if it had been customised to something else, it is reset to the new value and the
  hook returns a warning asking the admin to re-apply the customisation **without a trailing slash**
  (the API now returns paths with a leading slash, and the legacy repository is being decommissioned).

## Creating an AV Portal media type

1. Add a Media type (`admin/structure/media/add`) and pick the source **Media AV Portal Photo**
   (`media_avportal_photo`) or **Media AV Portal Video** (`media_avportal_video`). Core creates the
   `string` source field automatically.
2. Per-type source config key `thumbnails_directory` (default `public://media_avportal_thumbnails`) —
   where remote thumbnails are downloaded; must be a valid stream URI. Schema:
   `media.source.media_avportal_photo` / `media.source.media_avportal_video`.
3. The source field is forced onto the `avportal_textfield` widget (editors paste a portal URL, only
   the ref is stored) and the media `name` field is removed from the form automatically.
4. On *Manage display*, choose a matching formatter: `avportal_video` for video, `avportal_photo` or
   `avportal_photo_responsive` for photo (see [../plugins/field-formatters.md](../plugins/field-formatters.md)).

The test fixtures under `tests/modules/media_avportal_test/config/install/` (media types
`av_portal_photo` / `av_portal_video` with their source fields) are a working example of this config.
