# Quiz Maker — manual setup guide

**Quiz Maker** (`quiz_maker`) is a robust system for building and taking quizzes and
assessments in Drupal — a modern alternative to the classic Quiz module. You build
quizzes from several question types, the module scores responses automatically (with
a manual‑grading mode for answers that need a human), and respondents get results
and feedback. It suits e‑learning, training, knowledge checks, and just‑for‑fun
quizzes.

The **1.x branch documented here** targets Drupal 9 and 10 and is still supported
for sites that have not yet moved to Drupal 11. (A separate 2.x branch adds staged,
branching quizzes for Drupal 11/12; upgrading from 1.x to 2.x is handled through
update hooks.) On 1.x you get these question types: **Boolean**, **single choice**,
**multiple choice**, **direct** (free‑text) answers, and **matching** questions.

Each quiz is highly configurable — you can set a server‑enforced timer, a pass rate,
an attempts limit, whether users may jump between questions or go backwards, whether
questions can be skipped or answers changed, whether the question order is
randomized, and a date window during which the quiz is available. Feedback can vary
by score, so a 90% pass and a 50% fail can show different messages. Anonymous users
can take quizzes and receive results, and quizzes and questions are fully
translatable. Results can be exported to PDF or spreadsheet via the **Quiz Maker
Export** submodule.

Quiz responses and scores are user data. Use the module's permissions to control who
may create quizzes, who may take them, and who may view results — respondents should
not be able to see other people's answers or scores, and result exports contain
personal data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   several contrib dependencies) and enable the module.
2. [Configuration](configuration/index.md) — build your first quiz, add questions,
   and set the per‑quiz options (timer, pass rate, attempts, navigation, and more).

## Where it lives in the admin menu

Quiz Maker adds quiz and question management to the admin content area and its own
permissions under **People → Permissions**. There is no single global settings form;
configuration is done per quiz as you create it — see
[Configuration](configuration/index.md).
