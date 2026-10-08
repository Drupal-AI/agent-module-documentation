# LMS Membership Request — manual setup guide

**LMS Membership Request** (`lms_membership_request`) lets you mark a course in the
Drupal [LMS](https://www.drupal.org/project/lms) as **requiring membership
validation**. Instead of open self-enrolment, a learner who wants to join such a
course must submit a **membership request**, which then has to be
validated/approved before they gain course membership.

This adds an approval gate on top of LMS's normal access model. The gate governs
*enrolment* — whether someone becomes a member of the course — while access to the
course *content* itself continues to be governed by the LMS module once membership
is granted. Because approvers effectively decide who gets into a course, it is
worth verifying the approval workflow and being deliberate about **who can approve
requests**.

Under the hood it relies on Drupal's **Group Membership Request** functionality
(courses are Groups in LMS), and it builds on the **LMS Classes** submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside LMS Classes and Group Membership Request.

LMS Membership Request has no central settings form of its own — you mark
individual courses as requiring validation (see "How to use it").

## How to use it

1. Set up LMS with the **LMS Classes** submodule enabled, and install the **Group
   Membership Request** module (see Installation).
2. On a course, turn on the setting that marks it as **requiring membership
   validation**.
3. Decide who can approve requests, and confirm the approval workflow behaves as
   you expect — approvers are, in effect, granting course access.
4. Learners then request membership on that course, and an approver validates the
   request before they are enrolled.

This is a **1.1.0-beta4** release, and the project is minimally maintained
(maintenance fixes only), so test it thoroughly for your use case.
