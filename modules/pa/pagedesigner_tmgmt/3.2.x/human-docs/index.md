# Pagedesigner TMGMT — manual setup guide

**Pagedesigner TMGMT** (`pagedesigner_tmgmt`) connects the
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder to **TMGMT** (Translation Management Tool), so pages you design in Pagedesigner
can be translated through the same TMGMT workflow you use for other content — including
machine translation providers such as **DeepL**. Without this bridge, Pagedesigner's
structured, component‑based content doesn't flow cleanly into TMGMT jobs; with it,
designed pages become translatable like anything else.

It is a multilingual / integration feature and has no access‑control role of its own.
One operational point is worth knowing before you turn it on: translating through TMGMT
and a provider like DeepL **sends your page content out to that translation provider**.
Confirm that this outbound data flow is acceptable for the content you're translating,
and store the provider's API credentials as **secrets** (an environment variable or a
Key entity), never hard‑coded in configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner and TMGMT.

This bridge has **no separate configuration page** (its configure route is empty). The
settings you actually work with live in **TMGMT** itself — its providers, credentials
and translation jobs. Set up the base
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) module and configure TMGMT
first, then this module makes Pagedesigner content available to that workflow.

## How to use it

1. Install and enable Pagedesigner, TMGMT and this module (see
   [Installation](installation/index.md)).
2. Configure your TMGMT translation provider (for example DeepL) under TMGMT's own
   settings, storing the provider credentials as secrets.
3. Create TMGMT translation jobs for your Pagedesigner content and process them through
   the normal TMGMT workflow.
