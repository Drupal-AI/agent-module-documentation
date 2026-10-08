<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# media_entity_twitter — agent start

A core Media **source plugin** (id `twitter`) for Twitter/X posts. Editors reference a tweet
by URL; the module extracts `id` + `user` and can embed the live tweet. Depends on `media`.
No admin settings route — the source is configured on the **media type** form
(`/admin/structure/media/manage/{type}`). Optional Twitter API mode adds richer metadata.

- Create/configure the Twitter media type, source settings, thumbnails, config object → [configure/media-type.md](configure/media-type.md)
- The `twitter` media source + `twitter_embed` formatter: ids, fields, metadata attributes → [plugins/media-source.md](plugins/media-source.md)
- Fetch tweets in code, the `tweet_fetcher` service, decorate it → [api/tweet-fetcher.md](api/tweet-fetcher.md)
