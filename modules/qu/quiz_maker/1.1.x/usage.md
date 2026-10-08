<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quiz Maker provides tools to create engaging quizzes and assessments, with questions, scoring and results.

---

Quiz Maker provides a quiz/assessment system for Drupal — building quizzes with various question
types, scoring, and results, for e-learning, engagement or knowledge checks. It builds on several modules
(Entity Reference Revisions, Inline Entity Form, Field Group, Views Bulk Operations, Entity Browser,
Editor, Datetime Range) and ships a `quiz_maker_export` submodule for exporting results. It provides its
own permissions.

Use it to create quizzes and collect responses/scores. The security/privacy-relevant points: quiz
responses and scores are user data (potentially tied to identifiable users), so gate access to results
appropriately (respondents shouldn't see others' answers/scores, and result exports contain personal
data). Verify who can create quizzes, take them, and view results via the module's permissions. Configure
question types and scoring.

---

- Create quizzes and assessments.
- Build questions with scoring.
- Show quiz results.
- Support e-learning/engagement.
- Export results (quiz_maker_export).
- Depend on ERR/IEF/Field Group.
- Provide its own permissions.
- Gate access to quiz results.
- Keep respondents from seeing others' answers.
- Treat responses/scores as user data.
- Protect result exports (PII).
- Verify who can take quizzes.
- Configure question types.
- Collect responses.
- Score assessments.
- Restrict result viewing.
- Build knowledge checks.
- Handle quiz data privately.
- Create engaging quizzes.
- Manage assessments.
