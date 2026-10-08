# PillarShield — manual setup guide

**PillarShield** (`pillarshield`) is a Drupal connector for the **PillarShield
governance service** ([pillarshield.co](https://pillarshield.co)). It sends
content to the PillarShield service for evaluation and receives back an
**allow / warn / block** decision (with details), so you can enforce content
governance and compliance policies as part of your editorial workflow.

By default, enforcement runs at the **publish / visibility boundary** — that is, a
draft save is *not* blocked, but an attempt to publish content that PillarShield
blocks is stopped. This "Gate" behaviour is designed to complement existing
editorial workflows, including core's **Content Moderation**. Alongside the gate,
there is an optional, permission‑gated **manual "Check PillarShield Governance"**
action you can run on any save, which records the decision without blocking, and
optional audit‑logged overrides for authorised users. A whitelisting feature lets
you cut down on unnecessary checks, and an admin report at
`/admin/reports/pillarshield` shows blocked publish attempts and decisions.

Because the module sends content to an external SaaS, two things matter: the
**API key** is a secret and should be stored via the **Key** module (a hard
dependency), never committed to code; and you should review exactly what site data
is sent to PillarShield before enabling it. Note that this is an early‑development
release and the maintainer describes it as actively evolving.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Key dependency.
2. [Configuration](configuration/index.md) — store your API key securely, test the
   connection, choose which content is evaluated, and set enforcement and
   permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → PillarShield**
(`/admin/config/content/pillarshield`), and the governance report is at
**Reports → PillarShield** (`/admin/reports/pillarshield`). See
[Configuration](configuration/index.md).
