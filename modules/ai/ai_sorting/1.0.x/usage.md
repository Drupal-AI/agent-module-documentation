<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Sorting is a Views sort plugin that continuously A/B tests a view's items and reorders them by learned engagement, using the RL module's Thompson Sampling algorithm.

---

AI Sorting provides one Views sort criterion ("AI Sorting", plugin id `ai_sorting`) that you add to any Views display over an entity type. Instead of a fixed order, it derives a per view+display experiment id, asks the contributed RL (Reinforcement Learning) module for a score per item ("arm"), and rewrites the query's ORDER BY with a CASE expression so higher-scoring items appear first — while new items still get exploration exposure (cold-start handling). A bundled JavaScript library tracks two signals back to the RL endpoint with `sendBeacon`: impressions ("turns", when an item's link scrolls into view) and rewards (when a link is clicked). It also registers each experiment with RL, decorates RL report rows with entity labels, adds a "View experiment" contextual link on the view, and can auto-set the view's cache lifetime to match the sort's configured refresh rate. It requires core Views and the RL module; all learning data is stored locally by RL and the module makes no external-service calls. On drupal.org the project has been superseded by `rl_sorting` and is marked unsupported/obsolete.

---

- Order a blog/article listing so the most-clicked posts rise to the top automatically.
- Continuously A/B test dozens or hundreds of content pieces with no manual test setup.
- Give newly published content fair exposure while promoting proven winners (cold-start handling).
- Surface best-converting product or landing pages first in a Views-driven grid.
- Prioritize breaking or trending news items in a feed based on live engagement.
- Rank resource-center downloads by which get opened most.
- Apply engagement-based ordering to users, taxonomy terms, media, or custom entities (any Views base).
- Add "AI Sorting" as the sort criterion on any Views display and save — learning starts immediately.
- Favor recent interactions with the "Favor recent content" option and a time window (month to year).
- Restrict scoring to the last 1/3/6/12 months for seasonal or campaign content.
- Tune how often the order refreshes via the cache-duration option (no-cache up to 5 minutes).
- Let the module auto-configure the view's time-based cache to match the refresh rate.
- Track impressions when items scroll into view (IntersectionObserver) without extra configuration.
- Record a click reward once per experiment per page load (dedup via sessionStorage).
- Jump from a view to its RL experiment report via the "View experiment" contextual link.
- See human-readable entity labels (not raw IDs) in the RL experiment reports.
- Keep all engagement data on-site (no external service, no per-user identification).
- Combine with any Views filters/contextual filters — AI Sorting only reorders the already-filtered result set.
- Replace manual "sticky"/weight ordering with self-optimizing ordering.
- Migrate to the successor `rl_sorting` project for continued support.
