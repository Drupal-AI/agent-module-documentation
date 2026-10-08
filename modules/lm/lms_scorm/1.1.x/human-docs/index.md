# LMS SCORM — manual setup guide

**LMS SCORM** (`lms_scorm`) lets the Drupal
[LMS](https://www.drupal.org/project/lms) module load and play **SCORM packages**.
SCORM is a long-standing e-learning packaging standard used by authoring tools
(and older LMS platforms), and this module — a port of `opigno_lms` — lets you
upload those packages, play them inside an LMS training with an integrated SCORM
player, and have progress and scores committed back to the LMS. It also provides a
SCORM answer-type plugin so SCORM content can be used as a course activity.

One thing to understand about SCORM generally: the SCORM player runs in the
learner's browser, and tracking is committed through an endpoint bound to the
learner's session. That is inherent to SCORM's design — scores are ultimately
client-reported — so SCORM is well suited to training and self-paced learning, and
less suited to high-stakes assessment where the score must be tamper-proof.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside LMS.

LMS SCORM has no central settings form of its own — you set it up by creating a
SCORM activity type in your LMS courses (see "How to use it").

## How to use it

1. Install and configure the **LMS** module first (see Installation).
2. Create a new **Activity Type** that uses the **LMS → SCORM** field, so that
   activities of this type carry a SCORM package.
3. Upload a SCORM package to a SCORM activity in a course.
4. Learners play the package through the integrated SCORM player, and their
   progress/score is committed back to the LMS.

This release tracks the **1.1.x-dev** branch, so treat it as development software
and test it carefully.
