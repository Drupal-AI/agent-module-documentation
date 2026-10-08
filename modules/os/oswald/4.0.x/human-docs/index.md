# Oswald chatbot — manual setup guide

**Oswald chatbot** (`oswald`) embeds the chatbot widget from
[oswald.ai](https://www.oswald.ai) on your Drupal site and lets you configure it
from the admin UI. Visitors get a conversational assistant powered by the Oswald
platform; you decide which bot appears, on which pages, and how it behaves.

To use the module you need a valid account and **API credentials from oswald.ai**.
Each chatbot you add is identified by a **chatbot id** (found in the Oswald
platform under *Integrations » API »* the API Token). You can add multiple bots,
enable or disable each one, optionally have a bot auto‑open, choose the
environment (usually *production*), and set a display condition that controls
where the bot shows up.

A companion submodule, **search_api_oswald**, feeds your Drupal content into
Oswald's RAG (Retrieval‑Augmented Generation) system via Search API, so the
chatbot can answer questions about your own content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the Search API submodule.

There is no single settings form; you manage bots from the Oswald bots overview,
described below.

## Where it lives in the admin menu

Chatbots are managed at `/admin/config/oswald/bots`.

## How to use it

1. **Get your credentials.** Sign in at oswald.ai and copy the **chatbot id** from
   *Integrations » API » API Token*. Treat these credentials as secrets — store
   any API key/token in an environment variable rather than committing it (see the
   note in [Installation](installation/index.md)).
2. Go to `/admin/config/oswald/bots` and click **Add Oswald chatbot**.
3. Give it a name, paste the **chatbot id**, and set the options:
   - **Enabled / disabled** — whether the bot is live.
   - **Auto open** — optionally open the widget automatically.
   - **Environment** — choose **production** unless instructed otherwise.
   - **Display condition** — decide which pages show the bot.
4. Save. From the bots overview you can **test** a bot; if it's enabled and its
   display condition matches, it appears on the site.

> **Tip:** To auto‑open the widget on a specific page, append
> `?openOswaldWidget=true` to that page's URL — the bot opens once it has
> initialised.

To let the chatbot answer from your own content, enable **search_api_oswald**,
create a Search API server with your Oswald credentials, and add Title/Content and
URL fields to the index.

> **Upgrading from before 4.x?** An automatic upgrade path is included — update to
> the latest version and run your database updates.
