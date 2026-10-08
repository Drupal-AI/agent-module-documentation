# AI Content Cleanup — manual setup guide

**AI Content Cleanup** (`ai_content_cleanup`) helps you tidy up content that came
into your site from somewhere else — a legacy CMS, a spreadsheet import, or an
older Drupal site. Content migrated from another system almost always arrives
with rough edges: broken or leftover markup, inconsistent formatting, and small
inconsistencies that would take an editor a long time to fix by hand. This module
uses AI to spot those problems and help fix them, so imported content can be
normalized far more quickly.

The idea is to give editors cleanup workflows: the module detects issues in a
piece of content, and AI assistance proposes fixes you can apply. It is aimed
squarely at the post-migration phase, when you have a large body of content that
is "in" Drupal but not yet clean.

Because the cleanup runs through an AI model, the content being cleaned is sent to
the configured AI provider, and each run costs money against that provider's plan.
Treat that as a data-governance decision for anything confidential, and review the
AI's changes before trusting them. The module depends only on Drupal core's Node
and Text modules and works on Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm you have a working AI provider.

## How to use it

Once enabled, access is controlled by two permissions:

- **`access ai content cleanup`** — lets a user run the cleanup workflows on
  content.
- **`administer ai content cleanup`** — lets an administrator configure how
  cleanup behaves.

Grant `access ai content cleanup` to the editors who will normalize migrated
content, and keep the administer permission with trusted administrators. Point the
module at a batch of imported content, let it detect issues (broken markup,
formatting problems, inconsistencies), and review the AI-suggested fixes before
applying them — the AI output is a proposal, not a guarantee, so a human should
confirm the result.
