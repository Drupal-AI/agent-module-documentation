# Suspect Blocker — manual setup guide

**Suspect Blocker** (`suspect_blocker`) is a lightweight security tool that watches
for suspicious request patterns — the rapid, scattershot probing of many URLs that
signals a bot, a vulnerability scanner, or a brute-force / flood attack — and
automatically bans the offending IP address once it crosses a threshold you set.

It works by watching for **bursts**: rapid access attempts to multiple pages within
a short time window, especially requests that trigger error responses like **403**
and **404**. When an IP exceeds your configured threshold of suspicious activity,
Suspect Blocker bans it through Drupal core's **Ban** module. It logs the suspicious
attempts — IP, path and HTTP status — via **syslog** for later analysis, and uses
in-memory logging during a request to keep the performance cost low.

The module works once enabled and configured, but the defaults are conservative and
you will usually want to tune them: the ban threshold defaults to **5** suspicious
requests and the monitoring window to **60** seconds. It depends on core's **Ban**
module (required for the IP-banning to work) and **syslog**, and it provides its own
permission. It targets Drupal 10 and 11.

One thing to keep in mind: because it bans automatically, set your threshold and
window thoughtfully to avoid false positives — legitimate crawlers, or several real
users sharing one IP (behind a corporate proxy or NAT), can look bursty. Start a
little loose and tighten as you learn your traffic.

This guide is written for a **human** configuring the module through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the ban threshold and monitoring
   window.

## Where it lives in the admin menu

The settings page is at **Configuration → Security → Suspect Blocker**
(`/admin/config/security/suspect-blocker`). Banned addresses are managed by core's
Ban module at **Configuration → People → IP address bans**.
