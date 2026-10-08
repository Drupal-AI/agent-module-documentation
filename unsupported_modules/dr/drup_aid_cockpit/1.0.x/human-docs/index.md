# Drup-AID Cockpit — manual setup guide

**Drup-AID Cockpit** (`drup_aid_cockpit`) is the admin "cockpit" for the Drup-AID
project — one branded admin screen where you can **watch the Drup-AID master agent
and its sub‑agents work, and steer them**. Instead of piecing together what the AI
agents are doing from logs, you get a single place to observe and direct them.

It builds on Drupal's **AI** and **AI Agents** modules, which provide the
underlying agent framework and the connection to your AI provider. The cockpit
itself is an observation and control surface; access to it is gated by the
**access drup-aid cockpit** permission, so you decide who can watch and steer the
agents. AI provider credentials are **not** configured in the cockpit — they are
handled by the AI module (typically via a Key entity backed by an environment
variable), which keeps secrets out of the cockpit and out of exported config.

Note on packaging: the module machine name is `drup_aid_cockpit`, but it is part
of the **`drup_aid`** project, so you install it with `composer require
drupal/drup_aid` (see Installation). This documented release is an early
(1.0.0‑beta1) build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, grant the cockpit permission, and make sure your AI provider key is set
   up.

There is **no settings form** for this module — the cockpit is a monitoring/
control screen, and AI provider configuration lives in the AI module. The only
setup here is granting the permission (see Installation).

## Where it lives in the admin menu

Once enabled, the cockpit is an admin screen reachable by users who hold the
**access drup-aid cockpit** permission. It adds no configuration page of its own;
provider keys and agent definitions are managed through the **AI** and **AI
Agents** modules.
