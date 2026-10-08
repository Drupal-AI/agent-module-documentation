# Academic Applications — manual setup guide

**Academic Applications** (`academic_applications`) turns Drupal's Webform module
into an application system for academic positions. It solves a specific, awkward
problem: collecting a candidate's application *together with confidential letters
of recommendation*, and assembling the whole thing into a single, reviewable PDF.

Here is the flow it enables. An applicant fills in a program application form. The
module then lets you invite their referees to a **separate, secure upload form**
where each referee submits their recommendation letter as a PDF. Finally, a
**Bundle** button on the application submission merges the application answers and
all the recommendation PDFs into one downloadable PDF for the review committee.

The pieces are wired together by a **workflow** — a configuration entity that
links an application webform to its letters-of-recommendation webform. Each
referee reaches the letters form through a link that carries the application
submission's unguessable UUID in a `wt` query parameter, so their upload attaches
to the correct application. Access to the letters form is only as strong as the
secrecy of that link, so treat those invitation links as sensitive.

Operationally the module needs three things in place: Webform (version 6 or
later), Drupal's **private file system** (recommendation PDFs must never be
public), and a working **GhostScript** (`gs`) binary that PHP can execute, since
that is what merges the PDFs.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Webform / private-files / GhostScript prerequisites, and enable the module.
2. [Configuration](configuration/index.md) — build the two webforms, create a
   workflow linking them, invite referees, and bundle the final PDF.

## Where it lives in the admin menu

Workflows are managed under **Structure → Academic Applications Workflows**
(`/admin/structure/academic-applications-workflows`), and the module's own
settings form sits at `/admin/config/academic_applications/settings`. The Bundle
action appears as a tab on an individual webform submission.
