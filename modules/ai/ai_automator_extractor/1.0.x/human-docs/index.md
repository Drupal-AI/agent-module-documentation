# AI Automator Extractor — manual setup guide

**AI Automator Extractor** (`ai_automator_extractor`) is a plugin for the **AI
Automators** framework that pulls **structured data out of text** using an AI
model. Point it at some text and it extracts fields and values — entities,
attributes, and similar — as one step in a larger AI Automators workflow, so the
extracted data can flow on to populate fields or drive later steps.

It is not a standalone screen. You use it by adding it as a processor inside an AI
Automators chain, where it becomes one of the operations that runs when content is
created or updated. It depends entirely on the **AI Automators** module (part of
the AI ecosystem) for that plumbing.

Because it **sends text to your configured AI provider**, data leaves your site for
that provider — confirm that is acceptable for the content. The provider's API key
lives in the AI module's Key configuration as a secret. Importantly, treat the
extracted values as **untrusted**: an AI model's output is not guaranteed to be
correctly structured or safe, so **validate** what comes back before you rely on it.
This module adds no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the extractor from within an **AI
Automators** chain — it appears as an available Automator processor once enabled —
and it runs as part of that chain against a configured AI provider.

## How to use it

1. Set up the **AI Automators** module and an AI provider (key stored via the Key
   module).
2. In an AI Automators chain, add the **Extractor** step and configure what it
   should pull out of the source text.
3. When the chain runs, the extractor sends the text to the provider and returns the
   structured values. **Validate** those values before using them downstream — don't
   assume the AI output is well‑formed or safe.
