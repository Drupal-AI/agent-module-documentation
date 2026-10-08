# AI Provider: DXPR — manual setup guide

**AI Provider: DXPR** (`ai_provider_dxpr`) connects Drupal's AI module to **DXPR
AI**, the AI service offered alongside the DXPR Builder page-building product.
Once enabled and given DXPR credentials, DXPR AI becomes a selectable provider
wherever the AI module offers a provider choice, so AI features across the site
can route through DXPR.

Because it is tied to the DXPR product, this module depends on **DXPR Builder**
(version 2.7.5 or newer) in addition to the AI and Key modules. If you already run
DXPR Builder, this lets you reuse the same DXPR AI service through Drupal's common
AI interface rather than configuring a separate vendor.

The standard provider considerations apply: DXPR credentials are real and should
be stored via the **Key** module (kept out of plain configuration), and content
sent to DXPR leaves your infrastructure — so confidential content needs the usual
governance before you send it. The module is provider infrastructure; it has no
access-control behaviour of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI, Key and DXPR Builder dependencies.
2. [Configuration](configuration/index.md) — supply DXPR credentials securely and
   choose DXPR for AI operations.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including DXPR, are configured from the
**Providers** area under that section (`/admin/config/ai/providers`).

## How to use it

Make sure DXPR Builder (2.7.5+) is installed, enable this module, obtain your DXPR
credentials, store them as a Key entity, and register DXPR on the AI providers
page. Then select DXPR for the operations you want on the AI default-provider
settings. Send only content you are comfortable sharing with DXPR. Requires Drupal
10.3 or 11.
