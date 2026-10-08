<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content Lytics - agent index

Lytics profile fields as Smart Content conditions. Version **1.0.1** (1.0.x), core `^10`. Depends on `smart_content`, `lytics`.

- `LyticsConditionDeriver::getAvailableSchemaAttributes()` reads `lytics.settings:apitoken` and GETs `https://api.lytics.io/v2/schema/user/field` and `.../api/account/setting/api_whitelist_fields` via `\Drupal::httpClient()` (default TLS verify) with `Authorization: {token}` header; registers a condition per surfaced field.
- Provides `LyticsCondition` + `Lytics` condition group plugins.
- No routes/permissions of its own.

Security: server-side Lytics API calls use default (verified) TLS; token comes from lytics config. Client supplies its own attribute values for evaluation. No verified finding.
