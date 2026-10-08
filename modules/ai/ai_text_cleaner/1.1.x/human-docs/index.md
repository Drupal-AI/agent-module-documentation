# AI Text Cleaner — manual setup guide

**AI Text Cleaner** (`ai_text_cleaner`) cleans and normalizes text using AI —
fixing formatting, character-encoding problems, and stray boilerplate so that
messy imported or pasted content comes out tidy. It builds on Drupal's **AI**
module, which handles the actual model call.

Because the cleanup runs through the AI module, the text you ask it to clean is
**sent to whichever AI provider you have configured** (for example OpenAI,
Anthropic, or a locally hosted model). That is an external call, so only run it
on content you are comfortable sending to that provider. The provider API key is
stored as a secret in the AI module's configuration — a Key entity or an
environment variable — not by this module, and the call goes over HTTPS. As with
any AI output, **review the cleaned text** before you use or publish it.

The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the AI module is set up.

## Where it lives in the admin menu

This module builds on the AI module rather than adding a standalone settings
page. Before you can use it, an AI **provider** must be configured under
**Configuration → AI** (`/admin/config/ai`) — that is where the model and the
provider API key (a secret) are set.

## How to use it

With the AI module configured, run the cleaner over text that needs tidying —
fixing formatting, encoding glitches, or boilerplate. The text is sent to the
configured provider, and the cleaned result comes back for you to review.
Confirm that sending the content externally is acceptable, keep the provider key
stored as a secret, and check the output before publishing.
