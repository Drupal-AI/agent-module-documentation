# Azure AI Services — manual setup guide

**Azure AI Services** (`azure_ai_services`) is a base integration module that gives
Drupal the plumbing to call **Azure's AI / Cognitive Services** — Microsoft's cloud
services for language, vision and similar AI tasks. On its own it doesn't add a
visible feature to your site; instead it provides the connection and framework that
other modules or custom code build on so they can reach Azure AI capabilities.

Think of it as the shared "connector" layer: you configure the Azure connection once
here, and features that need Azure AI use that connection rather than each wiring up
their own. It runs on Drupal 10 and 11 and defines its own administration permission.

Because requests made through it send data to Azure, every call has a cost and sends
content to Microsoft's cloud. The credentials it uses to authenticate should be kept
out of committed configuration and supplied from the environment (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on depth:** this is a small connectivity module and its upstream
> documentation is thin. This guide describes its role and how credentials should be
> handled; exact field labels on the settings form may differ from what you see.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — supply the Azure endpoint and key.

## Where it lives in the admin menu

Once enabled, you configure the Azure connection from the module's settings form
(available to users with its administration permission). There is no front‑end
feature to place — other modules consume the connection this module provides.
