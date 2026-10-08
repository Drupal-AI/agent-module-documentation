# CKEditor Better Collapse — manual setup guide

**CKEditor Better Collapse** (`ckeditor_bettercollapse`) is a small plugin for
the legacy CKEditor 4 editor that improves how the toolbar collapses. CKEditor's
built-in collapser hides the *whole* toolbar; this one keeps the **first row
visible** and collapses only the second (and any subsequent) rows. The result is
a tidy single-row toolbar that expands to reveal the extra tools on demand —
handy for saving vertical space on dense forms.

It applies to editors that have exactly two toolbar rows. When enabled on a text
format, it sets the toolbar to start collapsed (second row hidden) and moves the
first-row buttons out of the collapsible area so they always stay in reach. It
adds no buttons of its own and only alters collapse behaviour — it is purely a UI
enhancement with no content or data changes.

Two caveats worth noting. This targets the **legacy CKEditor 4 editor** (core's
`ckeditor` module), not CKEditor 5, so it is really only relevant on sites still
running CKEditor 4 formats — for example during a CKEditor 4 → 5 migration. And
the project itself is marked **obsolete / minimally maintained**, reflecting
CKEditor 4's end of life.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** — you switch it on per text format
with a single checkbox, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on a format that uses the legacy **CKEditor 4** editor and
   has a two-row toolbar.
3. In the CKEditor settings for that format, tick **CKEditor Better Collapse
   enabled**.
4. **Save configuration**.

The toolbar for that format now starts with only its first row showing, and
editors can expand it to reveal the second row when they need it. The setting is
opt-in per format, so it is safe to leave off elsewhere.
