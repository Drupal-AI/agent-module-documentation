<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# answers_core — hooks, library and templates

All in `modules/core/answers_core.module`, `answers_core.libraries.yml`, `templates/`, `css/`, `js/`.

## Hooks (answers_core.module)

- **`hook_theme()`** — registers theme suggestions with base hooks: `node__answers_question` (base
  `node`), `field__node__answers__answers_question` and `field__node__answers_comments__answers_question`
  (base `field`), and three comment suggestions
  (`comment__answers_comments__answers_answer`, `comment__answers__answers_question`,
  `comment__answers_comments__answers_question`, base `comment`).
- **`hook_preprocess(&$vars, $hook)`** — only acts when `$hook == 'node'` and a `node` route param exists.
  For `answers_question` nodes it:
  - Attaches library `answers_core/node`.
  - Sets `$vars['date']` to `'today'` if created < 86400s ago, else
    `date.formatter->formatInterval(now - created) . 'ago'`.
  - Computes the answer count from `content['answers']['#object']->answers[0]->comment_count` and sets
    `content['answers']['#title']` to *No Answers* / *1 Answer* / *@count Answers*
    (`formatPlural`-style via `t()`).
  - If `statistics` module is enabled, sets `$vars['viewed']` to a "Viewed N times" markup from
    `statistics.storage.node->fetchView(nid)`.
  - Note: the library is attached for **all** nodes, but the answers-specific logic runs only for
    `answers_question`.
- **`hook_node_links_alter()`** — on `answers_question` nodes, removes the core `statistics` link.
- **`hook_comment_links_alter()`** — for bundles `answers_answer`, `answers_question_comment`,
  `answers_comment`, removes the core `comment-reply` link (`$links['comment']['#links']['comment-reply']`).
- **`hook_module_implements_alter()`** — moves `answers_core`'s `node_links_alter` implementation to the
  end so it runs last.

## Library `answers_core/node` (answers_core.libraries.yml)

- CSS `css/answers.module.css` (layout weight) — flex/grid layout for questions, answers and the
  vote/action gutter; hides inline comment forms by default.
- JS `js/node.js` — `Drupal.behaviors.answersCore`: click handlers on
  `a.answers-question-comment-link` and `.node__links .links.inline .comment-add a` that `preventDefault`
  and **reveal the sibling/closest comment form** (`.show()`), hiding the trigger link. Contains leftover
  `console.log('Hello World')` debug output. Depends on `core/jquery`, `core/jquery.once`.

## Templates (`templates/`)

Twig overrides for the suggestions above, e.g. `node--answers-question.html.twig` (question layout with
"Asked {{ date }}", `{{ viewed }}`, an `.answers-question-grid`),
`field--node--answers--answers-question.html.twig` (adds an "Add a new Answer" heading around the
comment form), and comment templates for answers/question-comments. All output uses standard
auto-escaped `{{ content.* }}` prints — **no `|raw`**.
