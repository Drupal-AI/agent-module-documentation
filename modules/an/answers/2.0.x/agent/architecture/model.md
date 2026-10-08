<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Answers — data model and operation

The `answers` project ships **nothing but a dependency**. Everything below is installed by the
**answers_core** submodule (`modules/core/`). This page summarizes the whole model so an agent does
not need to open the config files; see the submodule's own docs for formatter/hook detail:
[../../modules/answers_core/2.0.x/agent/start.md](../../modules/answers_core/2.0.x/agent/start.md).

## Install / enable

- `drush en answers -y` enables `answers` and, via the `answers:answers_core` dependency, `answers_core`
  and its core deps (`text`, `menu_ui`, `node`, `field_ui`, `comment`, `taxonomy`, `path`, `views`,
  `filter`). Config is installed from `answers_core`'s `config/install`.
- No settings form and no `configure` route — README states "The module has no menu or modifiable
  settings."

## Entities created (all core entity types)

- **Node type `answers_question`** (label *Question*) — `node.type.answers_question.yml`. New revisions on,
  preview optional, `display_submitted: true`. This is the **Question**.
- Fields on `answers_question` (from `config/install`):
  - `body` — standard node body (filtered text).
  - `answers` — a **comment field** (`field.storage.node.answers`, `comment_type: answers_answer`,
    cardinality 1, `per_page: 50`). Holds the **Answers**.
  - `answers_comments` — a comment field (`comment_type: answers_question_comment`) for **comments on the
    question**.
  - `answers_tags` — `entity_reference` to taxonomy `tags` vocab, `auto_create: true` (free tagging),
    translatable.
- **Comment bundles**:
  - `answers_answer` (target `node`) — an **answer** to a question.
  - `answers_question_comment` (target `node`) — a **comment on a question**.
  - `answers_comment` (target `comment`) — a **comment on an answer** (comment-on-comment).
  Each has a `comment_body` field and default form/view displays.
- **Taxonomy vocabulary `tags`** — installed as `config/optional` (reuses the standard Tags vocab).

## Field formatter

- `answers_answer` (class `AnswersFormatter`, `modules/core/src/Plugin/Field/FieldFormatter/`) extends
  core `CommentDefaultFormatter` to render the answers thread + inline answer form on the question page.
  It **honors core comment permissions**: only lists comments for users with `access comments` /
  `administer comments`, and only shows the add-answer form for users with `post comments`.

## Hooks (answers_core.module)

`hook_theme`, `hook_preprocess` (answer-count title, relative "Asked … ago", optional Statistics
"Viewed N times"), `hook_node_links_alter` (hides the statistics link on questions),
`hook_comment_links_alter` (removes the core reply link on answers/comments), `hook_module_implements_alter`.

## Permissions to grant (core, not module-provided)

There is **no `answers.permissions.yml`**. Use core node/comment permissions, e.g.:

- `create answers_question content`, `edit own answers_question content`, `delete own answers_question content`.
- `access comments`, `post comments`, `skip comment approval`, `edit own comments`.
- `administer comments` for moderation; `administer nodes` for full question moderation.

## Routes

None are provided by the module. Use core routes: ask at `node/add/answers_question`, view at
`node/{node}`, answer/comment via the inline comment forms rendered by the formatter.

## What is NOT here

No voting endpoints, no accept/best-answer route, no points/reputation, no flagging, no custom access
handler, no custom SQL. Treat security/access reasoning as core node+comment behavior.
