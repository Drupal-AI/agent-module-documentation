# ChatGPT Plugin — manual setup guide

**ChatGPT Plugin** (`chatgpt_plugin`) is a lightweight connector that brings
OpenAI's ChatGPT into the Drupal editorial workflow. It adds three AI helpers for
content teams: a **content generator** (a link on the node add/edit page that opens
a popup where you can search ChatGPT and copy generated text into your content), a
**content translator** (a "Translate using ChatGPT" action on the translation tab
for languages that don't yet have a translation), and a **content assistance tool**
(a tab on the content admin page offering extras like generating images from text or
extracting SEO keywords). You can choose which OpenAI model to use — GPT‑3.5, GPT‑4,
or GPT‑4o mini — to suit your needs and budget.

It works by calling the OpenAI API, so it needs an **OpenAI API key**, which you
configure on the module's settings page along with the API endpoint and model
choice. Treat that key as a secret — keep it out of plain configuration (see the
installation guide for the DDEV/Key‑entity pattern). Be aware, too, that prompts and
the content you send for generation or translation **leave your infrastructure and
go to OpenAI**: that's a governance decision for anything confidential, and you are
responsible for ensuring AI‑generated content complies with OpenAI's terms and
policies.

Two practical notes. Generation calls are **billed by OpenAI**, so keep an eye on
usage and cost. And the translator produces flat text — OpenAI won't preserve HTML
or styling, so you re‑apply formatting after translating.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and store your OpenAI API key securely.
2. [Configuration](configuration/index.md) — the ChatGPT API settings (endpoint,
   access token, model).

## Where it lives in the admin menu

Once enabled, a **ChatGPT API Settings** link appears in the admin
**Configuration** area, where you enter the API endpoint, access token, and model.
The content‑generation and translation helpers then appear directly on the node
add/edit and translate pages, and the assistance tool as a tab on the content admin
page (`/admin/content`).
