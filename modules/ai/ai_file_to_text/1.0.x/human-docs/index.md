# AI File to Text — manual setup guide

**AI File to Text** (`ai_file_to_text`) extracts the text out of documents —
**Word, ODT, ODS, PDF, CSV and plain-text** files — and exposes that extraction
as **automators and agents** for the Drupal AI module. In practice it is the very
first step of most real AI pipelines: a model can only work with text, but most
of an organisation's knowledge lives in documents, so before you can summarize a
report, answer questions from a set of policies, or index an archive for
retrieval, you have to turn those files into text.

Exposing extraction as automators and agents (rather than as a plain service) is
what makes it composable — an extraction step can sit inside a larger automated
flow without anyone writing code to call it.

Two cautions belong with any use of this module. First, **document parsing is an
attack surface**: PDF and Office parsers have historically been a rich source of
vulnerabilities, and the input here is, by definition, a file someone uploaded.
Know which library handles each format, keep it patched, and consider isolating
the parsing of untrusted public uploads. Second, **extraction moves content
across a boundary**: text pulled from a private document and handed to a hosted
model has left your site, to whatever provider the AI module is configured with,
under that provider's terms. For an internal memo that may be fine; for anything
confidential or personal it is a decision to make deliberately, not discover.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its AI dependency.

## Where it lives in the admin menu

AI File to Text has no settings page of its own (`configure` is null). It
contributes extraction **automators** and **agents** that you use inside the AI
module's automator and agent tooling; there is nothing to configure directly.

## How to use it

1. Make sure the AI module is installed and, for any step that hands the text to
   a model, that a provider is configured with its API key stored as a **Key**
   entity.
2. Build an AI Automator (or agent flow) that includes an extraction step, and
   point it at this module's file-to-text automator for the format you're
   handling.
3. When the flow runs, the file's text is extracted and passed on to the rest of
   the pipeline — to summarize, index, embed, or store.

Keep the two cautions above in mind: patch your document parsers, and treat
extraction of confidential files as a deliberate transfer to your AI provider.
