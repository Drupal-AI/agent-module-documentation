# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → AI Log Analysis**, or navigate directly to
   `/admin/config/system/ai-log-analysis`.

This is the settings form for the analysis feature. Once the AI module has a
working provider, the module's logger captures messages into its own
`ai_log_analysis` table (separate from core's dblog), ready to analyze.

## Analyze a log entry

1. Open the log list at `/admin/ai-log-analysis/logs`. It shows captured messages
   with paging and an **Analyze** button on each row.
2. Click **Analyze** on an entry (this opens `/admin/ai-log-analysis/logs/{key}`).
   The module sends that entry to your configured AI provider and returns an
   interpretation and suggested fix. The AI output is rendered with HTML escaping
   and light markdown formatting.

Because analysis sends the entry's contents to the external AI provider, be
mindful that log messages can contain sensitive information before you send them
out.

## Clear the captured logs

An admin action lets you clear all captured entries, which truncates the module's
log table. Use it when you want a clean slate; it does not touch core's own dblog.

## From the command line

The module also offers a Drush command for analyzing error logs, useful for
scripting or quick checks without opening the UI.
