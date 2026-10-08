# Helpfulness — manual setup guide

**Helpfulness** (`helpfulness`) provides a simple feedback block that asks visitors
the familiar question: *"Was this helpful?"* The block shows a yes/no radio choice,
and when someone picks an answer, a comment area expands so they can leave additional
free‑text feedback. It is a lightweight way to gauge whether the content on a page is
actually useful to the people reading it.

You place the block wherever you want the question to appear, and an admin report
collects the submissions. The wording above and below the comment area is
customizable, and the module can send an email notification whenever new feedback
arrives. The report can include details such as the user's name, the helpfulness
rating, the message, the page URL, path and alias, the date and time, and browser
information.

A word on handling user input: the comment area accepts free text, which is user
input like any other. Feedback is meant to be reviewed by administrators, so make
sure it is escaped on display (to avoid stored‑XSS), and consider spam protection —
for example the [CAPTCHA](https://www.drupal.org/project/captcha) module — if you
expose the block to anonymous visitors. Use the module's permission to control who
may view the collected feedback.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — customize the block text, email
   notifications, and permissions, and place the block.

## Where it lives in the admin menu

The module's settings form is at `helpfulness.admin_form`
(**Configuration**, under the module's own entry). You place the feedback block from
**Structure → Block layout** (`/admin/structure/block`), and review submissions from
the module's feedback report.
