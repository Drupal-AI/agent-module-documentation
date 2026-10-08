<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnswersFormatter — the `answers_answer` comment formatter

File: `modules/core/src/Plugin/Field/FieldFormatter/AnswersFormatter.php`.
Class `AnswersFormatter extends CommentDefaultFormatter` (core comment module).

```
@FieldFormatter(
  id = "answers_answer",
  module = "answers_core",
  label = "Answers list",
  field_types = { "comment" },
  quickedit = { "editor" = "disabled" }
)
```

## What it does

Selected on the *Manage display* of the `answers_question` node for the **`answers` comment field**, it
renders the answer thread (and the add-answer form) beneath the question. It overrides only
`viewElements()`; it is a light copy of core `CommentDefaultFormatter::viewElements()` with the same
control flow, so behavior and **access checks match core**:

- Skips output for `HIDDEN` comment status, entity previews, and `search_result`/`search_index` view
  modes.
- Adds `user.permissions` cache context, then **only lists comments if the current user has
  `access comments` or `administer comments`**. Loads the thread with
  `$this->storage->loadThread($entity, $field_name, $mode, $comments_per_page, pager_id)` and renders via
  `$this->viewBuilder->viewMultiple(...)`, wiring a `#type => pager` whose `#route_name`/`#route_parameters`
  come from the current route so permalinks page correctly.
- Adds `user.roles` cache context, then **only appends the add-answer form when the field is `OPEN`,
  form location is `FORM_BELOW`, the view mode is not `print`, and the user has `post comments`**. The
  form is a `#lazy_builder` on `comment.lazy_builders:renderForm`.

There is **no user-supplied markup rendered raw** — comment bodies go through core's comment view builder
and field formatters (filtered text). No custom queries; thread loading is core `CommentStorage`.

## Settings

Inherited unchanged from `CommentDefaultFormatter` (`pager_id`, `view_mode`). Field-level comment
settings come from the `answers` comment field: `default_mode: 0` (flat), `per_page: 50`,
`form_location: true` (below), `preview: 1` (see `field.field.node.answers_question.answers.yml`).

## Operating it

- The `answers` field's install config already uses this formatter; on a fresh install nothing to do.
- To re-apply: node `answers_question` → *Manage display* → the *Answers* field → format **"Answers list"**.
- Applicable only to **comment** fields; it is intended for the question's `answers` field.
