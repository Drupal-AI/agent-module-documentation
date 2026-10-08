# Content Feedback — manual setup guide

**Content Feedback** (`content_feedback`) gives your visitors and users a quick way
to send feedback about the page they're looking at, and gives your team a tidy
place to review it. It's aimed at content quality assurance: readers can flag that
a page is unhelpful, report a problem, or suggest an improvement, and site admins
work through those reports afterwards.

You choose which content types show the feedback form, and only users with the
right permission can see and submit it. The form is submitted over **AJAX**, so a
visitor can send feedback without leaving the page they're reading. On the admin
side, every submission is collected into an administrative list, grouped by status,
where an admin can review each item and mark it **Resolved**.

The module works once enabled, but you need to visit its settings form to pick the
content types it applies to and to hand out the relevant permissions, so treat it
as a **needs‑config** module. It has no dependencies beyond Drupal core.

Each submission is stored with the page URL, the submitter's IP address, and a
timestamp, so the collected list can contain personal data. Access is governed by
the module's own permissions: one permission controls who can see and submit the
form, and a separate permission controls who can view, edit, and resolve the
collected feedback — grant the latter only to the people who should read
submissions. Submitted text is escaped when it is stored and again when it is shown
in the admin list.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types get the
   form, set permissions, and manage the feedback list.

## Where it lives in the admin menu

Content Feedback's settings form is the `content_feedback.settings` route. If you
can't recall the exact path, open the **Extend** page (`/admin/modules`), find
Content Feedback in the list, and click its **Configure** link to jump straight to
the settings form. The collected feedback is reviewed from the module's
administrative feedback list, where entries are grouped by status.
