<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS Core Answer plugins (lms_answer_plugins) — agent index

Submodule of **lms**. The **built-in question types**, as Activity/Answer plugins.
Version **1.1.18**. Core `^10.3 || ^11`. Depends on `text`, `lms`.

**The extension point.** A site teaching something specific usually needs one question type nobody
has written; copying an existing plugin's shape is faster than working from the interface.

Two design points for a custom type: answers are **entities** (queryable, reportable, deletable),
and **grading belongs in the plugin** — auto-marked, teacher-marked or mixed is the plugin's
decision, not the course's.