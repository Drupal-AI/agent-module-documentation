<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Monitoring captures Drupal log entries, sends batches to an AI provider for severity assessment, and dispatches actionable alerts through pluggable channels.
---
A `LogCaptureLogger` stages log entries; `LogAnalysisManager` batches them and asks the configured AI provider (via drupal/ai `ChatInterface`) to return structured JSON assessing severity, impact, likely cause and next step per entry, with a dedup key. A `ThresholdAnalyzer` provides a non-AI fallback. Results are written to analysis/alert log tables and surfaced on a dashboard under `/admin/reports/ai-monitoring`.

`AlertDispatcher` turns actionable results into alerts, applying deduplication, rate limiting, noise controls (maintenance/business-hours/digest) and a severity→channel routing matrix, then calls channel plugins (`AlertChannel` attribute): Drupal notification, email, Slack and generic webhook, configured via bundled channel config. A `CircuitBreaker` protects against provider failures and a `TokenResolver` fills `{{mustache}}` placeholders in templates. AI keys are managed through the required Key module + drupal/ai provider layer. All routes are admin/report permission-gated; outbound Slack/webhook targets are admin-configured.
---
- Analyze Drupal logs with an AI provider for real severity.
- Fall back to threshold-based analysis without AI.
- View a health dashboard at /admin/reports/ai-monitoring.
- Browse the AI analysis log of past batches.
- Browse dispatched alert history.
- Acknowledge an alert from the dashboard.
- Route alerts to email based on severity.
- Post alerts to a Slack channel.
- Send alerts to a generic outbound webhook.
- Raise in-Drupal notification alerts.
- Deduplicate repeated alerts within a window.
- Rate-limit alerts per hour to reduce noise.
- Suppress alerts during maintenance or off-hours.
- Batch and digest low-severity notifications.
- Define a severity→channel routing matrix.
- Template alert subject/body with `{{tokens}}`.
- Trip a circuit breaker when the AI provider fails.
- Cap prompt and per-entry character sizes.
- Append custom context to the analysis prompt.
- Manage the AI API key through the Key module.
- Restrict configuration to administrators, dashboards to report viewers.
- Add a custom alert channel via the AlertChannel plugin attribute.