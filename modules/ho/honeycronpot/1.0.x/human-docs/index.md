# Honeycronpot — manual setup guide

**Honeycronpot** (`honeycronpot`) hardens the popular
[Honeypot](https://www.drupal.org/project/honeypot) spam‑protection module by
turning its honeypot field into a moving target. Honeypot works by adding an
invisible field to your forms that real people never fill in but many bots do — a
submission that fills it is treated as spam. The catch is that a determined bot
can learn the fixed field name once and skip it forever. Honeycronpot rotates that
field name automatically on a schedule, so what a bot learned yesterday no longer
applies today.

It does this through **cron**: on a regular cron run the module changes the
honeypot field name (built from a configurable prefix and base names), keeping it
unpredictable. This is purely additive, defensive hardening — you keep all of
Honeypot's existing protections (including its time‑based checks) and simply raise
the bar for bots that fingerprint the static field. Honeycronpot has no
access‑control role of its own.

Because it builds directly on Honeypot, that module must be installed and enabled,
and your site must have **cron running reliably** for the rotation to happen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Honeypot, and make sure cron runs.
2. [Configuration](configuration/index.md) — the optional prefix and base‑name
   settings, and how the rotation is triggered.

## Where it lives in the admin menu

Honeycronpot needs no configuration to start working — once enabled it begins
rotating the honeypot field name on the next cron run. Its optional settings live
alongside the Honeypot module's own settings under **Configuration → Content
authoring → Honeypot configuration**. See [Configuration](configuration/index.md).
