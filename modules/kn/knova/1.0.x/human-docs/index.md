# Knova — AI Chatbot Widget — manual setup guide

**Knova** (`knova`) adds a floating AI chatbot widget to your Drupal site, much
like Intercom or Zendesk. A chat icon sits in the corner of every front‑end page;
when a visitor clicks it, a chat window opens and they can ask questions about
your site, services, or products and get instant replies.

The answers come from **OpenAI's GPT models**. Rather than relying on a
third‑party knowledge platform, you train the bot yourself with simple
**question‑and‑answer pairs** based on your own content — each pair is a question,
an answer, and optionally a related page URL — so replies stay relevant to your
site. The widget is fully responsive and its appearance (colours, size, position,
logo, text) is customisable, and Knova includes **rate limiting** to keep API
usage under control.

Two things deserve care because every chat turn calls OpenAI. First, you configure
an **OpenAI API key** — that is a secret, so store it in an environment variable
rather than committing it (see [Configuration](configuration/index.md)). Second,
each conversation costs OpenAI credits and sends the visitor's message to OpenAI,
so keep an eye on cost and abuse and treat the rate‑limiting settings as part of
your setup, not an afterthought.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your OpenAI API key, style the
   widget, set rate limits, and create Q&A pairs.

## Where it lives in the admin menu

Once enabled, Knova's settings live at **Configuration → Services → Knova
Settings**. That single page is where you enable the widget, add your OpenAI API
key, choose the model, style the widget, and manage your Q&A pairs. When enabled,
the widget appears automatically on all front‑end pages.

## How to use it

Admins do the setup once: enter the OpenAI key, pick a model, style the widget,
add a handful of Q&A pairs, and enable it. Visitors then simply click the chat
icon and ask questions — the bot answers using your Q&A pairs and OpenAI, and can
include related page URLs in its responses.
