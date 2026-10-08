# Did This Help — manual setup guide

**Did This Help** (`did_this_help`) adds a simple "Did this help?" feedback block
to your pages. Visitors see a short question with **Yes** and **No** options; when
they answer **No**, they can pick from a list of ready-made reasons or type their
own comment. Each response is recorded (page path, page title, the message, the
user ID, and the IP address), so you can see at a glance how useful your content
is. A report of all answers is available at `/admin/reports/did-this-help`, and
the module includes Views integration for building your own reports.

The feedback prompt is a **block**, so it appears only where you place it. A
settings form lets you customize the question titles and the list of ready
answers. It provides its own permission, targets Drupal 10.1+/11 (and 12), and has
no external dependencies.

Under the hood the submission is a standard Drupal form, so it carries CSRF
protection, and stored strings are escaped to prevent cross-site scripting.

> **No flood control on votes.** There is no rate-limiting on submissions.
> Identical rows are de-duplicated, but a client that varies the free-text message
> can still flood the storage table. If you place the block for **anonymous**
> users, treat this as a low-severity spam / database-bloat risk: consider adding
> per-IP flood control and/or gating the block by permission for anonymous
> placements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block, customize the
   question and answers, set permissions, and find the report.

## Where it lives in the admin menu

The feedback prompt is placed as a block under **Structure → Block layout**
(`/admin/structure/block`). The settings form for the titles and ready answers is
reached from the module's **Configure** link on the **Extend** page. Collected
responses are reported at **Reports → Did this help?**
(`/admin/reports/did-this-help`).
