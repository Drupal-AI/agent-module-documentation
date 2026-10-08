# DGA Feedback — manual setup guide

**DGA Feedback** (`dga_feedback`) is an accessible page-feedback widget for
public-sector and government sites. It asks visitors a simple question — "Was this
page useful?" — with Yes/No buttons, then optionally gathers a reason (from a
multi-select list tailored separately to Yes and No answers), free-text comments,
and optional demographic data (gender). Live statistics show the running
percentage and total count, and the widget resets itself after each submission.

The module is built to the **DGA (Digital Government Authority) Design System**
and ships with bilingual **English/Arabic** support that you manage entirely from
the admin UI — there are no `.po` files to edit. It adds its own admin section
with a **Feedback Dashboard** (browse, filter and bulk-manage submissions),
a **Settings** page (widget behavior, rate limiting, refresh delay, length
limits) and a **Translations** page for every visible string.

The widget itself is a **block**, so nothing appears on your site until you place
it. Access is role-based through three permissions, and because the widget can
collect demographic data you should handle submissions in line with your privacy
policy. It works on Drupal 10, 11, and 12 with no external dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the widget block, tune its
   behavior, manage translations, and assign permissions.

## Where it lives in the admin menu

Once enabled, DGA Feedback adds its own toolbar menu with three items:

- **Feedback Dashboard** — view submissions and statistics
  (`/admin/content/dga-feedback`).
- **Settings** — configure widget behavior, rate limiting and refresh delay
  (`/admin/config/dga-feedback/settings`).
- **Translations** — manage the English and Arabic text
  (`/admin/content/dga-feedback/translations`).

The feedback widget is displayed by placing the **DGA Feedback Widget** block
under **Structure → Block layout**.
