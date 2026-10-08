# AI Block — manual setup guide

**AI Block** (`ai_block`) provides a placeable Drupal block that renders simple
AI‑generated output. An editor configures the block — giving it a prompt and
behaviour — and Drupal renders the AI's response in whatever region you place the
block. It's a lightweight way to surface AI content on a page without writing a
custom module.

Under the hood the block calls the AI module's configured provider, so every time
the block renders it uses your site's provider key and can incur a per‑request
cost. Because the block's configuration is what drives the prompt sent to the
model, keep the ability to place and configure AI blocks to **trusted editors**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure an AI provider is configured.

## How to use it

AI Block does not add a dedicated settings page — you work with it through
Drupal's normal **Block layout** tools:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the AI output to appear and
   choose the **AI Block** from the list.
3. In the block's configuration form, set the prompt / behaviour that the block
   should send to the AI provider, then save.
4. The block now renders the AI‑generated output in that region for visitors who
   can see it.

Because output comes from a live AI call, think about caching and cost: a block
that regenerates on every page view multiplies provider usage. Depends on core
`block`, `config`, and the `ai` module. Works on Drupal 10 and 11.
