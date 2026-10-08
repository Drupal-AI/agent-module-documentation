# n8n Chat — manual setup guide

**n8n Chat** (`n8n_chat`) embeds an [n8n](https://n8n.io)‑powered chat widget in
your Drupal site. Visitor messages are handed off to an n8n automation workflow
by way of a webhook URL, and that workflow can do whatever you have built into it
— call an AI model, query an API, look something up, and reply. The module is
the bridge between the chat widget on your pages and your n8n instance; the
actual conversational logic lives in n8n, not in Drupal.

You can surface the chat two ways: as a **global widget** that appears
site‑wide, or as a **block** you place in specific regions through the normal
Block layout. It supports light and dark themes plus custom CSS, tracks a
per‑visitor session (with a unique session ID and 24‑hour persistence so
conversations survive a page reload), lets users start a fresh conversation, and
can optionally pass user context to the workflow. It also works alongside
Drupal's AI Chatbot module. It depends only on core **Block** and **System**.

Because every message a visitor types is **sent from your site to your n8n
instance**, treat the webhook endpoint as a trusted, HTTPS‑only integration and
keep any webhook secret out of version control. See
[Configuration](configuration/index.md) for the data‑handling details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — point the widget at your n8n webhook,
   choose global‑widget vs. block placement, and store credentials safely.

## How to use it

At a high level: build a chat workflow in your n8n instance and copy its chat
webhook URL, paste that URL into the module's settings, then either turn on the
global widget or place the **n8n Chat** block where you want it. Once that is
done, visitors see a chat widget and their messages flow to your workflow. The
step‑by‑step field guidance is in [Configuration](configuration/index.md).
