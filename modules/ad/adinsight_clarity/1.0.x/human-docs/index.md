# AdInsight / Clarity — manual setup guide

**AdInsight / Clarity** (`adinsight_clarity`) adds the Microsoft Clarity (also
branded AdInsight) analytics tracking script to your site. Once configured, it
injects Clarity's tracking snippet into your pages so that visitor behaviour —
sessions, heatmaps, and session recordings — is captured in your Clarity/AdInsight
account. You connect it to your account with a tracking/project key.

> **Privacy — read this before enabling.** Clarity is a **third-party tracking
> service** that can record how visitors move around your pages, including
> **session recordings and heatmaps**. That is sensitive personal data. Under GDPR
> and similar laws, behaviour recording is normally **consent-gated**, so you
> should: disclose the tracking in your privacy policy, integrate it with your
> cookie/consent tooling so it only loads after consent, and mask sensitive fields
> so they do not appear in recordings. Data is sent to Microsoft.

The module has no content or access-control role of its own beyond the permission
it adds to gate its settings. It has no module dependencies and works on Drupal
8.8, 9, 10, and 11. Note this is an early release (1.0.0-beta1).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — entering your Clarity project key and
   the privacy considerations.

## How to use it

After installing and enabling the module, you enter your Microsoft Clarity project
key on the module's settings form (see [Configuration](configuration/index.md)).
From then on the tracking snippet is added to your front-end pages and data begins
flowing to your Clarity/AdInsight dashboard. Wire it into your consent tooling
before going live so recording only starts once a visitor has agreed.
