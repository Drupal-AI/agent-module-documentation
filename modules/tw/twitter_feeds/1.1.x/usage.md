<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twitter feeds adds a Twitter timeline block and a Twitter follow-button block, both configured per block instance.

---

Twitter feeds provides two block plugins. `TwitterFeedsBlock` renders a Twitter timeline for a configured username (with optional widget id, tweet limit, board width, layout theme and placeholder text) through the `twitter_feeds` theme hook and an attached JS library. `TwitterFollowButtonBlock` renders a follow button for a username with an optional follower count. All configuration lives in the block instance settings; the module attaches its library and delegates the actual embedding to Twitter's client-side widget script - there is no server-side Twitter API call or credential in the module.

---

- Embed a Twitter timeline in a block.
- Show a Twitter follow button in a block.
- Set the Twitter username per block.
- Provide a widget id for the timeline.
- Limit the number of tweets shown.
- Set the tweets board width.
- Choose a light/dark/transparent layout theme.
- Show placeholder text while the feed loads.
- Optionally display the follower count on the button.
- Place the blocks in any theme region.
- Configure entirely via block settings (no global form).
- Rely on Twitter's client-side widget script.
- Avoid storing any Twitter API keys.
- Reuse the same library for both blocks.
- Add social presence to any page via layout/block UI.
