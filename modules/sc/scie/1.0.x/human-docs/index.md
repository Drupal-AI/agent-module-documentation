# Semantic Content Impact Engine (SCIE) — manual setup guide

**Semantic Content Impact Engine** (`scie`) scores the quality of your content and
gives editorial teams a way to measure and govern it. It analyses each node across
four dimensions — **Structural Quality** (title, depth, word count), **Readability**
(Flesch Reading Ease, sentence and paragraph structure, headings), **Semantic
Quality** (vector-similarity analysis, academic vocabulary, professional writing
patterns) and **Content Richness** (lexical diversity, named entities, statistical
terminology) — and combines them into a single 0–100 score. It presents the
results on an accessible, sortable, colour-coded dashboard so editors can see at a
glance which content is strong and which needs work.

A notable design point: SCIE runs entirely inside Drupal in pure PHP with **no
external services, no API keys and no extra installations**, so it works on shared
hosting and managed platforms alike. It depends only on core's **Node** module and
supports Drupal 10 and 11.

The module is built to **work immediately with no configuration** — when you enable
it, a `field_scie_score` field is created on all content types and your existing
content is scored right away. Optionally, it can also **block publishing** of
content that falls below a minimum score (a configurable threshold, default 50),
show real-time validation while editing, and even "self-learn" by studying content
you mark as an *Editor's Pick* to tune its semantic weights over time. Advanced
settings are available for power users, but you do not have to touch them to get
value.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — the optional publish threshold,
   self-learning and the scoring dashboard.

## How to use it

Once enabled, SCIE scores all existing content automatically and adds a score to
each node going forward. Open the SCIE dashboard to review scores across your site
— columns are sortable and results filterable, and each score is colour-coded
(Excellent / Good / Needs Improvement / Poor). As editors create or edit content,
the score updates in real time; if you have turned on the publish threshold, any
content below the minimum is held back from publishing with a clear message
showing its current score and the required minimum.
