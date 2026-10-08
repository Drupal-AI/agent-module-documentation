# AI Log Analysis — manual setup guide

**AI Log Analysis** (`ai_log_analysis`) records your site's log messages into its
own table and lets an administrator ask an AI provider to explain a given entry
and suggest a fix. When a cryptic error shows up in the logs, instead of pasting
it into a search engine you click **Analyze** next to it, and the module sends
that entry to your configured AI model and shows back an interpretation and
recommended next steps.

It builds on Drupal's **AI** module for model access — you configure the provider
and its API key once there — and captures log messages through its own logger
service, storing them separately from core's standard log (dblog). From the admin
list you can page through captured messages, analyze any one of them, and clear
the whole table when you want a clean slate. There is also a Drush command for
analyzing error logs from the command line.

The analyze, clear and settings actions are gated behind the site-configuration
permission. Note that analyzing an entry sends its contents to the external AI
provider, so treat log data as potentially sensitive before sending it out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and how to analyze
   entries.

## Where it lives in the admin menu

- **Settings:** `/admin/config/system/ai-log-analysis`
  (**Administer site configuration**).
- **Log list:** `/admin/ai-log-analysis/logs`.
- **Analyze an entry:** `/admin/ai-log-analysis/logs/{key}`.

## How to use it

1. Enable the module (it needs the AI module with a working provider) and open the
   settings form.
2. Let the logger capture messages, then open the log list and click **Analyze**
   on any entry to get an AI interpretation and suggested fix.
3. Clear the captured logs when you want to reset. See
   [Configuration](configuration/index.md) for details.
