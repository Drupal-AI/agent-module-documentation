<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Monitoring (ai_monitoring) — agent index

**Batches Drupal logs to an AI provider for severity analysis and dispatches deduplicated, rate-limited alerts across channel plugins.**

- **Version:** 1.0.x (1.0.0-alpha1)  •  **Core:** ^10.2 || ^11  •  **Package:** AI
- **Depends on:** ai, key
- **Routes:** settings `/admin/config/ai/ai-monitoring` (`administer ai monitoring`); dashboard + analysis + alert logs `/admin/reports/ai-monitoring[...]` (`view ai monitoring dashboard` / `view ai monitoring alerts`); alert ack (`administer ai monitoring`).
- **Permissions:** `administer ai monitoring` (restricted), `view ai monitoring alerts`, `view ai monitoring dashboard`.
- **Plugins:** `AlertChannel` attribute (drupal_notification, email, slack, webhook).  **Services:** LlmAnalyzer, AlertDispatcher, CircuitBreaker, DeduplicationService, ThresholdAnalyzer, TokenResolver.

**Security:** all routes are admin/report-permission gated; no anonymous endpoints. Slack/webhook destinations are admin-configured outbound calls; AI keys via required Key module + drupal/ai. See [configure/settings.md](configure/settings.md).
