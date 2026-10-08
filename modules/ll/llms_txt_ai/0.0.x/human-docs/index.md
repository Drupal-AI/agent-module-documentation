# llms.txt AI Generator — manual setup guide

**llms.txt AI Generator** (`llms_txt_ai`) automatically builds an `llms.txt` file
for your site using AI, so large language models — ChatGPT, Claude, Perplexity,
Gemini, and others — can understand your content when people ask them questions.
The emerging [llms.txt](https://llmstxt.org) standard is essentially an "executive
summary" of your site written for LLMs, and this module's twist is that it uses AI
to turn dry SEO text into natural language.

Its approach is menu‑first and hybrid. It pulls pages from your Drupal menus, reads
their existing meta descriptions (via the Metatag module), reformulates that text
into natural language with the AI module, and lets you add or override any
description by hand. One click generates the file, which is then published live at
`yoursite.com/llms.txt`. Generation runs on demand — not during page loads — and
the output is cached, so it doesn't slow your site.

Two things to keep in mind, since this is about publishing and about AI:

- **The generated `llms.txt` is public**, meant to be read by LLM crawlers. Only
  include content you intend to be publicly discoverable. The FAQ advice is to pick
  20–50 key pages, not your entire catalogue.
- **Generating the file sends your content and structure to the configured AI
  provider** (external egress, with the usual cost implications of AI calls).
  Confirm that's acceptable, and store your AI provider key as a secret through the
  AI module's key handling.

It depends on the **AI** module and the **Metatag** module (Metatag is strongly
recommended so meta descriptions can be extracted automatically; without it you add
descriptions manually), and it uses core's Menu UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the AI module
   with Composer, enable them, and set up your web server for `/llms.txt`.
2. [Configuration](configuration/index.md) — write the intro, pick menus, choose an
   AI provider, review descriptions, and generate the file.

## Where it lives in the admin menu

The generator lives at **Configuration → Content authoring → llms.txt AI
Generator**. That single screen walks you through the intro text, content sources
(menus and depth), AI settings, description review, and the **Generate llms.txt**
button.

## How to use it

1. Install and enable the module and the AI module, and configure at least one AI
   provider in the AI module.
2. Go to **Configuration → Content authoring → llms.txt AI Generator**.
3. Write a short introduction, select the menus to include, choose your AI provider,
   review/add descriptions, and click **Generate llms.txt**.
4. Your file goes live at `yoursite.com/llms.txt`.
