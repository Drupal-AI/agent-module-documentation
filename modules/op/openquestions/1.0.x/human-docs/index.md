# OpenQuestions — manual setup guide

**OpenQuestions** (`openquestions`) is a voting module with an unusual goal: it
tries to surface the **best** content, not merely the **most popular**. The
maintainer's own example makes the point — a "brownie diet" would win a popular
vote on a site like Reddit, but it would be a poor answer if your goal is to
choose the *best* diet. Open, anonymous, unaccountable voting rewards popularity;
OpenQuestions is designed to reward quality instead.

It does that by changing who votes and how visible those votes are. Voting is
limited to a **select group of users** rather than everyone. Every vote is
**public**, and other users can **comment on individual votes** — so if someone's
votes look questionable, they can be called out openly and held accountable. The
result is a ranking model aimed at deliberation and Q&A rather than raw
crowd counts.

The module is built from Drupal core building blocks — it uses **Block**,
**Taxonomy**, and **Views** — so the questions, the vote listings, and the voter
pages are surfaced through blocks and views you place and arrange on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Development status:** This is an early alpha release (1.0.0-alpha1), and the
> maintainer has cautioned that the module is still under development and should
> not be relied on for live production sites until outstanding issues are
> resolved. Try it on a staging site first.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.

There is **no dedicated settings form** for this module. Its behaviour is expressed
through the blocks and views it provides plus Drupal's permissions, described in
"How to use it" below.

## Where it lives in the admin menu

OpenQuestions adds no single settings page. You work with it through:

- **Structure → Block layout** (`/admin/structure/block`) — to place its voting
  and results blocks.
- **Structure → Views** (`/admin/structure/views`) — to view or adjust the views
  that list questions and votes.
- **People → Permissions** (`/admin/people/permissions`) — to decide which roles
  belong to the "select group" allowed to vote.

## How to use it

1. After enabling the module (see [Installation](installation/index.md)), review
   the **permissions** it adds at **People → Permissions** and grant voting rights
   only to the trusted group of users you want to hold accountable — this
   restriction is central to how the module works.
2. Place the module's **blocks** from **Structure → Block layout** so visitors can
   see questions and cast or read votes.
3. Because votes are public and open to comment, make sure your commenting setup
   allows users to respond to individual votes — that public accountability is the
   mechanism that keeps voting honest.
