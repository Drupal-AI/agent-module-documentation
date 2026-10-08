# Quickchat — manual setup guide

**Quickchat** (`quickchat`) is an unofficial integration with the
[Quickchat](https://quickchat.ai/) conversational‑AI platform. The base module by
itself does one thing: it provides a **Quickchat API client service** that the two
submodules build on. Enable it and it quietly makes the client available — there is
nothing to configure on the base module itself.

The interesting features live in the submodules. **Quickchat Chatbot**
(`quickchat_chatbot`) lets you embed a Quickchat AI assistant on your site by
adding a `chatbot_block` block type where you set the Quickchat scenario. **Quickchat
Sync** (`quickchat_sync`) adds a `quickchat_kb` content type and matching view so
you can manage knowledge‑base entries that train your chatbot model, and it exposes
an admin screen to run the sync.

Because Quickchat is a hosted, multilingual AI assistant, this module talks to an
**external API**. Your API token is a credential to protect, and any content you
send to the chatbot or sync to your Quickchat scenario leaves your site and is
processed by a third party — confirm that egress is acceptable for the content
involved.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and turn on the submodules you need.
2. [Configuration](configuration/index.md) — where the Quickchat credentials and
   the sync/chatbot settings live, and how to store the API token safely.

## Where it lives in the admin menu

The base module has no page of its own. Once **Quickchat Sync** is enabled you
configure it at **Configuration → Web services → Quickchat API → Sync**
(`/admin/config/services/quickchat-api/sync`) and manage knowledge‑base entries at
**Content → KB** (`/admin/content/kb`). The chatbot is placed as a block (see
[Configuration](configuration/index.md)).

## How to use it

Get a **Scenario ID** and **API token** from the Quickchat dashboard at
`https://app.quickchat.ai/`. Enable the base module for the API client, then add the
chatbot block and/or configure the sync as described in Configuration.
