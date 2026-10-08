# Answers — manual setup guide

**Answers** (`answers`) is a Question & Answer system for Drupal — a
community‑knowledge feature in the style of Stack Overflow. Users post questions,
other users post answers, answers can be voted on, and a best answer can be chosen.
Over time this builds up a searchable body of community questions and answers on
your site.

The project ships a submodule, **answers_core** (`answers_core`), which holds the
core Q&A functionality; the top‑level Answers module depends on it. Posting and
voting are governed by the module's own permission model, so after installing you
decide which roles may ask, answer, and vote by granting the appropriate
permissions.

It is a community/engagement feature and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its submodule.

## Where it lives in the admin menu

Answers works through its own content and permissions rather than a single settings
page. After enabling, review **People → Permissions** for the Answers permissions
(who may ask, answer, and vote) and grant them to the appropriate roles.

## How to use it

1. Enable the module — this brings in the **answers_core** submodule that provides
   the actual Q&A functionality (see [Installation](installation/index.md)).
2. Grant the Q&A permissions to the roles that should be able to ask, answer, and
   vote.
3. Visitors and members then post questions, add answers, vote, and mark a best
   answer, building your community knowledge base.
