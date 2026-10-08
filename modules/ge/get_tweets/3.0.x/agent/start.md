<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Get Tweets — agent index

Imports **tweets from X/Twitter into Drupal nodes** (archive/display as content). Depends on core
`image`, `link`, `node`, `path`. Config at `get_tweets.config_form`; provides permissions. Version
**3.0.0-alpha2**. Core `^9.3||^10||^11`.

Store the X/Twitter API token as a secret; mind API terms/rate limits. Imported tweets = external input
on display.
