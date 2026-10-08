<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI usage limits

## Where
`/admin/config/ai/usage_limits` (menu: AI settings → *AI Usage Limits*). Requires permission **`administer ai providers`**.

## Settings form (`SettingsForm`)
- **Retention days** (`retention_days`, default 30, min 1) — after this many days cron clears a provider's accumulated counters.
- Per provider (one vertical tab per plugin from `ai.provider` manager):
  - **Enable usage limits** (`providers.<id>.enable_limits`).
  - Numeric limits, each stored at `providers.<id>.<key>`:
    - `input_token_usage`, `output_token_usage`, `total_token_usage`, `cached_token_usage`, `reasoning_token_usage`.
  - Fields show "Used @amount tokens in the last @days days" when a live count exists.

All values persist to config object `ai_usage_limits.settings`.

## Runtime behaviour
- **Counting:** `CountTokenUsageSubscriber` listens to `PostGenerateResponseEvent` / `PostStreamingResponseEvent` and adds the response's token usage into state key `ai_usage_limits` keyed by provider id, stamping `retention_start_date` on first use.
- **Enforcement:** `CheckTokenUsageSubscriber` listens to `PreGenerateResponseEvent`; for each token type, if the stored usage exceeds the configured limit it throws `\Drupal\ai_usage_limits\Exception\AiTokenUsageException`, aborting the call before the provider runs.
- **Window reset:** `ai_usage_limits_cron()` clears a provider's counters once `retention_start_date + retention_days` has passed.

## Drush / API notes
- No Drush commands. Inspect live usage with `drush state:get ai_usage_limits`; clear it with `drush state:delete ai_usage_limits`.
- Tested mainly with AI Provider OpenAI; other providers extending `OpenAiBasedProviderClientBase` may work (untested).
