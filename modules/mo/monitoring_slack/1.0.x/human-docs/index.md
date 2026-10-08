# Monitoring Slack — manual setup guide

**Monitoring Slack** (`monitoring_slack`) posts a Slack message whenever one of
your [Monitoring](https://www.drupal.org/project/monitoring) sensors changes
status between runs — for example when a sensor goes from `OK` to `WARNING`. It is
a drop-in companion (or replacement) for Monitoring's built-in email submodule for
teams that live in Slack rather than an inbox, turning site-health changes into
ChatOps alerts in a channel you choose.

Notifications are sent through a **Slack incoming webhook**. Each message is a
Slack attachment colour-coded by the new status (green/amber/red), with a status
emoji, the sensor's label and message, the `old → new` status transition, the
sensor value, and a link back to the sensor details page in Drupal. You choose
which severities are worth notifying about (OK, INFO, WARNING, CRITICAL, UNKNOWN),
and cached sensor results are skipped so you only hear about genuine transitions.

This module needs a little configuration before it does anything: you paste your
Slack webhook URL and pick the severities on the Monitoring settings page. It
depends on the Monitoring module and works on Drupal 10.6 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a Slack webhook, paste it in,
   choose severities, and send a test.

## Where it lives in the admin menu

Monitoring Slack does not add its own page — it injects a **Slack notifications**
section into the existing Monitoring settings form at **Configuration → System →
Monitoring settings** (`/admin/config/system/monitoring`, config route
`monitoring.settings`), gated by the **Administer monitoring** permission.

## One thing to know upfront

Notifications only fire when Monitoring can detect a *transition* between runs,
which requires Monitoring's call logging to be on. If **Monitoring settings → Log
calls** is set to *none*, no transitions can be detected and nothing is sent — so
leave call logging enabled. See [Configuration](configuration/index.md).
