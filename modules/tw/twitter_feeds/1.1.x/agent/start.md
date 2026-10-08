<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twitter feeds - agent index

Two blocks: a **Twitter timeline feed** and a **Twitter follow button**. Version **1.1.0**, core `^8 || ^9 || ^10`. Depends on `block`.

- Block plugins `twitter_feeds` (`TwitterFeedsBlock`) and `twitter_follow_button` (`TwitterFollowButtonBlock`); config is per block instance.
- Renders via theme hooks + attached JS library; embedding is client-side (Twitter widget). No server-side API call, no stored keys.
- Note: `build()` references an undefined `$rgb_widget_id` (widget id not passed to the template) - functional bug, not security.