# Admin Feedback — manual setup guide

**Admin Feedback** (`admin_feedback`) adds a "Was this helpful? Yes / No" widget to your
content pages, optionally collects a short follow-up comment, and gives administrators a
dashboard, per-page scoring, and CSV export of everything visitors submit. It is a quick
way to gauge which pages are working and which need attention.

The widget is a block you place on node pages. Visitors click Yes or No, and (if you leave
the follow-up enabled) can add one comment — either free text or a choice from
preset answers you define. All of the wording — the question, the button labels, the
thank-you responses, the follow-up prompt, and the preset answers — is configurable, and
the module keeps the results in its own database tables with a helpfulness score per page.

Behind the scenes the vote endpoint is hardened: votes must carry a per-page signed token,
only genuine Yes/No values on real nodes are accepted, submissions are rate-limited per IP,
and each vote can receive exactly one comment. Anonymous visitors can vote out of the box
(the *give feedback* permission is granted to anonymous and authenticated on install), so
abuse control is handled in code rather than by locking the feature down.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field, placing the
   block, the dashboards, and the permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Admin Feedback settings**
(`/admin/feedback/settings`). Results are reviewed at **Content → Feedback Dashboard**
(`/admin/content/feedback`) and per node at `/node/{nid}/feedback`. The widget itself is
placed through **Structure → Block layout**.
