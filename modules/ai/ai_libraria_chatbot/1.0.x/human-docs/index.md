# AI Libraria Chatbot Integration — manual setup guide

**AI Libraria Chatbot Integration** (`ai_libraria_chatbot`) embeds a chatbot from
the third-party **Libraria.ai** service on your Drupal site. Libraria hosts and
runs the chatbot; you build and train it on their platform, they give you a small
embed script, and this module's job is simply to output that script on your pages
so the widget appears. You do the AI work at Libraria — this is a thin, convenient
bridge that saves you from hand-editing templates.

Setup is deliberately simple: paste the embed snippet Libraria gives you into the
module's settings form, then place the **AI Libraria Chatbot** block in whichever
region you want the widget to appear. The block renders your stored script through
a template, and the chatbot loads from Libraria's service in the visitor's
browser.

One thing to be aware of: the embed script is **raw markup supplied by an
administrator** and is output as-is, so only trusted administrators should edit
that field, and you should paste only the snippet Libraria actually provides. The
module has no AI provider key of its own to manage — the connection to the AI runs
inside the Libraria widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — paste the Libraria embed script and
   place the block.

## Where it lives in the admin menu

- **Settings:** `/admin/config/chatbot/settings` (requires the **Administer site
  configuration** permission) — where you paste the Libraria embed script.
- **Block:** the **AI Libraria Chatbot** block, placed from **Structure → Block
  layout**, controls where the widget appears.

## How to use it

1. Create and train your chatbot at libraria.ai and copy the embed script it
   gives you.
2. Paste that script into the module's settings form.
3. Place the AI Libraria Chatbot block in a region so the widget shows on your
   pages. See [Configuration](configuration/index.md) for the details.
