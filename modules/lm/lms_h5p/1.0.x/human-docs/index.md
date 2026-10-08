# LMS H5P Activity — manual setup guide

**LMS H5P Activity** (`lms_h5p`) lets you use **H5P interactive content** as
activities in the Drupal [LMS](https://www.drupal.org/project/lms) module. H5P is
a widely-used open framework for interactive learning content — quizzes,
interactive video, presentations, flashcards, and dozens more content types — and
this module provides an H5P activity/answer plugin so course authors can drop that
content straight into an LMS course.

Learner results flow back into the LMS: answers are sent as **xAPI statements** to
a Learning Record Store and automatically scored in Drupal, provided you have that
side configured. Because of this, the module works together with **LMS XAPI** as
well as the base LMS and H5P modules.

The H5P content is authored course content, and access to it follows the LMS
course/activity access model — the module adds no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside LMS, H5P, and LMS XAPI.

LMS H5P has no settings form of its own — you add and configure H5P activities
within your courses (see "How to use it").

## How to use it

1. Install and set up LMS, the **H5P** module, and **LMS XAPI** (so results can be
   recorded and scored). See Installation.
2. In a course, add an **H5P activity** (the activity type this module provides).
3. Author or select the H5P interactive content for that activity.
4. As learners complete the H5P content, their answers are sent as xAPI statements
   to your configured LRS and scored automatically in Drupal.

This is a **1.0.0-alpha4** release, so treat it as early software.
