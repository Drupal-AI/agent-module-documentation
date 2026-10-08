<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI usage limits lets administrators cap token consumption per AI provider for the Drupal AI module and blocks further calls once a configured limit is exceeded.
---
The core AI module can call paid LLM providers with no built-in ceiling on spend. This module adds a per-provider quota: for each provider it can limit input, output, total, cached and reasoning token usage. It counts usage by subscribing to the AI module's `PostGenerateResponseEvent` and `PostStreamingResponseEvent` (`CountTokenUsageSubscriber`), accumulating totals in Drupal `state` under the `ai_usage_limits` key, and enforces the limits by subscribing to `PreGenerateResponseEvent` (`CheckTokenUsageSubscriber`) — when accumulated usage exceeds a configured limit it throws an `AiTokenUsageException` that aborts the request before the provider is called.

Counters are windowed: each provider's usage carries a `retention_start_date`, and `hook_cron()` clears a provider's counters once `retention_days` (default 30) have elapsed. An `AiProviderEventSubscriber` reacts to `ProviderDisabledEvent`. Configuration lives at `/admin/config/ai/usage_limits` (menu under the AI settings), gated by the core AI permission **`administer ai providers`**; the form lists every provider the AI plugin manager knows about with a checkbox to enable limits plus the five numeric limit fields, and shows tokens used in the current window. The module is documented as tested primarily with the OpenAI provider (any provider extending `OpenAiBasedProviderClientBase` may work). Limits and retention are stored in the `ai_usage_limits.settings` config object; live counts are in state, not config.
---
- Cap total token usage for an OpenAI provider to control monthly spend.
- Set separate input and output token ceilings per provider.
- Limit cached-token or reasoning-token usage independently.
- Block AI requests automatically once a provider hits its quota.
- Reset usage counters every 30 days via cron (default retention).
- Shorten or lengthen the retention window to match a billing cycle.
- Enable limits for one provider while leaving others uncapped.
- Review tokens consumed in the current window from the settings form.
- Protect a site from runaway automated AI jobs exhausting an API budget.
- Give an editor role AI access with a safety ceiling on cost.
- Stop generation before a paid API call when the limit is already exceeded.
- Audit which providers currently have limits enabled.
- Temporarily disable a provider's limits without deleting the values.
- Investigate an `AiTokenUsageException` blocking generation.
- Clear accumulated counts by waiting out the retention window.
- Configure quotas for multiple providers from one vertical-tab form.
- Combine with LiteLLM/OpenAI proxies for finer cost management.
- Enforce a hard stop for a demo or trial environment.
- Confirm counters are stored in Drupal state, not exported config.
- Tune retention so counters roll over daily for high-traffic sites.
