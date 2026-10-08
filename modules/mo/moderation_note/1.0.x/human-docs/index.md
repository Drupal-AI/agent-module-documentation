# Moderation Note — manual setup guide

**Moderation Note** (`moderation_note`) adds an in-context editorial commenting layer
to content moderation. A reviewer can select some text in a field of a moderated
entity, click "Add note", and attach a comment to exactly that passage. Notes appear
in an off-canvas sidebar, can be replied to (so a discussion threads under a note),
can be assigned to a specific editor, and can be resolved, re-opened, or deleted —
all from the front end, without emailing feedback back and forth.

It is designed for editorial review of Draft revisions. Because it builds on core's
**Content Moderation**, reviewers can annotate the latest (unpublished) revision of
published content, leave feedback tied to the exact wording, and hand notes off to
whoever needs to act on them. Each editor gets an **Assigned notes** tab in their
toolbar and a list of their outstanding notes at `/user/{uid}/moderation-notes`. Notes
are also language-aware, so the same content can be reviewed independently in each
translation.

The module can send email notifications when notes are created, assigned, resolved,
re-opened, or replied to — this is on by default and controlled by a single toggle on
the settings page. Who can see and act on notes is governed by a set of permissions
that are deliberately tied to the moderated content's own access, so notes never leak
beyond the people who can already see the content. The module requires core's
**Content Moderation** and **User** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the email toggle, the prerequisites, the
   permissions, and how to grant reviewers access to Draft revisions.

## Where it lives in the admin menu

The single settings page is at **Configuration → Moderation note**
(`/admin/config/moderation-note`), reachable by anyone with the **Administer
moderation notes** permission. Everything else happens in context — reviewers add and
manage notes directly on the content they are reviewing.
