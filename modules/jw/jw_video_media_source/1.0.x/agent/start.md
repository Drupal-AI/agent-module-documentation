<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JW player media source - agent index

Provides a **JW Player media source** and Media Library integration (version **1.0.1**, core `^8||^9||^10`; depends on `media`, `media_library`).

- `MediaFetcher` (src/MediaFetcher.php) fetches from the hardcoded host `https://cdn.jwplayer.com` using the injected Guzzle client (default TLS verification); thumbnail URLs come from JW's own API response.
- Adding media requires media-create privileges (editorial). No arbitrary-URL fetch from anonymous input.
- Category: Media / Media sources.
