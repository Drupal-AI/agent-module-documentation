<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Answers Core (answers_core) — agent index

The submodule that implements the entire **Answers** Q&A system; the parent `answers` module only
depends on it. Package `Answers`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `2.0.x`.

Core dependencies (all Drupal core): `text`, `menu_ui`, `node`, `field_ui`, `comment`, `taxonomy`,
`path`, `views`, `filter`. **No** custom routes, `permissions.yml`, `services.yml`, config schema,
Drush commands, or custom queries.

## What it provides

- **Node type** `answers_question` (the *Question*), with fields `body`, `answers` (comment field →
  `answers_answer`), `answers_comments` (comment field → `answers_question_comment`), and `answers_tags`
  (entity_reference → Tags vocab, `auto_create`).
- **Comment bundles**: `answers_answer` (answer, target node), `answers_question_comment` (comment on a
  question, target node), `answers_comment` (comment on an answer, target comment).
- **Taxonomy** `tags` vocabulary (installed as optional config).
- **One plugin** — field formatter `AnswersFormatter` (id `answers_answer`), extends core
  `CommentDefaultFormatter`. → [fields/formatter.md](fields/formatter.md)
- **Hooks + theming** — answer-count heading, relative date, optional Statistics line, link alters,
  a `answers_core/node` CSS+JS library, and Twig overrides. → [theming/hooks.md](theming/hooks.md)

## Access model

All access is **core node + comment**. Grant `create/edit own answers_question content`,
`access comments`, `post comments`, etc. The formatter re-checks `access comments`/`post comments`
before listing answers or showing the add-answer form. No module-specific permissions exist.

## Solution docs

- [fields/formatter.md](fields/formatter.md) — the `answers_answer` comment formatter.
- [theming/hooks.md](theming/hooks.md) — hooks, library and templates.
