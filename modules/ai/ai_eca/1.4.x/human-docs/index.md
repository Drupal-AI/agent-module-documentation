# AI ECA integration — manual setup guide

**AI ECA integration** (`ai_eca`) bridges the Drupal AI module with **ECA**
(Event – Condition – Action), Drupal's no-code automation system. It provides
ECA actions and conditions that let an ECA model invoke AI operations, so you
can trigger a language model from within a visual workflow without writing code.

> **Deprecated.** This module is deprecated and is being **removed in AI
> 2.0.0**. New sites should not build on it. If you are starting fresh, look for
> the current AI-plus-automation approach in the AI project rather than adopting
> `ai_eca`. This guide is provided for existing sites that still rely on it.

In use, you add AI actions or conditions to an ECA model just like any other ECA
plugin — for example, running a prompt at a certain point in a workflow and
using the result downstream. The AI operations run through whatever provider the
AI module is configured with, which means each run may incur provider cost.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with the deprecation caveat).

## Where it lives in the admin menu

AI ECA integration has no settings page of its own. You use it inside the **ECA**
model editor, where its AI actions and conditions appear alongside ECA's other
plugins. Configure the AI provider through the AI module as usual.

## How to use it

1. Make sure the AI module has a working provider, with its API key stored as a
   **Key** entity (never in plain config).
2. In your ECA model, add one of this module's AI **actions** or **conditions**
   at the point in the workflow where you want the AI to run.
3. Wire the AI result into the rest of your model.

Because each AI action calls the configured provider, keep an eye on provider
cost — and remember the module is on its way out, so treat any new dependence on
it as temporary.
