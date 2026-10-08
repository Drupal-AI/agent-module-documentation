# AI Content Intent & Journey Orchestrator — manual setup guide

**AI Content Intent & Journey Orchestrator** (`ai_cijo`, "AI CIJO") uses AI to
infer what a visitor is trying to do — their *intent* — and then arranges which
blocks and content they see along a configured *journey*. The result is a
personalised, intent‑aware experience: instead of showing everyone the same
static blocks, the site can adapt its layout to where a visitor appears to be in
their journey.

You configure the journeys, and AI CIJO handles the intent detection and the
dynamic arrangement of blocks and content as visitors move through them. It's
aimed at marketing and personalisation use cases where the right content in the
right order matters.

The intent detection runs through your configured AI provider, so it uses your
site's provider credentials and can incur a cost. Administration is gated behind
the **Administer AI CIJO** permission (`administer ai cijo`), so keep that to
trusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm an AI provider is configured.

## How to use it

After enabling the module (and with an AI provider configured), an administrator
with the **Administer AI CIJO** permission sets up one or more journeys, then
lets AI CIJO orchestrate which blocks and content each visitor sees as their
inferred intent places them along a journey. The orchestration draws on Drupal's
core **Block** and **Views** systems, which are the module's dependencies.

Requires Drupal 11.
