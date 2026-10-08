Answers Core provides all functionality of the Answers Q&A system: the Question node type, Answer/comment bundles, a tags field, a comment field formatter and theming.

---

Answers Core (`answers_core`) is the submodule that actually implements the Answers project — the top-level `answers` module simply depends on it. On install it creates a `Question` node type (`answers_question`) with a body, a free-tagging `answers_tags` taxonomy field (Tags vocabulary, auto-create), and three comment bundles that carry the Q&A discussion: `answers_answer` (an answer, exposed through the node's `answers` comment field), `answers_question_comment` (comments on a question), and `answers_comment` (comments on an answer). Its one plugin, `AnswersFormatter` (formatter id `answers_answer`), extends core `CommentDefaultFormatter` to render the answers thread plus an inline add-answer form, gated by core `access comments` / `post comments` permissions. Module hooks build the "N Answers" heading, a relative "Asked … ago" date, an optional Statistics "Viewed N times" line, and remove core reply/statistics links; a bundled CSS/JS library reveals comment forms inline on click, and Twig overrides supply a Stack-Overflow-like layout. It declares core dependencies only and adds no routes, permissions, services or custom queries.

---

- Install as the working half of the Answers project (auto-enabled by `answers`).
- Provide the `answers_question` node type used for questions.
- Provide the `answers_answer` comment bundle used for answers.
- Provide `answers_question_comment` and `answers_comment` bundles for discussion.
- Attach answers to a question via the node's `answers` comment field.
- Free-tag questions through the `answers_tags` entity-reference field.
- Auto-create taxonomy terms in the Tags vocabulary when tagging.
- Render the answer thread with the `answers_answer` field formatter.
- Show an inline add-answer form to users with `post comments`.
- Restrict answer listing to users with `access comments` / `administer comments`.
- Display an accurate answer-count heading on question pages.
- Show a relative "Asked … ago" (or "today") timestamp per question.
- Surface a "Viewed N times" statistic when core Statistics is enabled.
- Hide core's redundant reply link on answers and comments.
- Provide Twig template overrides as a theming starting point.
- Reveal comment/answer forms via the `answers_core/node` jQuery behavior.
- Extend the question node type with extra fields via Field UI.
- Add or reorder view/form displays for questions, answers and comments.
- Reuse core comment moderation for approving/removing answers.
- Serve as the entity foundation to layer custom Views listings (all questions, unanswered, by tag).
