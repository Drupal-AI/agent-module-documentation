# Azure AI FAQ Bot — manual setup guide

**Azure AI FAQ Bot** (`azure_ai_faq_bot`) adds a chat widget to your site that
answers visitors' frequently‑asked questions automatically. Behind the widget it
calls **Azure Cognitive Services** — Microsoft's cloud language/QnA service — to
understand what a visitor typed and return a relevant answer, so you can offer
first‑line support without staffing a live chat.

The widget is delivered as a **block**, so you place it wherever you want the chat
to appear (a sidebar, the footer, a support page) using Drupal's normal Block
Layout. The module depends on core's **Block** module and runs on Drupal 10 and 11.
Its administration is gated by the `administer azure_ai_faq_bot` permission.

Because the bot talks to Azure, every question a visitor asks is sent to Microsoft's
cloud — that has a cost and it means visitor text leaves your server, so keep it in
mind for privacy. The Azure credentials the module uses to authenticate should be
kept out of your committed configuration and supplied from the environment (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on depth:** this is a small, niche module and its upstream documentation is
> thin. This guide describes what the module does and how credentials should be
> handled; exact field labels on the settings form may differ slightly from what you
> see on screen.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — connect it to Azure Cognitive Services
   and place the chat block.

## Where it lives in the admin menu

Once enabled, configure the bot from its settings form and add the chat widget from
**Structure → Block layout** (`/admin/structure/block`) by placing the module's block
in a region. Only users with `administer azure_ai_faq_bot` can manage the bot's
settings.
