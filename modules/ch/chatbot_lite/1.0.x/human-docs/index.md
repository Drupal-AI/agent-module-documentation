# Chatbot Lite — manual setup guide

**Chatbot Lite** (`chatbot_lite`) is a lightweight, fully self‑contained chatbot
for simple FAQ‑style conversational help. Its whole point is that it uses **no
third‑party platform**: no OpenAI, no external AI service, no API keys, no outbound
network calls. Everything runs on your own site.

It answers questions in two ways. First, it matches against **question/answer pairs
you configure** in the admin form. If nothing matches, it falls back to searching
the **titles of selected content types** on your site and returns matching nodes as
links — so it can help visitors find existing content. If neither turns anything up,
it returns a fallback ("nothing found") answer you define. A chat form is exposed on
the site for visitors to use.

Because the node‑title search runs through Drupal's entity query system, it respects
the node access grants — the bot only surfaces content the current user is already
allowed to see. Matched titles are rendered as links in the answer. The bot performs no writes and involves no
credentials. Note this module is not covered by Drupal's security advisory policy
and is in maintenance‑fixes‑only status, so weigh that before using it on a
sensitive site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define the Q&A pairs, searchable
   content types, fallback answer, and ignored words.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Chatbot Lite**
(`/admin/config/system/chatbot_lite`, route `chatbot_lite.settings`), reachable by
users with the **Administer site configuration** permission. The visitor‑facing
chat form is served at `/chatbot_lite_form` (available to anyone with the **Access
content** permission).
