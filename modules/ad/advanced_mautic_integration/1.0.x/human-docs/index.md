# Advanced Mautic Integration — manual setup guide

**Advanced Mautic Integration** (`advanced_mautic_integration`) connects your
Drupal site to **Mautic**, the open-source marketing-automation platform. It adds
Mautic tracking and data integration — injecting the Mautic tracking script and
passing contact / token data — so activity on your site feeds into your Mautic
campaigns. It depends on the **Token** module and provides its own permission.

Two things to plan for before you turn it on. First, it enables **visitor
tracking**, which is a GDPR / consent consideration — combine it with your
cookie-consent tooling so the tracking script only runs when a visitor has
agreed. Second, where it talks to the Mautic API, it needs **credentials**: treat
those as secrets. Store them in environment variables (and a Key entity where
supported), never in committed configuration, and always point at the **HTTPS**
Mautic endpoint. Beyond its own permission, the module has no role in access
control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   ensure Token is present, and enable it.
2. [Configuration](configuration/index.md) — the Mautic endpoint, credentials
   (kept as secrets), and tracking, plus the permission and consent notes.

## Where it lives in the admin menu

The module provides a settings area where you enter the Mautic endpoint,
credentials, and tracking options, and a permission (set on **People →
Permissions**) that controls who may manage it. See
[Configuration](configuration/index.md).
