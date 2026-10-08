# AI Upgrade Assistant — manual setup guide

**AI Upgrade Assistant** (`ai_upgrade_assistant`) helps you move custom and
contributed code onto newer versions of Drupal with AI doing some of the heavy
lifting. It builds on the **Upgrade Status** module, which scans your codebase and
flags deprecated APIs and compatibility problems, and then it uses your configured
AI model to suggest — or draft — the fixes for those issues. The goal is to shorten
the tedious part of an upgrade: instead of looking up each deprecation and
rewriting the code by hand, you get AI-generated suggestions to review and apply.

It is aimed at developers and site maintainers rather than content editors. It
works alongside Drupal's core **Update** system and Upgrade Status, and supports
Drupal 9, 10, and 11.

Two things to keep in mind. First, the AI operations run through whichever
provider you have configured in the AI module, so the analysis and fix generation
incur that provider's cost. Second, this is early software (version 0.3.x) — treat
its suggestions as a starting point to review, not a guaranteed correct patch.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Upgrade Status.

## Where it lives in the admin menu

The module adds two permissions — **`access upgrade assistant`** (use the tool)
and **`administer upgrade assistant`** (configure it) — which you assign under
**People → Permissions**. Users who hold the access permission can reach the
assistant's interface, where it presents the deprecations Upgrade Status found and
the AI-generated fixes.

## How to use it

1. Make sure the **AI** module has a working provider configured, with its API key
   stored as a secret.
2. Grant `access upgrade assistant` (and, for administrators, `administer upgrade
   assistant`) to the appropriate roles.
3. Let Upgrade Status scan your project, then open the assistant to review the
   AI-suggested fixes for the reported deprecations. Review every suggestion
   before applying it, and remember each analysis run uses AI-provider credit.
