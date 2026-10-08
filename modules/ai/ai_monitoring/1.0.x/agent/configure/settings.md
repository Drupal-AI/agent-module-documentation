<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Monitoring

Route `/admin/config/ai/ai-monitoring` (`administer ai monitoring`). Config `ai_monitoring.settings` plus per-channel config objects `ai_monitoring.channel.{email,slack,webhook,drupal_notification}`.

Key settings:
- `ai_provider`, `ai_model` — drupal/ai provider + model used by `LlmAnalyzer::analyzeBatch()`.
- `max_log_entry_chars`, `max_prompt_chars`, `ai_prompt_append` — prompt sizing and extra context.
- `routing_rules` — severity (0–4) → list of channel IDs. A severity with no channels is suppressed (de-escalated).
- Noise controls — maintenance window, business hours, digest mode, `max_alerts_per_hour`.

Pipeline:
1. `LogCaptureLogger` stages log entries into a staging table.
2. `LogAnalysisManager` batches entries; `LlmAnalyzer` sends system+user chat to the AI provider and parses a JSON array of assessments (severity, summary, impact, likely_cause, next_step, action_required, dedup_key). `ThresholdAnalyzer` is the non-AI fallback.
3. Results are stored in analysis_log; `AlertDispatcher::dispatchBatch()` filters to actionable ones, applies dedup → noise controls → rate limit → routing, and calls each resolved `AlertChannel` plugin.
4. `TokenResolver` fills `{{severity}}`, `{{message}}`, `{{site_name}}`, `{{next_step}}`, etc. in channel templates. `CircuitBreaker` halts AI calls after repeated provider failures.

Channels: email (site mail), slack (incoming webhook URL), webhook (arbitrary POST URL + payload template), drupal_notification. Add a channel by implementing a plugin with the `#[AlertChannel]` attribute. Store the AI API key as a Key entity (Key module is required).
