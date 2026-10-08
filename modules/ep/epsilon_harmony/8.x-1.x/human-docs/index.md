# Epsilon Harmony — manual setup guide

**Epsilon Harmony** (`epsilon_harmony`) is a client module that connects Drupal to
[Epsilon's Agility Harmony](https://www.epsilon.com/gb/agility-harmony/) marketing
and customer‑data platform. It lets your site call a set of pre‑defined Harmony API
methods so you can push customer/profile data and messages from Drupal into Epsilon.

This is a **developers‑only** module — it provides the plumbing to call the APIs
rather than a ready‑made editorial feature. The current release integrates three
Harmony APIs:

- **Create a Profile Record**
- **Update a Profile Record**
- **Send a Real Time Message (RTM)**

For debugging, every request to and response from the API is **logged to the
database**, and those logs are exposed through **Views** so you can inspect them.
(The module depends on core Views for that reason.)

Because it talks to an external marketing platform, two things matter: the **API
credentials** are secrets that must be stored securely and never committed, and the
data you send (profiles, messages) **leaves your site** for Epsilon — an egress to
account for in your privacy and data‑processing terms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supplying and safely storing the
   Epsilon Harmony API credentials, plus the logging and egress notes.

## Where it lives in the admin menu

Epsilon Harmony's connection settings — the Harmony API credentials — are entered
under **Configuration**. The request/response debug logs are viewable through the
**Views**‑based listing the module provides. The module also defines its own
permission, granted at **People → Permissions**.
