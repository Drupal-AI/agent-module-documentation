<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rate provides flexible, AJAX-based voting widgets (fivestar, thumbs up/down, yes/no, emotion, number up/down, custom) that you attach to node and comment bundles, storing votes through the VotingAPI module.

---

Each widget is a **`rate_widget` config entity** (config prefix `rate_widget` → `rate.rate_widget.<id>`) built and managed at `/admin/structure/rate_widgets`. A widget picks a `template` (custom, fivestar, numberupdown, emotion, thumbsup, thumbsupdown, yesno), a VotingAPI `value_type` (`points` summed, `percent` averaged, or option counts), a set of `options` (each a value/label/class), the `entity_types`/`comment_types` bundles it appears on, plus `voting` (deadline + anonymous/registered rollover windows), `display` (label/description position, read-only) and `results` (summary content/position) settings. Votes are stored in VotingAPI's `votingapi_vote` table tagged with the widget machine name, and results are computed by VotingAPI VoteResultFunction plugins the module adds (`RateCount`, `RateAverage`, `RateSum`, `CountUp`, `RateSumUp`). A per-node **"Rate Voting results"** tab lives at `/node/{node}/node-rating` (permission `view rate results page`). Global bot-detection settings (user-agent patterns, per-minute/per-hour IP thresholds, optional BotScout API key, log toggle) live in the `rate.settings` config object at `/admin/config/search/votingapi/rate`. Permissions include `administer rate`, `view rate results page`, and a **dynamically generated per-bundle** `cast rate vote on <entity_type> of <bundle>` permission for every widget-attached bundle. Rate integrates with Views (a "Rate widget" field), supports an optional per-entity voting **deadline** date field, and invites customization through four hooks (`hook_rate_vote_data_alter`, `hook_rate_widget_options_alter`, `hook_rate_can_vote`, `hook_rate_templates`) and overridable Twig templates.

---

- Add a 1–5 fivestar rating widget to Article nodes.
- Put a thumbs up / down widget on blog posts and sum the score with the points value type.
- Add a simple yes/no or like button to any content type.
- Collect emotion reactions (funny / boring / angry) using the options value type.
- Attach a number up/down counter widget to comments.
- Show the same widget on several bundles, or several widgets on one bundle.
- Restrict who may vote per bundle via the generated `cast rate vote on node of article` permission.
- Expose a node's detailed voting results on the "Rate Voting results" tab.
- Close voting automatically after a per-entity deadline date.
- Set a vote rollover window so a user can only re-vote after a period (or never / immediately).
- Detect and block voting bots by user-agent pattern (`rate_bot_agent` table).
- Throttle abusive IPs with per-minute and per-hour vote thresholds.
- Look up voter IPs against BotScout.com with an API key.
- Display a widget inside a View using the "Rate widget" Views field, choosing the entity-id column.
- Show a widget read-only (results without the ability to vote) in a listing.
- Reposition or hide a widget's label, description, and results summary.
- Customize the results summary by overriding `rate-widgets-summary.html.twig` in a theme.
- Add a brand-new widget template from a custom module with `hook_rate_templates()`.
- Alter a widget's options (values/labels/classes) at render time with `hook_rate_widget_options_alter()`.
- Change vote data before it is saved (e.g. custom columns) with `hook_rate_vote_data_alter()`.
- Add custom voting eligibility rules with `hook_rate_can_vote()`.
- Let users undo their vote (AJAX un-vote) where the widget allows it.
- Average percentage ratings across all voters for a fivestar-style score.
- Migrate legacy Rate 7.x votes via the provided migration source/process plugins.
- Turn off Rate's watchdog logging with the `disable_log` setting.
- Build a "most popular" listing by adding a VotingAPI results relationship in Views and sorting on it.
