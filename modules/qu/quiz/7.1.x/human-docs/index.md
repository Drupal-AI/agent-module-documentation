# Quiz — manual setup guide

**Quiz** (`quiz`) is a full quiz and assessment suite for Drupal. It lets you build
graded, interactive quizzes out of reusable questions, have people take them
online, score them (automatically or by hand), and record the results of each
attempt with configurable feedback. It suits online tests, certification exams,
training‑course assessments, and even surveys.

Version 7 is an entity‑based rewrite for Drupal 10/11. A **quiz** is its own content
entity that holds a set of **questions**; questions are reusable entities kept in a
shared "question bank" that you can pull into many quizzes (including at random).
Each attempt is stored as a **result**, made up of the individual answered
questions. Around this, Quiz integrates Views (question banks, result listings),
Rules (events and conditional feedback), and Views Bulk Operations.

Quiz on its own has no question types — you **must enable at least one question‑type
submodule** (multiple choice, true/false, short answer, long answer, matching) for
it to be usable. Global behaviour (revisioning, timer, result pruning, what a taker
sees afterwards) lives on one settings form; per‑quiz behaviour (attempts allowed,
pass rate, randomisation, time limit, navigation) is configured on each quiz.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the several
   dependencies, enabling Quiz, and choosing question‑type submodules.
2. [Configuration](configuration/index.md) — the global settings form, the
   per‑quiz options, the permissions, and how to create a quiz and read results.

## Where it lives in the admin menu

Quiz's admin area is under **`/admin/quiz`**. The global settings form is at
**`/admin/quiz/config/quiz`** (Administer quiz configuration permission); quiz
types, result types, and feedback types are managed under
**`/admin/quiz/config/structure`**. People take a quiz at `/quiz/{quiz}/take`.

## How to use it (in brief)

1. Enable Quiz **and at least one question‑type submodule** (see
   [Installation](installation/index.md)).
2. Create some **questions** in the question bank (for example a few multiple‑choice
   questions), marking the correct answers.
3. Create a **quiz**, set its options (attempts, pass rate, timer, randomisation),
   and add questions to it from the bank.
4. Grant the **take** permission to the roles who should attempt it.
5. Takers answer the quiz; auto‑scored types are graded immediately, while essay
   (long answer) responses wait in an "unevaluated results" queue for a human to
   grade. Results and feedback are shown according to your settings.

See [Configuration](configuration/index.md) for the details of each of these steps.
