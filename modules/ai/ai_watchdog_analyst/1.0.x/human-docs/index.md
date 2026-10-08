# AI Watchdog Analyst — manual setup guide

**AI Watchdog Analyst** (`ai_watchdog_analyst`) reads your Drupal log — the
Watchdog / Database Logging (`dblog`) entries — and uses AI to explain what the
errors and warnings likely mean and how to fix them. Instead of squinting at a
raw stack trace, an operator gets a plain‑language interpretation of the probable
cause and suggested next steps, which speeds up triaging site issues.

It builds on the AI module and sends the relevant log entries to whatever AI
provider you have configured. That means two things worth being clear about:
there is a **per‑call cost** to the provider, and log entries **leave your site**
to be analyzed. Logs can contain sensitive data (user input, file paths, tokens
in messages) — consider what is in your log before sending it, and whether that
egress is acceptable for your site.

It is an operations aid, not an access‑control feature. It adds AI analysis on
top of the log you already have.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module works alongside core's log at **Reports → Recent log messages**
(`/admin/reports/dblog`) and provides its own permission to control who may run
the AI analysis. It has no separate settings form of its own; the AI provider it
uses is configured in the **AI** module.

## How to use it

1. Make sure core **Database Logging** (`dblog`) is on and the **AI** module has
   a working provider.
2. Enable AI Watchdog Analyst and grant its permission to the operators who
   should use it.
3. From the log, run the AI analysis on an entry to get a plain‑language
   explanation of the likely cause and suggested fixes.
4. Treat the suggestions as a starting point for triage — verify before acting.
