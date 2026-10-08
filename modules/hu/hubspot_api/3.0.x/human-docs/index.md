# HubSpot API — manual setup guide

**HubSpot API** (`hubspot_api`) is the credential and connection layer between
Drupal and [HubSpot](https://www.hubspot.com/). It is deliberately a *library*
rather than a feature: it holds your HubSpot credentials, handles authentication,
and exposes a reusable client (a `hubspot_api.manager` service) that other
modules build on. It does not, on its own, sync anything or add visible features
— that logic lives in the modules that consume it.

That division of labour is the right one. No two sites want the same thing from
HubSpot, and if every integration managed its own API key you would quickly end
up with several copies of the same credential scattered across a site. HubSpot
API keeps the credential in one place so everything else can share it.

Because this module is mainly for developers and integrators, most people install
it as a dependency of another module (such as HubSpot Client) rather than on its
own. Whatever the path, the one thing you must get right here is the
**credential**, because it grants access to real personal data in your CRM.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter and securely store your
   HubSpot API credentials.

## Where it lives in the admin menu

Once enabled, the module provides a settings form where you enter your HubSpot
credentials (a private‑app token or OAuth settings). This is the "HubSpot API
settings form" that consuming modules refer to. See
[Configuration](configuration/index.md) for how to reach it and, importantly, how
to store the credential securely rather than pasting it straight into the form.
