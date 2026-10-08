<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `twitter` media source & `twitter_embed` formatter

The module does **not** define its own plugin type; it provides two plugins for core APIs.

## MediaSource plugin: `twitter`

`Drupal\media_entity_twitter\Plugin\media\Source\Twitter` — annotation:

```php
@MediaSource(
  id = "twitter",
  label = "Twitter",
  allowed_field_types = {"string", "string_long", "link"},
  default_thumbnail_filename = "twitter.png",
  forms = { "media_library_add" = "...\Form\TwitterMediaLibraryAddForm" }
)
```

- Implements `MediaSourceFieldConstraintsInterface` and `OEmbedInterface`.
- `getProviders()` returns `['Twitter', 'X']`.
- `createSourceField()` labels the auto-created field **"Tweet URL"**.
- `getSourceFieldConstraints()` returns `['oembed_resource' => []]`.

### URL matching

Source-field values are matched with one regex (public static `$validationRegexp`):

```
@((http|https):){0,1}//(www\.){0,1}(twitter|x)\.com/(?<user>[a-z0-9_-]+)/(status(es){0,1})/(?<id>[\d]+)@i
```

Named groups `user` and `id` are extracted. Both `twitter.com` and `x.com`, and both
`/status/` and `/statuses/`, are accepted.

### Metadata attributes (`getMetadataAttributes()`)

Always available (from the URL, no API):

- `id` — Tweet ID
- `user` — Twitter user (handle from URL)

Plus core-derived: `thumbnail_uri` (local generated image, else default icon),
`default_name` (`"{user} - {id}"`).

Only when `use_twitter_api` is enabled (requires OAuth credentials + `j7mbo/twitter-api-php`):

- `image` — URL of the tweet's attached media
- `image_local` — copies that image locally, returns the URI
- `image_local_uri` — the computed local URI for the image
- `content` — the tweet full text (`full_text`)
- `retweet_count`
- `profile_image_url_https`
- `created_time` — stored as `Y-m-d\TH:i:s`
- `user_name` — author display name

### Thumbnails

`thumbnail_uri` returns a local image if one exists; otherwise the default `twitter.png`
icon — unless `generate_thumbnails` is on, in which case it renders an SVG via the
`media_entity_twitter_tweet_thumbnail` theme hook and saves it under the `local_images`
directory.

## Field formatter: `twitter_embed`

`Drupal\media_entity_twitter\Plugin\Field\FieldFormatter\TwitterEmbedFormatter`
(`field_types = {"link", "string", "string_long", "text_long"}`). Renders each matched tweet
via the `media_entity_twitter_tweet` theme hook as
`https://twitter.com/{user}/statuses/{id}` inside a `twitter-tweet` blockquote and attaches
the `media_entity_twitter/integration` library. Setting `conversation` (default off) toggles
`data-conversation=none`.

## Theme hooks (override to restyle)

- `media_entity_twitter_tweet` — vars `path`, `attributes` (the embed blockquote).
- `media_entity_twitter_tweet_thumbnail` — vars `content`, `author`, `avatar` (SVG thumbnail;
  a preprocess base64-embeds the avatar image).
