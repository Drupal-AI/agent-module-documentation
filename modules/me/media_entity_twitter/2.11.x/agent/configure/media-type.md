<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Twitter media type

There is **no module settings page**. You configure everything on a core Media type whose
source is `twitter`.

## Create the media type (UI)

1. Enable: `drush en media_entity_twitter -y` (depends on core `media`). This copies the
   default `twitter.png` icon into the media icon directory on install.
2. Admin → Structure → Media types → Add media type
   (`/admin/structure/media/add`).
3. Set **Media source** = **Twitter**.
4. Save. The module auto-creates a source field labeled **"Tweet URL"** (allowed field
   types: `string`, `string_long`, `link`).
5. On the type's source form, set **"Field with source information"** to that field.

## Source configuration keys (`media.source.twitter` schema)

Stored in the media type's `source_configuration`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `source_field` | string | `''` | Field holding the tweet URL/embed code. |
| `use_twitter_api` | boolean | `FALSE` | Fetch extra metadata via Twitter API (needs credentials + `j7mbo/twitter-api-php`). |
| `consumer_key` | string | `''` | Twitter app consumer key (only when API enabled). |
| `consumer_secret` | string | `''` | Twitter app consumer secret. |
| `oauth_access_token` | string | `''` | OAuth access token. |
| `oauth_access_token_secret` | string | `''` | OAuth access token secret. |
| `generate_thumbnails` | boolean | `FALSE` | Auto-generate SVG thumbnails (only shown when API enabled). Warns about Twitter fair-use policy. |

The credential/thumbnail fields are hidden in the UI unless "use Twitter api" = Yes.

## Module config object

`media_entity_twitter.settings` (config/install) has one key:

- `local_images`: `'public://twitter-thumbnails'` — directory where fetched tweet images and
  generated SVG thumbnails are written.

Change it with: `drush config:set media_entity_twitter.settings local_images 'public://tweets'`

## Storing extra fields (API mode)

There is no GUI mapping UI beyond the source form; map API metadata attributes to fields via
config (`field_map`) on the media type, e.g.:

```yaml
type: twitter
source_configuration:
  source_field: field_tweet_source
  use_twitter_api: '1'
  consumer_key: YOUR_CONSUMER_KEY
  consumer_secret: YOUR_CONSUMER_SECRET
  oauth_access_token: YOUR_TOKEN
  oauth_access_token_secret: YOUR_TOKEN_SECRET
field_map:
  id: field_tweet_id
  content: field_tweet_content
  retweet_count: field_tweet_retweets
```

## Display: the `twitter_embed` formatter

Set the source field's display formatter to **Twitter embed** (`twitter_embed`). It renders
`<blockquote class="twitter-tweet">` and attaches `media_entity_twitter/integration`
(loads Twitter's remote `//platform.twitter.com/widgets.js`).

- Formatter setting `conversation` (boolean, default `FALSE`): when off, adds
  `data-conversation=none` so replies/parent tweets are hidden; when on, shows the previous
  tweet in a reply thread. Schema: `field.formatter.settings.twitter_embed`.
