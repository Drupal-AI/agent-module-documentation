# ConfQ CFP — manual setup guide

**ConfQ CFP** (`confq_cfp`) provides a **call for papers** (CFP) for a conference —
the submission flow that lets conference organisers collect and manage paper and
talk proposals from prospective speakers. It is built on the **Webform** module:
it ships a ready‑made Webform template for the call for papers, plus a **track
chair** user role for the people who review incoming proposals. It is part of the
wider ConfQ conference toolset.

Because it is Webform‑based, most of the real setup happens in Webform itself:
ConfQ CFP gives you the starting form and the reviewer role, and you tailor the
form's fields, emails, and access from Webform's own UI. The project's stated
roadmap includes turning submissions into session nodes and adding track‑chair
voting on proposals, but the current release centres on the CFP form and the track
chair role. It depends on core **User** and the **Webform** contrib module, and
supports Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Webform dependency.

There is **no dedicated settings page** for this module — you configure the call
for papers by editing the Webform it provides and by assigning the track chair
role. See "How to use it" below.

## Where it lives in the admin menu

ConfQ CFP does not add a settings page of its own. The call‑for‑papers form lives
among your site's webforms at **Structure → Webforms**
(`/admin/structure/webform`), and the track chair role appears under **People →
Roles** (`/admin/people/roles`).

## How to use it

1. **Find the CFP webform.** After enabling the module, go to **Structure →
   Webforms** and open the call‑for‑papers form the module provides.
2. **Tailor it in Webform.** Use Webform's own tools to adjust the proposal
   fields, confirmation and notification emails, submission access, and open/close
   dates — everything you would normally configure on a Webform.
3. **Assign track chairs.** Give the **track chair** role to the people who will
   review proposals, at **People**. They are the reviewers for incoming
   submissions.
4. **Collect and review proposals.** Speakers submit through the webform;
   submissions are managed through Webform's results interface.
