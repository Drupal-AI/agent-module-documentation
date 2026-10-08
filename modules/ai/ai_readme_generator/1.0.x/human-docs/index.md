# AI README Generator — manual setup guide

**AI README Generator** (`ai_readme_generator`) uses AI to write **README.md
files for Drupal modules**. Instead of drafting module documentation by hand, you
point it at a module and it analyses the code and produces a README for you. It
builds on Drupal's **AI** module, which supplies the provider that does the
writing.

This is a developer convenience tool. It sends the module's code to the
configured AI provider and hands back generated Markdown. Treat that output as a
first draft: **review it before publishing**, because AI‑generated documentation
can be incomplete or wrong.

Two data‑handling points matter. The **module code is sent to the configured AI
provider** (external egress — confirm that is acceptable for the code in
question). And the provider's **API key is stored through the AI module's Key
configuration** as a secret, never in plain config. The module has no
access‑control role of its own.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. **Install and enable** the module (see [Installation](installation/index.md)).
2. **Configure an AI provider** in the AI module with its API key stored as a
   Key. This provider is what generates the README text.
3. **Generate a README** for the module you want documented, then **review and
   edit** the result before committing it. Remember the module's code is sent to
   your AI provider, so only run it on code you are permitted to share.
