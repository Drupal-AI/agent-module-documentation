<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instagram Feed By Username — agent index

Field type showing an **Instagram user's recent posts** fetched by username from a third-party API. Version **1.1.2**. Core `^8.8 || ^9 || ^10`.

- `instagram_field` field type; `InstagramFeedByUsernameService::posts()` → `https://api.woxo.tech/instagram?source={username}` (default TLS, no key, fixed host).
- Template: `templates/field--instagram-feed-by-username.html.twig`.
