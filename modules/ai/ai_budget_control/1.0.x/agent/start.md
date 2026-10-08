<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Budget Control (ai_budget_control) — agent index

**Meters and caps Drupal `ai` usage (tokens / spend / requests) per provider, role or user; dashboard + CSV export.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Requires:** ai:ai
- **Mechanism:** `AiOperationSubscriber` on `PreGenerateResponseEvent` (checkLimits -> forced output on hard limit) + `PostGenerateResponseEvent` (log usage -> `ai_usage_log` table). Config entity `ai_limit_config` (provider/scope/metric/limit_value/time_window/price_per_1k_tokens/soft-limit).
- **Routes:** `/admin/reports/ai-usage` (dashboard; `view ai usage dashboard,administer ai budget control`), `/admin/reports/ai-usage/export` (CSV; `administer ai budget control`), entity CRUD at `/admin/config/ai/budget`.
- **Permissions:** `administer ai budget control` (restrict access), `view ai usage dashboard`.
- **Services:** `ai_budget_control.usage_manager`, `.event_subscriber`.

**Security:** All routes permission-gated (no `_access:TRUE`, no anonymous). No outbound HTTP, no API keys handled/logged. SQL uses the query builder with bound params; no `unserialize`/weak RNG. Anonymous AI requests are flood-limited by IP.

See [configure/limits.md](configure/limits.md).
