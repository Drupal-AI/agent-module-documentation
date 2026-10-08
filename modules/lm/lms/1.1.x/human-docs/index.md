# LMS — manual setup guide

**LMS** (`lms`) is the core of a Learning Management System for Drupal. It gives
you the building blocks of online learning as entities: **courses** that contain
**lessons**, lessons that contain **activities** (the units of work), and
**answers** that learners submit — with each learner's progress derived from those
answers. It is designed to be modular and to integrate with the rest of Drupal
rather than to be a closed, all‑in‑one distribution. (LMS began as a fork of the
Opigno distribution but was rewritten from the ground up for Drupal 10.3 and
above.)

The design decision that shapes everything is that LMS is **built on the Group
module**. A course *is* a group, enrolment *is* group membership, and the whole
permission model — who may see a course, who may take it, who may edit it, who may
see other people's answers — is Group's model, applied per course rather than
site-wide. That is what separates a real LMS from a content type called "Course":
you can run a hundred courses with different instructors and different cohorts
without building a bespoke access layer. Because of this, expect to do some
site‑building: enabling the pieces you need, adding Views, and theming, rather than
flipping a single switch.

Its permissions reflect that entity-based granularity — `administer lms` (an
access‑restricted permission), plus create/use permissions per entity type with
sensible defaults (for example, *create lms_activity entities* also grants viewing
and editing your own activities by default). The module also ships **Single
Directory Components** (`course_card`, `course_navigation`, `lesson_item`,
`activity_item`, `course_status`, `start_link`, `toolbar_icon`), so the
learner-facing UI is themeable through the component system rather than template
overrides alone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install LMS and its Group dependency
   with Composer, enable it, and choose which submodules you need.

LMS has no single central settings form — it is configured by site-building
(creating courses as groups, defining activity types, adding Views and theming).
The workflow is outlined in "How to use it" below.

## How to use it

At a high level, setting up a working LMS looks like this:

1. **Enable the answer plugins.** Turn on `lms_answer_plugins` (see Installation)
   to get the built-in question/activity types. This is also the extension point
   if you later want a custom question type.
2. **Create a course.** Because a course is a Group, you create it as a group,
   which gives you its membership and per-course access model out of the box.
3. **Add lessons and activities.** Build up the course's lessons, and within them
   the `lms_activity` entities that learners work through.
4. **Enrol learners** as members of the course group, and assign instructors the
   appropriate roles within that group.
5. **Let learners submit answers**, which are stored as entities and drive each
   learner's progress through the course.
6. **Theme the experience** using the shipped SDC components and Views, so the
   course, navigation, and status displays match your site.

Several ecosystem modules extend this core — certificates, file-upload and webform
activities, SCORM and H5P and xAPI, notifications, and more — each documented as
its own project.

## Where it lives in the admin menu

LMS does not add a single top-level settings page. Its entity types, permissions
(**People → Permissions**), and Group-based courses are managed through the
relevant areas of the admin UI, and the learner-facing course pages live on the
front end.
