# Comment Submissions Limit — manual setup guide

**Comment Submissions Limit** (`comment_submissions_limit`) throttles how many
comments can be posted within a given time window. You can set the limit **per
comment type**, per **comment field value**, and per **time interval**, giving you
a simple rate‑limiting control that curbs comment flooding and spam without
resorting to a full CAPTCHA. It's a defensive guardrail: rather than filtering
content, it caps the *rate* at which comments arrive.

It's a close cousin of the [Comment Limit](https://www.drupal.org/project/comment_limit)
module — where Comment Limit caps the *total* number of comments a user may post,
Comment Submissions Limit focuses on **how quickly** comments can be submitted over
time. Use it when your concern is bursts of submissions rather than a lifetime cap.
It depends on core's Comment module and supports Drupal 10 and 11. This is a beta
release, so test it before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the submission limits and review
   the permission it adds.

## Where it lives in the admin menu

There's no separate settings page. You set the limits **per comment type** by
editing a comment type under **Structure → Comment types**
(`/admin/structure/comment/manage/{comment_type}`), in the **Comment Limit
Settings** section the module adds to that form. See
[Configuration](configuration/index.md) for how to define the limits.
