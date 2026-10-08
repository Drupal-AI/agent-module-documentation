<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI usage limits & the dashboard

## Create a limit
Go to **Configuration > AI > Budget Control** (`/admin/config/ai/budget`) -> **Add**. An `ai_limit_config` entity has:
- **Provider** — a specific `ai` provider plugin id, or `_all` for every provider.
- **Scope** — `global`, `role` (pick a role), or `user` (autocomplete). Collapsed into `scope_value` on save.
- **Metric** — `tokens`, `budget` (dollars), or `requests`.
- **Limit value** — the ceiling for that metric.
- **Time window** — `hour`, `day` or `month`.
- **Price per 1k tokens** — used to estimate cost / drive `budget` limits.
- **Soft limit** — if enabled, at `soft_limit_percentage` (default 80%) the request is *allowed* but a warning is logged and `SoftLimitReachedEvent` is dispatched; a hard limit (soft disabled) blocks once usage >= limit.

## How enforcement works
- `AiOperationSubscriber::onPreGenerate` (prio 100) -> `AiUsageManager::checkLimits()`. A breached hard limit sets a forced `ChatOutput` so the provider is never called. Anonymous callers are also flood-limited to 20 requests/hour by IP.
- `onPostGenerate` extracts token usage from the `ChatOutput`, estimates cost, and writes an `ai_usage_log` row (uid, provider, model, operation_type, tokens_in/out, estimated_cost, timestamp).

## Monitor
- **Dashboard:** `/admin/reports/ai-usage` (`view ai usage dashboard` or `administer ai budget control`) — tables of usage/cost, auto-escaped render arrays.
- **CSV export:** `/admin/reports/ai-usage/export` (`administer ai budget control`).

## Notes
- The module never stores or logs provider API keys.
