<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Date Boost adds a relevance boost to indexed items based on how recent a date field is, so newer (and upcoming) content ranks higher.

---

The processor (`date_field_boost`, plugin stage `preprocess_index`) is aimed at the Search API Database backend. For each configured date field it takes the item's value and computes an age in days relative to now. Past events get an exponential-decay boost — `boost_factor * exp(-age_days / decay_period)`, capped at the boost factor — so older content gradually loses its lift. Future events (negative age) always receive the full `boost_factor`, keeping upcoming events prominent. The computed boost is *added* to the item's existing boost (not multiplied), and only when both `boost_factor` and `decay_period` are positive.

Configuration lives on the Search API index's processor settings: enable the processor, then per date field choose a `boost_factor` (a Search-API-style dropdown from 0.00 up to 21.00) and a `decay_period` in days (default 30, controlling how quickly past-event boost decays). Settings are stored in the index config; there are no routes or permissions of the module's own — everything is administered through Search API's index admin UI, which is permission-gated by Search API. Re-index after changing settings for the boosts to take effect.

---
- Rank recent content higher in a Search API Database index
- Keep upcoming events at maximum relevance until they occur
- Apply exponential decay so older items gradually lose their boost
- Tune how fast the boost fades with a per-field decay period in days
- Set a distinct boost factor per date field on the index
- Favor freshly published articles in a news/blog search
- Surface soonest-first events in an events search
- Combine recency boost with Search API's own field boosts
- Add a gentle recency signal without a custom sort
- Use a long decay period for slowly-aging evergreen-ish content
- Use a short decay period to strongly prefer just-published items
- Keep future-dated content pinned near the top of results
- Leave a field's boost effectively off by setting its factor to 0.00
- Apply different recency weighting to a start-date vs an end-date field
- Boost by the most recent value when a date field is multivalued (uses the max)
- Improve perceived freshness of a site search without changing the query
- Re-index after adjusting boost/decay so new weights apply
- Layer recency ranking on top of full-text relevance scoring