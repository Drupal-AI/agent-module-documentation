# AI Natural Language Test — manual setup guide

**AI Natural Language Test** (`ai_nl_test`) lets you describe a test in plain
English and have AI turn it into an automated test. Instead of hand-writing test
code, a developer or QA person writes what the test should check in natural
language, and the module uses your configured AI provider to generate and/or run
an automated test against the site. The goal is to lower the barrier to writing
test coverage so more of it actually gets written.

It is a developer/QA add-on to the Drupal AI ecosystem. Every operation runs
through whichever provider you have configured in the core **AI** module, so
there is a per-call cost, and the provider's API key is stored as a secret
through the **Key** module (backed by an environment variable). Beyond the AI and
Key modules it depends only on core's **System**, **Serialization**, and **File**
modules.

Access is gated by the module's own permissions, so you decide which roles can
author and run these AI-generated tests.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI and Key dependencies.

## Where it lives in the admin menu

The AI provider it uses is configured in the **AI** module's own settings, and
the API key is managed under the **Key** module. Use the module's permissions to
control who can work with the natural-language tests.

## How to use it

Write out, in plain language, what a test should verify, and let the module
generate the automated test from that description — then run it against the site.
Because each generation and run is an AI provider call, start with a few focused
tests, review what the AI produced, and confirm it checks what you actually
meant before relying on it.
