<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LMS Answer Comments adds commenting to submitted answers, so teachers can give feedback and students can respond.

---

A mark is not teaching. The part of assessment that changes what a learner does next is the explanation — why this answer missed the point, what to read, what to try instead — and a system that stores a score and nothing else loses it.

This submodule attaches Drupal's comment system to answer entities, so feedback lives with the answer it is about. A teacher comments on a submission; the student sees it in context and can reply with a question rather than emailing separately and losing the thread.

Built on core's comment module, which means the usual machinery applies: comment access follows Drupal's permissions, comments are entities that can be moderated and deleted, and notification can be wired through whatever the site already uses.

The thing to decide per course is visibility. Feedback on an answer is between a teacher and a student in most settings, and cohort-visible in some — a code review class where everyone learns from each other's mistakes wants the opposite of a language assessment. That is an access decision the site has to make deliberately, since the comment system will do either.

---

- Give a student feedback on an answer.
- Explain why an answer was marked down.
- Let a student ask about their mark.
- Keep feedback with the answer it concerns.
- Thread a discussion about one submission.
- Moderate feedback comments.
- Notify a student that feedback arrived.
- Decide whether feedback is private or cohort-visible.
- Let students learn from each other's answers.
- Keep assessment feedback out of email.
- Delete feedback on request.
- Report on feedback volume.
- Support formative assessment.
- Audit who can read feedback.
- Encourage a dialogue rather than a grade.