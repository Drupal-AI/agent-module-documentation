<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Boolean Field Boost (search_api_boolean_field_boost) — agent index

**Search API processor that boosts an item's score when a chosen boolean field is TRUE.**

- **Version:** 1.0.x
- **Core:** ^10
- **Depends:** search_api
- **Package:** Custom

**Surface:** one `@SearchApiProcessor` `boolean_field_boost` (`preprocess_index` stage) in `src/Plugin/search_api/processor/BooleanFieldBoost.php`. Config via the Search API index processor UI. No routes/permissions/services.

**Security:** index-time relevance tuning only; governed by Search API's admin permissions. No request surface. Low risk.
