# AI Monitoring — manual setup guide

**AI Monitoring** (`ai_monitoring`) watches your Drupal log and uses AI to tell
you which entries actually matter. It captures log messages, batches them, and
sends each batch to your configured AI provider, which returns a structured
assessment for every entry — its real severity, likely impact, probable cause,
and a suggested next step. The results feed a health dashboard and drive alerts,
so instead of drowning in raw watchdog noise you get a shortlist of things worth
acting on. If AI is unavailable, a non-AI threshold analyser acts as a fallback.

When something is judged actionable, the module dispatches an alert through
pluggable **channels** — an in-Drupal notification, email, a **Slack** incoming
webhook, or a generic outbound **webhook** — chosen by a severity→channel routing
matrix you define. To keep alerts useful rather than overwhelming, it
deduplicates repeats, rate-limits per hour, can stay quiet during maintenance
windows or outside business hours, and can digest low-severity items. A circuit
breaker protects the site if the AI provider starts failing.

It builds on the core **AI** module (for the provider connection) and the **Key**
module (to hold the AI API key as a secret). All of its pages are permission-
gated, and the Slack/webhook destinations are configured by an administrator.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI and Key dependencies.
2. [Configuration](configuration/index.md) — choose the provider/model, tune
   prompt sizing, define the routing matrix, and set up the alert channels.

## Where it lives in the admin menu

- **Settings:** **Configuration → AI → AI Monitoring**
  (`/admin/config/ai/ai-monitoring`), gated by **Administer AI Monitoring**.
- **Dashboard, analysis log, and alert history:** under **Reports → AI
  Monitoring** (`/admin/reports/ai-monitoring`), gated by the **View AI
  Monitoring dashboard** / **View AI Monitoring alerts** permissions.

## How to use it

Configure a provider and model, decide which severities route to which channels,
and wire up the channels (email address, Slack webhook, outbound webhook). As log
entries are captured and analysed, watch the dashboard for the health picture,
review the analysis log to see what the AI concluded, and acknowledge alerts as
you deal with them. Adjust the noise controls until the alert volume matches what
your team can actually act on.
