# Configuration

Media Entity Twitter has **no module settings page**. You configure it by
creating a core Media type that uses the Twitter source, then choosing how the
tweet is displayed.

## Create the Twitter media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give the type a name (for example "Tweet").
3. Set **Media source** to **Twitter**.
4. **Save.** The module automatically creates a source field labeled **"Tweet
   URL"** (it can be a plain text, long text, or link field).
5. Back on the type's source form, set **Field with source information** to that
   "Tweet URL" field so the module knows where to read the tweet from.

That is all you need for basic embedding — no API keys required. Editors can now
paste a tweet URL and it will be recognized.

## Source settings, field by field

On the media type's source form you'll find these settings:

- **Field with source information** (`source_field`) — the field that holds the
  tweet URL or embed code. Point this at the "Tweet URL" field created above.
- **Whether to use Twitter API** (`use_twitter_api`, default off) — turn this on
  to fetch richer metadata (tweet text, counts, author details, images) directly
  from Twitter. It requires the credentials below and the
  `j7mbo/twitter-api-php` library. The credential and thumbnail fields stay
  hidden until you switch this on.
- **Consumer key** (`consumer_key`) — your Twitter app's consumer key.
- **Consumer secret** (`consumer_secret`) — your Twitter app's consumer secret.
- **OAuth access token** (`oauth_access_token`) — the OAuth access token.
- **OAuth access token secret** (`oauth_access_token_secret`) — the OAuth access
  token secret.
- **Generate thumbnails** (`generate_thumbnails`, default off) — when on (and API
  mode is enabled), the module auto‑generates SVG thumbnails, or copies a tweet's
  attached photo locally. Note the on‑screen warning about Twitter's fair‑use
  policy when storing images.

Fetched tweet responses are cached for 90 days (in the `tweets` cache bin) so the
API isn't hit on every page load.

## Mapping extra metadata to fields (API mode)

There is no point‑and‑click mapping UI beyond the source form. To store the
extra metadata that API mode exposes (`content`, `retweet_count`, `user_name`,
`image`/`image_local`, `profile_image_url_https`, `created_time`, and so on),
add fields to the media type and map them in the type's `field_map`
configuration, for example:

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

## Thumbnail storage directory

The one module‑level config value is where fetched images and generated
thumbnails are written. It defaults to `public://twitter-thumbnails` and can be
changed from Drush:

```bash
drush config:set media_entity_twitter.settings local_images 'public://tweets'
```

## Display: the Twitter embed formatter

To render tweets as interactive embeds, set the source field's display formatter
to **Twitter embed** under **Manage display**. It outputs a
`<blockquote class="twitter-tweet">` and loads Twitter's `widgets.js`.

The formatter has one setting:

- **Conversation** (`conversation`, default off) — when off, the embed adds
  `data-conversation=none` so replies and the parent tweet are hidden; when on,
  it shows the previous tweet in a reply thread.
