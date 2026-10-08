<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LMS Core Answer plugins supplies the built-in question types — the activities a student can actually be asked to complete.

---

An LMS without question types is a course structure with nothing in it. This submodule provides the basic set, implemented as Activity/Answer plugins so each question type knows how to render its form, validate a submission and store an answer.

It is also the reference to read when adding a question type of your own, which is the common extension point. A site teaching something specific — code review, language pronunciation, safety procedure sign-off — usually needs one question type nobody has written, and the fastest route to it is copying the shape of an existing plugin rather than working from the interface alone.

Two design points worth noticing when you do. Answers are entities, so a custom question type's answer is queryable, reportable and deletable like any other content. And grading, where it applies, is part of the plugin's responsibility — which means a question type can be auto-marked, marked by a teacher, or a mix, and that decision belongs in the plugin rather than in the course.

---

- Ask a student a question.
- Collect a student's answer.
- Validate an answer on submission.
- Store answers as entities.
- Auto-mark an objective question.
- Leave a question for teacher marking.
- Add a custom question type.
- Copy an existing plugin as a starting point.
- Report on answers across a cohort.
- Delete a student's answers on request.
- Query answers for analytics.
- Build an assessment from mixed question types.
- Render a question form in a lesson.
- Support a domain-specific question type.
- Understand where grading logic belongs.