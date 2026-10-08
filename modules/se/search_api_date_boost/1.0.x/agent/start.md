<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Date Boost (search_api_date_boost) — agent index

**A Search API processor that boosts indexed items by date-field recency using exponential decay, with future-dated items always at maximum boost.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Depends on:** `search_api`, `search_api_db`
- **Processor:** `date_field_boost` (`ProcessorPluginBase`, stage `preprocess_index`)
- **Per-field settings:** `boost_factor` (0.00–21.00 dropdown), `decay_period` (days, default 30)
- **Formula:** future → full `boost_factor`; past → `boost_factor * exp(-age_days / decay_period)` (capped at the factor), added to the item's existing boost
- **Routes / permissions:** none of its own — configured on the Search API index, gated by Search API's admin permissions
- **Security:** no routes, endpoints, or mutating surface; pure index-time ranking logic driven by index config.

See [configure/processor.md](configure/processor.md) for enabling and tuning the processor.