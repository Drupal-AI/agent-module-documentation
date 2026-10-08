<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Twitter provides a `twitter` media source plugin for Drupal core Media, letting editors reference Twitter/X posts by URL as media entities and render them as embedded tweets.

---

The module registers a `MediaSource` plugin (id `twitter`) that plugs into core Media. You create a Media type whose source is "Twitter", give it a source field (plain text, long text, or link), and point the source at that field via "Field with source information". A regex extracts the tweet `id` and `user` from twitter.com/x.com status URLs, exposing them as media metadata attributes; the source field label defaults to "Tweet URL" and validation uses the `oembed_resource` constraint. Without any Twitter API credentials you get the `id` and `user` fields plus a default icon thumbnail — enough to embed tweets. If you enable the Twitter API option and supply OAuth credentials (consumer key/secret and access token/secret, consumed via the `j7mbo/twitter-api-php` library and the `media_entity_twitter.tweet_fetcher` service, cached in the `tweets` cache bin), extra metadata becomes available: `image`, `image_local`, `content`, `retweet_count`, `profile_image_url_https`, `created_time`, `user_name`. A `twitter_embed` field formatter renders the tweet with Twitter's `widgets.js`, optionally showing the parent tweet in a conversation. Thumbnails can be auto-generated as SVGs (or copied local images) when enabled. There is no admin settings page — configuration lives on the media type's source form; only `media_entity_twitter.settings` (the `local_images` thumbnail directory) is a module config object.

---

- Create a Media type backed by Twitter/X posts using core Media.
- Let editors add a tweet just by pasting its URL into a source field.
- Embed live, interactive tweets on nodes via the `twitter_embed` formatter.
- Reference tweets from any entity through a Media reference field.
- Extract a tweet's numeric `id` from twitter.com or x.com status URLs.
- Extract the tweet author's `user` handle from the URL.
- Match both `twitter.com/.../status/ID` and `x.com/.../statuses/ID` URL shapes.
- Use the media source without any API keys for simple tweet embedding.
- Enable Twitter's API to pull richer tweet metadata into fields.
- Map the tweet `content` (full text) to a field on the media type.
- Map `retweet_count` to a field to display engagement numbers.
- Map the tweet author's display `user_name` to a field.
- Store the tweet's `created_time` as a datetime value.
- Pull the tweet's attached `image` URL and copy it locally (`image_local`).
- Show the author's profile image via `profile_image_url_https`.
- Auto-generate SVG thumbnails for tweets that have no attached media.
- Copy a tweet's attached photo into the local filesystem as its thumbnail.
- Provide a default Twitter icon thumbnail for tweets in media listings.
- Suppress the reply/conversation context in an embed via `data-conversation=none`.
- Optionally show the previous tweet in a reply thread (conversation setting).
- Cache fetched tweet API responses for 90 days in the `tweets` cache bin.
- Add tweets through the Media Library via the Twitter add form.
- Configure the thumbnail storage directory (`local_images`, default `public://twitter-thumbnails`).
- Give the source field a sensible default label ("Tweet URL") automatically.
- Use tweets as first-class, reusable media across a content model.
- Decorate or replace the tweet-fetching logic via the `media_entity_twitter.tweet_fetcher` service.
- Theme the embedded tweet markup by overriding the `media_entity_twitter_tweet` template.
- Customize the generated thumbnail via the `media_entity_twitter_tweet_thumbnail` template.
