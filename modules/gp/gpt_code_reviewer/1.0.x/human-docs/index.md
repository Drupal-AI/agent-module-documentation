# GPT code reviewer — manual setup guide

**GPT code reviewer** (`gpt_code_reviewer`) automates code review inside Drupal by
sending a block of code to an **OpenAI‑backed API** and storing the model's
feedback as a **Review** content entity. Each review is listed and displayed
through a bundled View and a custom field formatter, so you build up an audit trail
of AI code‑review feedback as content on your site. It is aimed at teams who want
quick, automated feedback — security‑smell detection, coding‑standards checks,
general suggestions — without the overhead of a manual review every time.

Architecturally, the module talks to a **GPT API server** (a separate service you
run, which relays to OpenAI). You configure that server's URL together with an
OpenAI API key and a model, and the module's `ReviewService` posts the code to it
and saves the JSON response as a Review entity. Review entities have a full
permission set — add, view, edit, delete and list — so you decide exactly which
roles can do what.

Two operational realities are worth being clear‑eyed about before you roll this
out. First, **every review is an outbound call to a paid LLM endpoint**, so the
ability to create a review is a cost‑bearing action — it is gated behind the
`add gpt_code_reviewer review` permission, which is **not** granted to anonymous
users by default. Second, this module stores the **OpenAI API key in plain
configuration** and shows it in a plain text field on the settings form: anyone
who can open that settings page can read the key. Treat the settings page as
secret‑bearing and grant its permission sparingly. The [Configuration](configuration/index.md)
page covers both points in detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and stand up the GPT API server).
2. [Configuration](configuration/index.md) — set the server URL, API key, model
   and timeout, and control who can trigger paid reviews.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → GPT Code Reviewer**
(`/admin/config/services/gpt_code_reviewer/settings`), protected by the
**Administer GPT code reviewer** permission (`administer gpt_code_reviewer`).
Reviews themselves are listed through the module's bundled View.
