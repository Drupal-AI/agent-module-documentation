# Critique and Review Content — manual setup guide

**Critique and Review Content** (`critique_and_review`) adds a structured
review/critique workflow to your site, so that users with the right role can give
feedback on other users' content. It is built for peer review, editorial
proofreading, fact-checking, and any situation where a piece of content should be
looked over by someone else before — or after — it is published.

The heart of the module is a **Review Form** block that reviewers use to record
their feedback. As the administrator you define a set of **Review Items** — named
sections such as "Intro", "Body", and "Conclusion" — that give reviewers a
consistent structure to work through, each with its own guidance text. You choose
which content types reviews apply to, and you decide how much freedom reviewers get:
lock them to the Review Items you defined, or allow them to add their own ad-hoc
items as they go. Typical uses include an editorial workflow where sub-editors
proofread and fact-check work before publication, educational content that must be
reviewed before use, or an estate agent's property descriptions checked by senior
staff.

Setting the module up has two halves: configure the settings and Review Items on the
module's settings form, then place the **Critique and Review Block** in a region
(the sidebar is a natural choice) and restrict it to the right roles and pages. Both
are covered in [Configuration](configuration/index.md).

One thing to keep in mind: critiques are **user-submitted content** tied to their
authors. Apply the normal care you would with any user-entered text — sanitize it,
think about who may see and leave critiques, and moderate to prevent abuse. The
module has no dependencies and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, Review Items, and
   placing the review block.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Content authoring → Critique and
Review Module Settings**. The review block is placed and restricted from **Structure
→ Block layout** (`/admin/structure/block`).
