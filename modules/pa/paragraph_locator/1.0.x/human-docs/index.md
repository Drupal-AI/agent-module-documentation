# Paragraph Locator — manual setup guide

**Paragraph Locator** (`paragraph_locator`) is a housekeeping tool for
paragraph‑based sites. It tracks **where paragraphs are used** across your content,
so administrators and content managers can find, review, and clean up paragraphs and
paragraph types — the sort of visibility you need when auditing a site, planning a
refactor, or tidying up components that have drifted out of use.

From its dashboard you can locate paragraphs, jump to the content that uses them,
and from there modify or delete paragraphs and their host entities. In other words
it is both a "find it" and a "manage it" tool for paragraph content that would
otherwise be buried inside nodes.

It is primarily **informational** — it reports where paragraphs are used — and it
provides its own permission so you control who can see that usage report. It has no
access‑control role beyond that permission (it does not change who may view or edit
your content); it simply surfaces usage to the people you allow. It requires the
**Paragraphs** module, is covered by Drupal's security advisory policy, and is
marked as receiving maintenance fixes only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant its permission.

There is **no settings form** for this module — it is a dashboard you use, not a
feature you configure.

## Where it lives in the admin menu

Paragraph Locator adds a dashboard under **Configuration → Content**
(`/admin/config/content/`). Grant its permission (see
[Installation](installation/index.md)) and open the dashboard as an administrator to
locate and manage paragraph usage.

## How to use it

1. Install and enable the module, and grant its permission to the roles that should
   be able to audit paragraph usage (see [Installation](installation/index.md)).
2. Open the Paragraph Locator dashboard under **Configuration → Content**.
3. Locate the paragraphs or paragraph types you're interested in, follow the links
   to the content that uses them, and modify or delete as needed — keeping in mind
   that deleting a paragraph removes it from the content that references it.
