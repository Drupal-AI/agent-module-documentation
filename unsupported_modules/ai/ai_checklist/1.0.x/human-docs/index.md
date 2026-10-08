# AI Checklist — manual setup guide

**AI Checklist** (`ai_checklist`) provides a guided checklist for setting up and
configuring the AI‑related modules on a Drupal site. It is built on the
[Checklist API](https://www.drupal.org/project/checklistapi) module and is
oriented toward DXPR CMS, but it works on any site as an onboarding aid.

The checklist walks an administrator through the steps needed to get AI features
working — choosing a provider, configuring credentials, turning on settings — and
records which steps are done. That gives a team a repeatable, shared path for
standing up the AI stack rather than everyone setting things up ad hoc and hoping
nothing was missed.

It is purely a **tracking and documentation tool**. AI Checklist does not change
any AI configuration itself and does not enforce anything — it simply lets you
tick off completed setup steps and see how far along the process is.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   Checklist API dependency, and turn on the module.

## Where it lives in the admin menu

Once enabled, the checklist appears as a Checklist API checklist
(`checklistapi.checklists.ai_checklist`). Open it, work through the AI‑setup
steps, and check each one off as you complete it — Checklist API records your
progress (and who checked what) so the whole team can see the current state of
the AI setup.
