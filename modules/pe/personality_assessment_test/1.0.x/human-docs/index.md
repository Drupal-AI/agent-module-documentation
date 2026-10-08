# Personality Test — manual setup guide

**Personality Test** (`personality_assessment_test`) adds a front‑end,
DISC‑style personality quiz to your Drupal site. Visitors work through a fixed set
of 28 questions, and client‑side JavaScript scores their answers across the four
DISC traits — **Dominance (D)**, **Influence (I)**, **Steadiness (S)**, and
**Conscientiousness (C)** — expressing each as a percentage. When the quiz is
finished, the result is saved as a node so it can be referenced later.

The quiz lives at the path **`/personality-test`**, and the module also provides a
**Personality Test Quiz** block so you can embed the quiz anywhere blocks are
allowed. When a visitor completes the quiz, their computed result is posted back
to the site and stored as a new node of the **`personality_assessment_test`**
content type, with the respondent's user id and a formatted results table saved on
the node.

There is an important prerequisite: the module **expects the content type and its
two fields to already exist** — it does not create them for you. Before the quiz
can save anything, you must create a `personality_assessment_test` content type
with a user‑id field (`field_personality_test_user_id`) and a result field
(`field_personality_test_result`, using the *Full HTML* text format). Setup is
otherwise just enabling the module and linking to the page or placing the block —
there is no settings form, so everything you need is on this page.

> This project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** — there is no settings form. Setup is
the content‑type/field preparation and page/block placement described below.

## How to set it up

1. **Create the content type.** Go to **Structure → Content types → Add content
   type** and create one whose machine name is exactly
   `personality_assessment_test`.
2. **Add the two required fields** to that content type:
   - a field with machine name **`field_personality_test_user_id`** to hold the
     respondent's user id, and
   - a long‑text field with machine name **`field_personality_test_result`**,
     configured to use the **Full HTML** text format, to hold the formatted
     results table.
3. **Enable the module** (see [Installation](installation/index.md)).
4. **Expose the quiz.** Either link visitors to **`/personality-test`** from a
   menu or page, or place the **Personality Test Quiz** block via **Structure →
   Block layout** in whatever region you like.
5. Take the quiz yourself to confirm a `personality_assessment_test` node is
   created with the trait percentages recorded.

## How it works for a visitor

Opening `/personality-test` (or the block) presents the 28 questions. As the
visitor answers, JavaScript computes the D/I/S/C percentages. On submission the
result is sent back to the site, a results table is built, and a new node stores
it along with the visitor's user id — so a logged‑in user can return to their
saved result over time, and you can review submissions in the admin content list.
