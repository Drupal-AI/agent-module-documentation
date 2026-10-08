<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fetching tweets in code

## Service: `media_entity_twitter.tweet_fetcher`

Class `Drupal\media_entity_twitter\TweetFetcher` implements `TweetFetcherInterface`.
Constructed with the `cache.tweets` cache bin (a dedicated `tweets` bin defined in
`media_entity_twitter.services.yml`).

Interface:

```php
$fetcher = \Drupal::service('media_entity_twitter.tweet_fetcher');
$fetcher->setCredentials($consumer_key, $consumer_secret, $oauth_access_token, $oauth_access_token_secret);
$tweet = $fetcher->fetchTweet($id); // decoded array of tweet data
$creds = $fetcher->getCredentials();
```

Behavior of `fetchTweet($id)`:

- Returns the cached response if present (cached for 90 days in the `tweets` bin).
- Throws `\UnexpectedValueException` if `setCredentials()` was never called (no API
  exchange initialized).
- Calls `https://api.twitter.com/1.1/statuses/show.json?id={id}&tweet_mode=extended` via
  the `j7mbo/twitter-api-php` `\TwitterAPIExchange` OAuth client.
- Throws `\Exception` on empty response, or
  `Drupal\media_entity_twitter\Exception\TwitterApiException` when the API returns `errors`.

> The `twitter` media source calls this internally (`fetchTweet()`), reading credentials
> from the media type's `source_configuration`. You rarely call it directly; do so only for
> custom tweet processing.

## Decorating / replacing the fetcher

Register a service decorator or override `media_entity_twitter.tweet_fetcher` with your own
`TweetFetcherInterface` implementation (e.g. to swap in the v2 API or a stub for tests). Type
against `Drupal\media_entity_twitter\TweetFetcherInterface`, not the concrete class.

## Note on the Twitter/X API

This module targets the legacy `statuses/show.json` (v1.1) endpoint. Without valid
credentials and API access the extra metadata attributes return `NULL`; the module still
works for plain embedding (`id` + `user`) with no API at all.
