<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Log Analysis records log messages into its own table and lets admins analyze individual entries with an AI provider to get insights and suggested fixes.

---

Install the module (requires the AI module) and configure it at /admin/config/system/ai-log-analysis (permission: administer site configuration). A logger service captures messages; the log list is at /admin/ai-log-analysis/logs and per-entry analysis at /admin/ai-log-analysis/logs/{key}.

---

- Capture log messages into an ai_log_analysis table.
- Register a logger service at high priority.
- Analyze a log entry with the AI provider.
- Show a paginated log list with Analyze buttons.
- Provide a settings form for the analysis.
- Offer a Drush command for error-log analysis.
- Clear all captured logs via an admin action.
- Gate analyze/clear/settings behind site configuration.
- Render AI output with HTML escaping and simple markdown.
- Deserialize log variables with allowed_classes FALSE.
- Depend on the core AI module for provider access.
- Serve developer/log-analysis workflows.
- Note: log contents can be sensitive (paths, errors).
- Use the standard ai.provider service for LLM calls.
- Store logs separately from core dblog.
- Truncate the table on clear.
