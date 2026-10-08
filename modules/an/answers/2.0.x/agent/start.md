<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Answers (answers) — agent index

Stack-Overflow-style **Q&A system** for Drupal. The top-level `answers` module is a **thin umbrella**:
its `answers.info.yml` declares one dependency, `answers:answers_core`, and its `answers.module` is
empty (comment header only). Enabling `answers` enables **`answers_core`**, which contains all
functionality. Package `Answers`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `2.0.x`
(installed from a git checkout; info.yml has no `version:` line).

## What it actually is

- No custom entities. A **Question** is a core node (`answers_question`), an **Answer** is a core
  comment (bundle `answers_answer`), and discussion uses two more comment bundles. All CRUD, access
  control and moderation are **standard core node/comment** — there are **no routes, no permissions.yml,
  no services, no custom queries** in this project.
- **No voting, best-answer or reputation** here. Those were separate Drupal 7 supporting modules; the
  drupal.org project description predates the 2.x rewrite and does not describe this codebase.

## Submodule (all the real code)

- **answers_core** — the node type, comment bundles, tags field, field formatter, hooks and theme.
  Documented separately → [modules/answers_core/2.0.x/agent/start.md](modules/answers_core/2.0.x/agent/start.md)

## Solution docs

- **Data model, entities, formatter, hooks, permissions to grant, how to operate it** →
  [architecture/model.md](architecture/model.md)
