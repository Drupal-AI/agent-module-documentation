Answers is a Stack-Overflow-style Question & Answer system for Drupal, built entirely on core node, comment and taxonomy entities.

---

Answers turns a Drupal site into a Q&A community. Enabling the top-level `answers` module pulls in its one submodule, `answers_core`, which does all the work: it installs a `Question` node type (`answers_question`), a tagging field backed by the Tags taxonomy vocabulary, and three comment bundles that model answers and their discussion — `answers_answer` (an answer to a question), `answers_question_comment` (a comment on a question) and `answers_comment` (a comment on an answer). A custom comment field formatter (`answers_answer` / `AnswersFormatter`) renders the answer thread beneath each question, and template + CSS/JS overrides give the pages a Stack-Overflow-like layout where comment/answer forms are revealed inline on click. Because everything is core entities, questions, answers and comments are created, edited, moderated and access-controlled with standard Drupal node and comment permissions — there are no bespoke routes, endpoints, voting, best-answer or reputation features in this 2.x codebase (those were separate 7.x supporting modules). It is a drop-in way to build a community knowledge base without writing custom entity code.

---

- Add a community Q&A section to an existing Drupal 9/10/11 site.
- Let authenticated users ask questions at `node/add/answers_question`.
- Collect multiple answers per question as `answers_answer` comments on the question node.
- Let users discuss a question via `answers_question_comment` comments.
- Let users discuss a specific answer via `answers_comment` comments (comment-on-comment).
- Free-tag questions with the Tags taxonomy (`answers_tags`), auto-creating terms as needed.
- Browse questions by tag via the taxonomy term pages.
- Show an answer count ("No Answers" / "1 Answer" / "N Answers") on each question via the preprocess hook.
- Display a relative "Asked … ago" / "today" timestamp on question pages.
- Show a "Viewed N times" line when the core Statistics module is enabled.
- Reuse core comment moderation (publish/unpublish, delete) to manage answers and comments.
- Gate who can post questions/answers/comments purely through core node & comment permissions.
- Render answers with a custom formatter that respects `access comments` / `post comments`.
- Theme questions and answers with the module's Twig overrides as a starting point.
- Reveal the answer and comment forms inline via the bundled `answers_core/node` JS behavior.
- Build a searchable knowledge base (questions/comments are indexed by core comment search).
- Serve as a support-forum or FAQ alternative where discussion threads matter.
- Extend the model with additional fields on the `answers_question` node type via Field UI.
- Add view modes / displays to answers and questions through the shipped entity displays.
- Use as a foundation for a custom Q&A UX, since it is standard entities you can layer Views on.
- Provide an internal team knowledge-sharing space (questions + accepted-by-convention answers).
- Localize question tags (the `answers_tags` field is translatable).
