# AI AutoEvals — manual setup guide

**AI AutoEvals** (`ai_autoevals`) automatically scores how **factual** your AI
features' responses are. It runs AI‑generated answers through a **two‑step LLM
evaluation** — using a language model to judge the accuracy of another model's
output — so your team can measure and track the quality of the AI on your site
instead of relying on gut feel.

You organise the work into **evaluation sets** and review the **results** it
produces, building up a picture of how factual your AI features are and whether a
change made things better or worse. It is a quality‑assurance tool for AI, sitting
beside whatever AI features you already run.

The evaluations themselves run through the provider configured in the **AI** module
(with its key held via the **Key** module), so **every evaluation costs money** at
the provider. The module ships a set of permissions covering administration,
creating and viewing results and evaluation sets, and requeue/batch operations, so
you can control who runs and sees evaluations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it.

## Where it lives in the admin menu

AI AutoEvals is driven through its own screens for **evaluation sets** and
**results**, gated by its permissions (administer AI autoevals, plus results/sets
management and requeue/batch actions). Evaluations run against the provider you
configured in the AI module.

## How to use it

1. Configure an AI provider in the AI module, with its key stored via the Key
   module.
2. Grant the appropriate AI AutoEvals permissions to your QA/admin roles.
3. Build an **evaluation set**, run it, and review the **results** — each answer is
   scored for factuality via the two‑step LLM evaluation. Use requeue/batch actions
   to re‑run evaluations, and compare results before and after a prompt or model
   change to track whether accuracy is improving.
