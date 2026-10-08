<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — comment_moderation_ai.settings

Single config object `comment_moderation_ai.settings` (schema
`config/schema/comment_moderation_ai.schema.yml`, defaults `config/install/comment_moderation_ai.settings.yml`).
Edited across four forms, all gated by `administer comment moderation ai`.

## Install / enable

`drush en comment_moderation_ai` (pulls in core `comment`/`user`/`system`/`field` + `key`).
`hook_install` grants `administer comment moderation ai` + `view flagged comments` +
`moderate flagged comments` to the `administrator` role, and the two view/moderate perms to a
`content_moderator` role if it exists. It also shows a "configure your API settings" message.
`hook_uninstall` deletes the config object and drops the `openai_flagged_comments` table.
`hook_requirements` (runtime) reports enabled/disabled and, if a key is set, live-tests the API
connection (calls `OpenAIClient::testConnection()`).

**Nothing moderates until `enabled` is TRUE** (default FALSE) and a key is configured.

## General settings form (`CommentModerationAISettingsForm`, route `.settings`)

| key | type / default | notes |
|-----|----------------|-------|
| `api_key_id` | string, `''` | Key entity id (`#type: key_select`, filter `type: authentication`, required). Key module is a hard dep so this path is always used. |
| `api_key` | string, `''` | Legacy plaintext key; only written if Key module is absent (unreachable given the hard dep). Cleared when `api_key_id` is saved. |
| `api_endpoint` | string, `https://api.openai.com/v1/moderations` | `#type: url`, required. |
| `model` | string, `omni-moderation-latest` | or `omni-moderation-2024-09-26`. |
| `enabled` | bool, **false** | master on/off. |
| `auto_flag` | bool, true | flag violating comments (stored config; behaviour is effectively always-on when flagged). |
| `auto_unpublish` | bool, false | unpublish medium-risk flagged comments (high-risk always unpublished). |
| `moderation_threshold` | float, `0.8` | 0.0–1.0; a category counts as violated when its score ≥ threshold. |
| `categories.*` | bool (11 keys, all true) | which OpenAI categories are checked (see below). |
| `log_requests` | bool, true | log a line per completed API request. |

OpenAI categories (keys): `hate`, `hate_threatening`, `harassment`, `harassment_threatening`,
`self_harm`, `self_harm_intent`, `self_harm_instructions`, `sexual`, `sexual_minors`, `violence`,
`violence_graphic`. Only enabled categories with score ≥ `moderation_threshold` flag a comment.

> Note: this form's "Additional Configuration" links use stale route names
> (`openai_comment_moderation.*`) and throw `RouteNotFoundException`, fataling the page — see
> [../admin/routes-permissions.md](../admin/routes-permissions.md).

## Custom policies (`CustomPoliciesSettingsForm`, route `.policies`) — `custom_policies.*`

All six groups default **disabled**. Evaluated by `CommentModerator::checkCustomPolicies()` AFTER
the OpenAI check; any violation forces `flagged = TRUE`.

- `keyword_filtering`: `enabled`, `blocked_words` (one per line), `case_sensitive`. Substring match.
- `length_restrictions`: `enabled`, `min_length` (10), `max_length` (1000). Uses `strlen` on the
  stripped text.
- `rate_limiting`: `enabled`, `max_comments_per_hour` (10), `new_user_restriction` (accounts <7 days).
  **Authenticated users only** (returns early for anonymous).
- `competitor_detection`: `enabled`, `competitor_brands`, `competitor_domains`, `case_sensitive`.
- `marketing_detection`: `enabled`, `promotional_keywords`, `url_detection`, `email_detection`,
  `phone_detection`, `discount_patterns` (regex, one per line — user regex is run with `preg_match_all`).
- `pii_detection`: `enabled`, `detect_emails`, `detect_phones`, `detect_ssn`, `detect_credit_cards`,
  `detect_addresses`, `custom_pii_patterns` (regex).

## Post-moderation (`PostModerationSettingsForm`, route `.post_moderation`) — `post_moderation.*`

`enabled` (true), `review_period_days` (30), `auto_escalate_threshold` (3),
`auto_unpublish_on_flag` (false), `require_moderator_review` (true), `allow_anonymous_reports`
(false), `require_reason` (true), `max_flags_per_user_per_day` (5). These gate the programmatic
`CommentModerator::flagCommentPostModeration()` API; **no route or UI in this release actually calls
it** — only `post_moderation.enabled` is read (as a gate) by that method. The schema only maps
`enabled`, `review_period_days`, `auto_escalate_threshold`; the extra keys are saved but unschemad.

## Key storage

The OpenAI key lives in a **Key entity** (`key_select`, group `authentication`), so the secret is
managed by the Key module (env / file / config provider), not stored by this module. `OpenAIClient`
reads it via `KeyRepositoryInterface::getKey(...)->getKeyValue()` at call time. To create an
env-backed key per repo convention:
`drush key:save openai_api_key --label='OpenAI API Key' --key-type=authentication --key-provider=env --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' --key-input=none -y`,
then select it in the settings form.
