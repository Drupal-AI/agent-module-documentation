# LMS Webform — manual setup guide

**LMS Webform** (`lms_webform`) integrates the **Webform** module with the Drupal
[LMS](https://www.drupal.org/project/lms) module, so that a webform can be used as
a **course activity**. That makes it easy to add a quiz, a survey, a reflection,
or an assignment step to a course by reusing a webform you have built, with the
webform submission tied into the learner's progress through the course.

It provides a **webform activity type**: you point an activity at an existing
webform, and learners complete that webform as part of the course. Webform access
and submission handling continue to follow the **Webform** module's own rules,
while course and enrolment access follow the **LMS** module — LMS Webform adds no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Webform and LMS.

LMS Webform has no central settings form of its own — you add webform activities
within your courses (see "How to use it").

## How to use it

1. Install and configure the **LMS** and **Webform** modules (see Installation).
   This module works with **LMS 1.1.3 and newer**.
2. Build the webform you want to use (quiz, survey, assignment, and so on) in the
   Webform module.
3. In a course, add a **webform activity** and point it at that webform.
4. Learners complete the webform as part of the course, and their submission feeds
   into their progress.

This is a **1.0.0-beta2** release, so test it for your use case.
