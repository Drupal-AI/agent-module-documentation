# Suppress Logs — manual setup guide

**Suppress Logs** (`suppress_logs`) lets you turn off logging for specific log
**channels** so that noisy, low-value messages stop being written. Logging is not
free — writing an entry such as "page not found" on every routine page load means
real disk writes — so silencing the channels you genuinely do not need can reduce
that overhead and keep your logs focused on what matters.

Under the hood it decorates Drupal's logger factory: messages from the channels you
list are routed to a "null" logger and simply dropped, rather than being written to
dblog / watchdog. It is configured on a settings form, provides its own permission
for who may change that configuration, and sits in the Performance package. It has
no dependencies beyond Drupal core.

**Please use it carefully.** Suppressing logs can also hide security-relevant
events. Records of failed logins, access-denied errors, and exceptions are exactly
what you rely on to detect attacks and to investigate incidents afterwards, so
being heavy-handed here weakens your ability to see and reconstruct what happened.
The safe approach is to be selective: suppress only a specific, genuinely noisy
channel or message, and **never broadly suppress security, error or audit
channels**. Keep the suppression list tight, and review it periodically.

This guide is written for a **human** configuring the module through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the log channels you want to
   ignore, and the safety rules to follow.

## Where it lives in the admin menu

The module's settings form is the **Suppress Logs settings form**
(`suppress_logs.settings_form`), reached under **Configuration**. Access to it is
gated by the module's own permission, so only trusted administrators can change
what gets suppressed.
