<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Get Tweets imports tweets from X/Twitter into Drupal nodes, storing them as content.

---

Get Tweets imports tweets (posts) from X/Twitter into Drupal, storing them as nodes — so a feed of
tweets can be archived or displayed as native content. It depends on core Image, Link, Node and Path, is
configured at `get_tweets.config_form`, and provides its own permissions.

Use it to pull an account's or search's tweets into Drupal for display/archiving. It connects to the
X/Twitter API, so store the API credentials (bearer token / keys) as secrets and be mindful of API
terms and rate limits. Imported tweets become node content derived from external data — treat their
text/media as external input on display. It is an integration feature; configure the source and
credentials.

---

- Import tweets into Drupal nodes.
- Archive X/Twitter posts as content.
- Display tweets natively.
- Depend on Image, Link, Node, Path.
- Configure at get_tweets.config_form.
- Provide its own permissions.
- Store the Twitter API token as a secret.
- Mind API terms and rate limits.
- Pull tweets by account/search.
- Treat imported tweets as external input.
- Display tweet media.
- Archive a tweet feed.
- Connect to the X/Twitter API.
- Import posts on schedule.
- Handle API credentials securely.
- Store tweets as nodes.
- Show a Twitter feed.
- Import social content.
- Configure the tweet source.
- Display imported posts.
