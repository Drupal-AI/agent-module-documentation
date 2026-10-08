# LMS XAPI — manual setup guide

**LMS XAPI** (`lms_xapi`) connects the Drupal
[LMS](https://www.drupal.org/project/lms) module to a **Learning Record Store
(LRS)** using **xAPI** (the Experience API, also known as Tin Can). As learners
interact with courses and lessons, the module emits xAPI statements —
actor–verb–object records of learning activity, such as "Alice *completed* Lesson
3" — to a configured LRS. That lets learning activity be tracked and analysed
centrally, across systems, which is the standard pattern for e-learning analytics
and compliance reporting.

It ships several submodules — `lms_xapi_activity` and `lms_xapi_lesson` (which emit
statements for activity and lesson events) and `lrs_xapi` (a minimalistic LRS for
storing scores and states, useful if you do not have an external LRS) — and it
provides a field formatter that can be used on any entity type, plus xAPI Package
activity-answer integration with LMS. It depends on core File and the LMS module.

Because it sends **learner activity data (who did what)** to the LRS endpoint,
there are real privacy and security considerations, covered in
[Configuration](configuration/index.md): the LRS credentials must be stored as
secrets, and learner activity — which can include personal data — leaves your site,
so consider consent and data-handling obligations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and the submodules you need) alongside LMS.
2. [Configuration](configuration/index.md) — connect an LRS: endpoint, credentials
   (stored as secrets), and the privacy/egress considerations.

## How to use it

1. Install and configure LMS, then enable LMS XAPI and the submodules that match
   what you want to track (activities, lessons, and/or the bundled `lrs_xapi`
   store).
2. Configure the connection to your LRS — its endpoint URL and authentication
   credentials (see Configuration).
3. As learners work through courses and lessons, xAPI statements are emitted to
   the LRS, where they can be reported on and analysed.

This is a **1.0.0-beta1** release and the project is minimally maintained (work in
progress), so test it carefully.
