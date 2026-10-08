<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI usage limits (ai_usage_limits) — agent index

**Per-provider token quotas for the Drupal AI module; blocks generation when a limit is exceeded and resets counters on a retention schedule.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11
- **Dependencies:** `ai`
- **Config route:** `ai_usage_limits.settings` → `/admin/config/ai/usage_limits`, permission **`administer ai providers`** (from the AI module).
- **Config object:** `ai_usage_limits.settings` (`providers.<id>.{enable_limits,input_token_usage,output_token_usage,total_token_usage,cached_token_usage,reasoning_token_usage}`, `retention_days` default 30).
- **State:** live counts under state key `ai_usage_limits` (per provider, with `retention_start_date`).
- **Services (event subscribers):** `CountTokenUsageSubscriber` (Post[Generate|Streaming]ResponseEvent → accumulate), `CheckTokenUsageSubscriber` (PreGenerateResponseEvent → throw `AiTokenUsageException` on overage), `AiProviderEventSubscriber` (ProviderDisabledEvent). `hook_cron()` clears expired windows.

**Security:** single admin config route gated by `administer ai providers`; no anonymous, mutating or public endpoints. Enforcement is server-side via event subscribers. See [configure/usage-limits.md](configure/usage-limits.md).
