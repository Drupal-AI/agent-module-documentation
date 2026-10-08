# Log Alert Rules — manual setup guide

**Log Alert Rules** (`log_alert_rules`) turns Drupal's built-in **watchdog
(database logging)** stream into something you can be *notified* about. Instead of
manually watching the log or writing one-off automation for recurring errors, you
define **alert rules** that watch specific log channels and severities for a
pattern, and when the number of matching entries crosses a threshold within a time
window, the module sends a notification. A **cooldown** keeps a noisy problem from
flooding you with repeat alerts.

Each rule can target a specific log channel (or any channel), one or more severity
levels, a substring or PCRE regex message pattern (with an optional "negate"
pattern), and either the raw or the rendered message. Rules are stored as
configuration entities, so they can be exported and imported as YAML for
deployment, and you can **test a rule** against recent log entries before relying
on it.

Notifications are built around reusable **Notification Targets** — named
destinations you define once and attach to as many rules as you like, cleanly
separating *how* an alert is sent from *where* it goes. The base module ships an
**email** channel; two optional submodules extend it. **Log Alert Rules Webhook**
adds **Slack** (Block Kit messages via an incoming webhook) and generic webhook
channels, with the webhook URL stored securely through the **Key** module — a
dependable out-of-band channel for when mail itself is what's failing. **Log Alert
Rules Monolog** wires the alerting engine into sites running the **Monolog** contrib
module (without it, a Monolog site silently receives no alerts).

Everything is locked down to trusted admins: all routes require the **administer log
alert rules** permission, and the enable/disable toggles are additionally CSRF
protected. The module exposes alert *configuration*, not raw log contents.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it (and
   the submodules you need), and confirm dblog is on.
2. [Configuration](configuration/index.md) — create rules, set thresholds and
   cooldowns, define notification targets, and test everything.

## Where it lives in the admin menu

The main screen is **Configuration → System → Log Alert Rules**
(`/admin/config/system/log-alert-rules`), where you manage rules. Notification
targets live at `/admin/config/system/log-alert-rules/targets`.
