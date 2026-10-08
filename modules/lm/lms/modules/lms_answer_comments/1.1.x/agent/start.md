<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS Answer Comments (lms_answer_comments) — agent index

Submodule of **lms**. Comments on **submitted answers** — teacher feedback and student replies.
Version **1.1.18**. Core `^10.3 || ^11`. Depends on core `comment` and `lms`.

Built on core's comment system, so access follows Drupal permissions, comments are moderatable
entities, and notification can use whatever the site already has.

**Decide visibility per course, deliberately.** Feedback is teacher-to-student in most settings and
cohort-visible in some (a code review class wants the opposite of a language assessment). The
comment system will do either — the site has to choose.