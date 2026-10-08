# Feedback AI — manual setup guide

**Feedback AI** (`feedback_ai`) analyses the **sentiment** of feedback submitted
on your Drupal site using the **OpenAI API**. It sends each piece of feedback to
an OpenAI chat model, which classifies it as **Positive**, **Negative**, or
**Neutral** — giving administrators a quick read on how users feel, and a basis for
triaging responses at scale.

Behind the scenes it uses OpenAI's Chat Completions API (models such as GPT‑4,
GPT‑4 Turbo, or GPT‑3.5 Turbo), so you need an OpenAI account and an API secret
key. Results are made available through Views, and the module depends on the
**Views Data Export** module so you can export the scored feedback for reporting or
further analysis.

Two things are worth planning for before you switch it on:

- **Cost.** Every feedback submission triggers an OpenAI API call, which is billed
  by OpenAI. On a busy site that adds up, so keep an eye on usage.
- **Privacy.** The feedback text is sent to OpenAI for analysis. Be mindful of any
  personal or sensitive data users might submit, and make sure that's acceptable
  under your privacy obligations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Views Data Export.
2. [Configuration](configuration/index.md) — connect the module to OpenAI with
   your API key and choose the model.

## Where it lives in the admin menu

Feedback AI provides a settings form where you configure the OpenAI connection
(under **Configuration**), and it exposes the analysed feedback through Views. It
also defines its own permission(s), so you can control who may administer the
module and view results — assign these under **People → Permissions**.

## How to use it

1. Obtain an OpenAI API secret key from the OpenAI platform.
2. Enter that key (and choose the model) on the module's settings form — see
   [Configuration](configuration/index.md).
3. As feedback is submitted on your site, the module sends it to OpenAI and records
   the resulting sentiment (Positive / Negative / Neutral).
4. Review the scored feedback through the module's Views output, and use **Views
   Data Export** to export it when you need a report.
