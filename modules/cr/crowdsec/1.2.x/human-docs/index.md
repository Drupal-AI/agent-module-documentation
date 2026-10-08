# CrowdSec — manual setup guide

**CrowdSec** (`crowdsec`) connects your Drupal site to the
[CrowdSec](https://www.crowdsec.net/) crowd-sourced security network. It watches for
bad behaviour on your site, bans the offending IP addresses locally, optionally reports
those detections upstream so the wider CrowdSec community benefits, and downloads and
enforces CrowdSec's community blocklists — all in-process, with **no separate CrowdSec
agent or bouncer to install** on the server.

There are three things going on, and it helps to keep them separate:

1. **Ban plugins** detect bad behaviour on *this* site and ban IPs locally. Three ship
   in the box: **flood** (Drupal flood-control / login brute force), **core-ban** (IPs
   you've banned through core's Ban module), and **whisper** (an IP that racks up too
   many 4xx responses in a short window — i.e. scanning/probing).
2. **Signal scenarios** decide which of those local bans are also *reported upstream*
   to CrowdSec. Turning a signal off only stops the reporting; it does not disable the
   local ban.
3. **Subscribe scenarios** decide which upstream CrowdSec *blocklists* your site
   downloads and enforces — matching requests are rejected with a 403 by an HTTP
   middleware. This is how you block known SQL-injection probing, XSS probing,
   path-traversal, sensitive-file scans, bad user-agents, and so on.

All of it is driven by one settings page. An optional **CTI (threat-intelligence) API
key** lets the site pull richer data about IP addresses, and cron handles pushing
buffered signals and refreshing blocklists automatically. Events let other code react
to bans/blocks/signals, and the bundled **eca_crowdsec** submodule exposes those events
to [ECA](https://www.drupal.org/project/eca).

> **Note on this environment:** CrowdSec's upstream operations (enrolling, pushing
> signals, downloading blocklists) require reaching the CrowdSec service and, for some
> features, an API key. Reading and changing the module's local configuration works
> normally, but without connectivity/keys the upstream calls won't complete.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `crowdsec/remediation-engine` library) and enable the module.
2. [Configuration](configuration/index.md) — the settings page field by field, the
   ban plugins, signal vs subscribe scenarios, and supplying an API key safely.

## Where it lives in the admin menu

The settings page is at **Configuration → Web services → CrowdSec**
(`/admin/config/services/crowdsec`), gated by the *Administer site configuration*
permission. Drush commands (`crowdsec:enroll`, `crowdsec:signal`, `crowdsec:collect`
and the `crowdsec:test:*` helpers) cover enrolment, signalling, blocklist refresh and
testing from the command line.
