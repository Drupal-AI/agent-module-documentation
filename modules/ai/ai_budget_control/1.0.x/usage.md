<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Budget Control caps and meters AI operations run through the Drupal `ai` module by provider, role or user.

---

An event subscriber (`AiOperationSubscriber`) listens on the AI module's `PreGenerateResponseEvent` (priority 100) and `PostGenerateResponseEvent`. On pre-generate it calls `AiUsageManager::checkLimits()`; if a matching *hard* limit is exceeded it short-circuits the provider call by setting a forced `ChatOutput`, returning a message instead of billing the API. On post-generate it reads the returned token usage, estimates cost from the limit's `price_per_1k_tokens`, and appends a row to the `ai_usage_log` database table. Limits are `ai_limit_config` config entities describing a provider (or `_all`), a scope (global/role/user) + scope value, a metric (tokens/budget/requests), a limit value, a time window (hour/day/month), and optional soft-limit behaviour (percentage threshold that only warns and dispatches `SoftLimitReachedEvent` while letting the request proceed).

Admins create limits at `/admin/config/ai/budget` (add/edit/delete) and watch consumption on the AI Usage Dashboard at `/admin/reports/ai-usage`, with a CSV export at `/admin/reports/ai-usage/export`. Permissions are `administer ai budget control` (restrict access, manages limits + export) and `view ai usage dashboard`. The module makes no outbound HTTP calls and never handles provider API keys — it only records provider id, model, uid and estimated cost. Anonymous AI requests are additionally flood-limited by client IP (20/hour).

---
- Cap total tokens spent through an AI provider per day/month.
- Set a dollar/budget ceiling per provider using price-per-1k-tokens.
- Limit the number of AI requests in a time window.
- Scope a limit globally, to a role, or to a specific user.
- Apply a limit to all providers at once with the `_all` provider option.
- Define a soft limit that only warns at, e.g., 80% instead of blocking.
- Hard-block AI generation once a limit is reached (forced output message).
- React to soft-limit breaches via the `SoftLimitReachedEvent`.
- View per-provider/user usage on the `/admin/reports/ai-usage` dashboard.
- Export the usage log to CSV for finance/reporting.
- Track estimated cost per operation from configured token pricing.
- Meter usage automatically for any code that uses the `ai` provider system.
- Restrict who can create limits with `administer ai budget control`.
- Grant read-only dashboard access via `view ai usage dashboard`.
- Flood-limit anonymous AI usage by IP (20/hour) out of the box.
- Choose the metric per limit: tokens, budget or request count.
- Pick the time window per limit: hour, day or month.
- Combine multiple limits; the first hard limit hit blocks the request.
- Audit historical AI spend from the `ai_usage_log` table.
- Log per-request tokens in/out and estimated cost for each operation.
