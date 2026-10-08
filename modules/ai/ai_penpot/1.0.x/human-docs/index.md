# AI Penpot — manual setup guide

**AI Penpot** (`ai_penpot`) gives Drupal's AI agents live access to your
**Penpot** designs. Penpot is an open-source design tool (a Figma-style
alternative); this module reads design context from it through the Penpot API —
components, layout, and so on — and exposes that to AI agents. The result is that
a Drupal AI agent building or checking a user interface can reference the actual
design rather than guessing, bridging the gap between what was designed and what
gets implemented.

It is an add-on to the AI Agents part of the Drupal AI ecosystem. It depends on
the core **AI** module, the **AI Agents** module, the **Key** module, and
**Easy Encryption** — the last two so your Penpot API credentials are stored
encrypted and securely rather than in plain configuration. It targets a recent
Drupal (11.2+).

Access is controlled by two permissions: **Use AI Penpot design context** (`use
ai penpot design context`) for agents/users that read design context, and
**Administer AI Penpot** (`administer ai penpot`) for setting up the connection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm its AI Agents, Key, and Easy Encryption dependencies.

## Where it lives in the admin menu

Setup lives under the module's own administration, gated by **Administer AI
Penpot** — this is where you supply the Penpot API credentials, which are stored
encrypted via Easy Encryption and the Key module.

## How to use it

Connect the module to your Penpot account with an API credential, then let your
Drupal AI agents pull the relevant design context while they build or verify UI.
Grant **Use AI Penpot design context** to the agents/users that should be able to
read designs, and keep the credentials secured through the Key/Easy Encryption
setup.
