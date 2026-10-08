# TMGMT Extension Suit — manual setup guide

**TMGMT Extension Suit** (`tmgmt_extension_suit`) adds a layer of automation on
top of the **Translation Management Tool** (TMGMT). It brings three things to the
TMGMT job workflow: queue-based **bulk upload/download** of translation jobs so
sending and receiving happens in the background on cron; a **"track changes"**
feature that automatically re-submits content for translation when its source is
edited; and a set of **bulk actions** on the job overview (request, download,
cancel, delete, clear data).

It is aimed at sites with a lot of translation traffic — where sending jobs inline
would time out, or where source content changes often enough that keeping
translations in sync by hand is a chore. When "track changes" is on, editing a
source that already has translation jobs reopens and re-queues those jobs
automatically, so translations stay current.

The extra automation only applies to translator providers whose plugin opts in by
implementing the module's extended translator interface — so it's most useful with
a custom or compatible TMGMT translator. Everything is gated by TMGMT's own
**Administer tmgmt** permission; the module adds no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including TMGMT)
   and enable it.
2. [Configuration](configuration/index.md) — the settings form, "track changes",
   the cron queues, and the bulk actions.

## Where it lives in the admin menu

The module's settings form is a tab under TMGMT's own admin area at
**Administration → Translation → Settings** — specifically
`/admin/tmgmt/extension-settings` (requires **Administer tmgmt**). The bulk
actions appear on the TMGMT **Jobs** overview
(`admin/tmgmt/jobs`) as a bulk-operations form, and each action confirms on a
dedicated approval page.

## How it fits together

1. Configure one or more TMGMT translators whose plugin supports the extended
   interface.
2. Turn on **track changes** (globally and/or per provider + target language) on
   the settings form.
3. Send and receive translations in bulk from the job overview; the upload and
   download queues are processed on cron.

See [Configuration](configuration/index.md) for the details.
